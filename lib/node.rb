class Node
  attr_accessor :value, :key, :next

  def initialize(key = nil, value = nil)
    @key = key
    @value = value
    @next = nil
  end
end