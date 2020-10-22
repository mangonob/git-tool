require_relative 'git-object'
require_relative 'conventional'

module GitTool
  class Commit < GitObject
    def message
      `git show -s --format=%B #{self.sha1 || self.naem}`.strip
    end

    def conventional
      first_line = message.lines[0]
      throw "bad commit message" unless first_line
      conventional_pattern = /([a-z]*)(\((.*)\))?(!?): (.*)/i
      matched = first_line.match(conventional_pattern)

      begin
        type = matched[1]
        submodule = matched[3]
        breaking_change = matched[4]
        message = matched[5]
        throw "bad conventional type" unless ConventionalType.constants.index type.upcase.to_sym
        conventional_type = ConventionalType.new type
        return Conventional.new(
          type: conventional_type, 
          message: message && !message.empty? && message || nil,
          submodule: submodule && !submodule.empty? && submodule || nil,
          breaking_change: breaking_change && !breaking_change.empty? || false,
        )
      rescue => error
        return Conventional.new type: ConventionalType::FEAT, message: first_line
      end
    end
  end
end

class String
  def to_commit
    GitTool::Commit.sha1(self.strip)
  end
end