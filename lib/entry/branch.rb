require_relative 'git-object'

module GitTool
  class Branch < GitObject
  end
end

class String
  def to_branch
    GitTool::Branch.parse(self.strip)
  end
end