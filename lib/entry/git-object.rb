module GitTool
  class GitObject
    attr_accessor :name, :sha1

    private :name=, :sha1=

    def initialize(name, sha1=nil)
      self.name = name
      self.sha1 = sha1
      self.sha1 = `git rev-parse #{name}`.strip if name unless sha1
    end

    def rev_list(*args, **kwargs)
      options = kwargs.map do |entry|
        key, value = entry 
        "--#{key || ''}=#{value || ''}"
      end

      `git rev-list #{self.sha1 || self.name} #{[options + args].join(' ')}`.lines.map &:to_commit
    end

    def time
      Time.parse `git show -s --format="%ci" #{self.sha1 || self.name}`.strip
    end

    def root
      `git rev-list --max-parents=0 #{self.sha1 || self.name}`.to_commit
    end

    def contains?(other)
      raise 'bad implement :todo:'
      raise "missing sha1 id" unless self.sha1 && other.sha1
      not `git rev-list #{self.sha1} | grep #{other.sha1}`.lines.empty?
    end

    class << self
      def parse(name)
        self.new(name)
      end

      def sha1(sha1)
        self.new(nil, sha1)
      end
    end
  end
end