require_relative 'node'

class LinkedList

  # Initialize creates the @list class instance variable and populates it with "nil" for the last value in the list.
  def initialize(head = nil, tail = nil)
    @list = []
    @head = head
    @tail = tail
    @size = 0
  end

  # Adds word to the beginning of the list.
  def prepend(key, value)
    @size += 1
    @list = Node.new(key, value)
    to_string
  end

  def to_string
    puts @list
  end

end