module Markdown
  def h1(text = nil)
    header 1, text || yield
  end

  def h2(text = nil)
    header 2, text || yield
  end

  def h3(text = nil)
    header 3, text || yield
  end

  def h4(text = nil)
    header 4, text || yield
  end

  def h5(text = nil)
    header 5, text || yield
  end

  def header(level, text = nil)
    puts "#{"#" * level} #{text || yield}"
  end

  def rules
    puts "---"
  end

  def strong(text = nil)
    "**#{text || yield}**"
  end

  def emphasis(text = nil)
    "*#{text || yield}#"
  end

  def blockquotes(text = nil)
    "> #{text || yield}"
  end

  def unordered_list(content)
    render = content || yield
    if render.class == String
      render = render.lines.map(&:strip).reject(&:empty?)
    end
    render.map()
  end

  def list
  end

  module_function :h1, :h2, :h3, :h4, :h5, 
    :header, :rules, :strong, :emphasis, :blockquotes,
    :unordered_list, :list
end

MD = Markdown