require_relative 'git-object'

module GitTool
  class GitRange
    attr_accessor :from, :to

    def initialize(from, to)
      raise 'bad type' unless from.is_a?(GitObject) and to.is_a?(GitObject)
      self.from = from
      self.to = to
    end

    def rev_list(*args, **kwargs)
      options = kwargs.map do |entry|
        key, value = entry 
        "--#{key || ''}=#{value || ''}"
      end

      `git rev-list #{from.sha1 || from.name}..#{to.sha1 || to.name} #{[options + args].join(' ')}`
        .lines.map &:to_commit
    end

    def empty?
      rev_list.empty?
    end
  end
end