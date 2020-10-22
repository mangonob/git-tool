require_relative 'branch'
require_relative 'commit'

module GitTool
  class Repository
    ## Hash of Git config
    attr_accessor :config

    def initialize # :nodoc:
      throw ".git/ not found" unless File.exist?(".git")

      self.config = {}

      `git config -l`.each_line do |line|
        line.strip!
        path, config = line.split("=", 2)
        self.config.set_path(config, *path.split(".").map(&:to_sym))
      end
    end

    ## User name in Git config
    def user_name
      return self.config.get_path(:user, :name)
    end

    BRANCH_SHORT_FORMAT = "--format='%(refname:short)'" # :nodoc:

    ##
    # Get list of local branches. If no local branch in repo, return empty list.
    #
    def local_branches
      return `git branch #{BRANCH_SHORT_FORMAT}`.lines.map &:to_branch
    end

    ##
    # Get list of remote branches. If no remote branch in repo, return empty list.
    #
    def remote_branches
      return `git branch -r #{BRANCH_SHORT_FORMAT}`.lines.map &:to_branch
    end

    ##
    # Get list of all branches. If no branch in repo, return empty list.
    #
    def all_branches
      return `git branch -a #{BRANCH_SHORT_FORMAT}`.lines.map &:to_branch
    end

    ##
    # Get current branch name
    #
    def current_branch
      return `git branch --show-current`.to_branch
    end

    def tags
      return `git tag`.lines.map &:to_tag
    end
  end
end

class Hash
  def get_path(*path)
    current = self
    path.each do |comp|
      current = current[comp]
      return current unless current.class == Hash
    end
  end

  def set_path(value, *path)
    *head, tail = path
    current = self
    head.each do |comp|
      step = current[comp]
      current[comp] = {} if step.class != Hash
      current = current[comp]
    end
    current[tail] = value
  end
end