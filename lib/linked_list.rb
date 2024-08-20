require_relative 'node'

class LinkedList

  include Enumerable

  # Initialize creates the @list class instance variable and populates it with "nil" for the last value in the list.
  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
    @size = 0
  end

  # Adds word to the beginning of the list.
  def prepend(key, value)
    new_node = Node.new(key, value)
    @size += 1
    to_string
    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      new_node.next = @head
      @head = new_node
    end
  end

  def to_string
    puts @list.inspect
  end

  def each
    current = @head
    while current
      yield current
      current = current.next
    end
  end

  def map
    result = []
    each { |node| result << yield(node) }
    result
  end
end