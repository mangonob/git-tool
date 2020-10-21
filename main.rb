#!/usr/bin/env ruby

require_relative 'lib/git-tool'

repo = GitTool::Repository.new
object = GitTool::GitObject.parse('head')
puts object