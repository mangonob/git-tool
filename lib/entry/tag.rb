require_relative 'git-object'

module GitTool
  class Tag < GitObject
  end
end

class String
  def to_tag
    GitTool::Tag.parse(self.strip)
  end
end