require_relative 'node'

class LinkedList

  include Enumerable

  # Initialize creates the @list class instance variable and populates it with "nil" for the last value in the list.
  def initialize
    @head = nil
  end

  # Adds word to the beginning of the list.
  def prepend(key, value)
    new_node = Node.new(key, value)

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

  # Find method to locate a node by a condition
  def find
    each do |node|
      return node if yield(node)
    end
    nil
  end
  
  # Deletes nodes based on a condition
  def delete_if
    prev = nil
    current = @head
  
    while current
      if yield(current)
        if prev
          prev.next = current.next
        else
          @head = current.next
        end
      else
        prev = current
      end
      current = current.next
    end
  end
end