class Node
  attr_accessor :value, :key

  def initialize(key = nil, value = nil)
    @key = key
    @value = value
  end
end