require_relative 'node'

class LinkedList

  include Enumerable
  attr_reader :head

  def initialize
    # Initialize creates the @head and @tail class variables.
    @head = nil
    @tail = nil
  end

  def prepend(key, value)
    # Adds the key; value pair as a Node class.
    new_node = Node.new(key, value)

    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      @tail.next = new_node
      @tail = new_node
    end
  end

  def to_string
    result = ""
    current = @head
    
    while current
      result += "[#{current.key}: #{current.value}] -> "
      current = current.next
    end
    
    result += "nil"
    puts result
  end

  def each
    # Whilst current is a real value (not nil) we yield the current value then iterate to the next until current = 'nil'.
    current = @head
    while current
      yield current
      current = current.next
    end
  end

  def map
    # Produces an array of the node values in this linked list, using the 'each' method to iterate through.
    result = []
    each { |node| result << yield(node) }
    result
  end

  def find
    # Yields each node using the 'each' method to iterate through. Passes result to the block in 'hash_map'.
    each do |node|
      return node if yield(node)
    end
    nil
  end
  
  def delete_if
    # This updates the next value in the list that meets the condition until only nil remains, stopping the method.
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