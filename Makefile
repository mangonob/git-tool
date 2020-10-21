all: build

build: git-tool.gemspec
	gem build git-tool.gemspec

docs:
	rdoc
