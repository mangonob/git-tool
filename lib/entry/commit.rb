require 'time'
require_relative 'git-object'
require_relative 'conventional'

module GitTool
  class Commit < GitObject
    def message
      `git show -s --format=%B #{self.sha1 || self.naem}`.strip
    end

    def conventional
      ## Strip each line, and remove empty lines
      pretty_message = self.message.lines.map(&:strip).reject(&:empty?).join("\n")
      choice_type_pattern = ConventionalType.constants.map(&:to_s).join("|")
      conventional_pattern = /^(#{choice_type_pattern})(\((.*)\))?(!?)[:：](.*)/im
      matched = pretty_message.match(conventional_pattern)

      begin
        raise "bad matched" unless matched

        type = matched[1]
        submodule = matched[3]
        breaking_change = matched[4]
        message = matched[5] && matched[5].lines.map(&:strip).reject(&:empty?).join(" ")
        raise 'no message' unless message

        raise "bad conventional type" unless ConventionalType.constants.index type.upcase.to_sym
        conventional_type = ConventionalType.new type.upcase
        return Conventional.new(
          message && !message.empty? && message || nil,
          type: conventional_type, 
          submodule: submodule && !submodule.empty? && submodule || nil,
          breaking_change: breaking_change && !breaking_change.empty? || false,
        )
      rescue RuntimeError => error
        return Conventional.new pretty_message.lines.map(&:strip).join(" ")
      end
    end
  end
end

class String
  def to_commit
    GitTool::Commit.sha1(self.strip)
  end
end