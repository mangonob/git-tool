##
# Author: 高炼
# Created At: 2020年10月21日

require_relative 'lib/git-tool'

Gem::Specification.new do |spec|
  spec.name = "git-tool"
  spec.version = GitTool::Version
  spec.author = "mangonob"
  spec.email = "mangonob@qq.com"
  spec.summary = "Git tool"
  spec.license = "MIT"
  spec.homepage = "https://github.com/mangonob/git-tool"
  spec.description = ""
  spec.executables = [
    "git-doc", 
  ]
end