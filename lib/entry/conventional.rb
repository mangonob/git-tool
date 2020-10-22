require_relative '../type/enum'

##
# Conventional commit category
#
class ConventionalType < Enum
  attr_accessor :description

  def initialize(raw_value, description = nil)
    super(raw_value)
    self.description = description
  end

  BUILD = ConventionalType.new("BUILD", "构建")
  CI = ConventionalType.new("CI", "持续集成")
  CHORE = ConventionalType.new("CHORE", "杂项")
  DOCS = ConventionalType.new("DOCS", "文档")
  FEAT = ConventionalType.new("FEAT", "特性")
  FIX = ConventionalType.new("FIX", "修复")
  PERF = ConventionalType.new("PERF", "性能")
  REFACTOR = ConventionalType.new("REFACTOR", "重构")
  REVERT = ConventionalType.new("REVERT", "回溯")
  STYLE = ConventionalType.new("STYLE", "样式")
  TEST = ConventionalType.new("TEST", "测试")

  def to_s
    return "(#{self.raw_value}, #{self.description})"
  end
end

##
# Conventional commit
#
class Conventional
  attr_accessor :type, :message, :submodule, :breaking_change

  def initialize(message, type: nil, submodule: nil, breaking_change: false)
    self.message = message
    self.type = type
    self.submodule = submodule 
    self.breaking_change = breaking_change
  end

  def to_s
    if type then
      return "#{type.raw_value.downcase}#{self.submodule && "(#{self.submodule})"}" +
        "#{"!" if self.breaking_change}: #{self.message}"
    else
      return "!! #{self.message}"
    end
  end
end