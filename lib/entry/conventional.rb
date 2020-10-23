require_relative '../type/enum'

##
# Conventional commit category
#
class ConventionalType < Enum
  attr_accessor :description

  BUILD = ConventionalType.new("BUILD")
  CI = ConventionalType.new("CI")
  CHORE = ConventionalType.new("CHORE")
  DOCS = ConventionalType.new("DOCS")
  FEAT = ConventionalType.new("FEAT")
  FIX = ConventionalType.new("FIX")
  PERF = ConventionalType.new("PERF")
  REFACTOR = ConventionalType.new("REFACTOR")
  REVERT = ConventionalType.new("REVERT")
  STYLE = ConventionalType.new("STYLE")
  TEST = ConventionalType.new("TEST")

  def translation
    case self
    when BUILD; "构建"
    when CI; "持续集成"
    when CHORE; "杂项"
    when DOCS; "文档"
    when FEAT; "特性"
    when FIX; "修复"
    when PERF; "性能优化"
    when REFACTOR; "重构"
    when REVERT; "回溯"
    when STYLE; "样式"
    when TEST; "测试"
    end
  end

  def emoji
    case self
    when BUILD; "🚀"
    when CI; "💁‍♂️"
    when CHORE; "🌀"
    when DOCS; "📚"
    when FEAT; "✨"
    when FIX; "🐞"
    when PERF; "🔋"
    when REFACTOR; "🔧"
    when REVERT; "🌊"
    when STYLE; "🌈"
    when TEST; "🤖"
    end
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
    if type
      return "#{type.emoji}#{self.submodule && "(#{self.submodule})"}" +
        "#{"💥" if self.breaking_change}: #{self.message}"
    else
      return "❌: #{self.message}"
    end
  end
end