class Enum
  attr_accessor :raw_value

  def initialize(raw_value)
    self.raw_value = raw_value
  end

  def ==(other)
    return self.raw_value === other.raw_value
  end

  def ===(other)
    return self == other
  end

  def equal?(other)
    return self == other
  end

  def to_s
    self.raw_value.to_s
  end
end