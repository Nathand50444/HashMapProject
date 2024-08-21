require_relative 'linked_list'

class HashMap

  def initialize
    @buckets = Array.new(16) {LinkedList.new}
    @load_factor = 0.75
    @hashmap_size = 16
    @number_of_elements = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)

    bucket_index = hash(key) % @hashmap_size
    puts bucket_index
    bucket = @buckets[bucket_index]
  
    node = bucket.find { |node| node.key == key }
    
    if node
      node.value = value
    else
      @number_of_elements += 1
      resize_required?
      bucket.prepend(key, value)
    end
  end

  def get(key)
    bucket_index = hash(key) % @hashmap_size
    pair = @buckets[bucket_index].find { |hash| hash.key == key }
    pair ? pair.value : nil
    # This method will search the buckets for the corresponding key; value pair.
  end

  def has?(key)
    bucket_index = hash(key) % @hashmap_size
    !!@buckets[bucket_index].find { |hash| hash.key == key }
    # Search the buckets for the corresponding key; value pair, return TRUE if found.
  end

  def remove(key)
    bucket_index = hash(key) % @hashmap_size
    node = @buckets[bucket_index].find { |node| node.key == key }
    if node
      @buckets[bucket_index].delete_if { |n| n.key == key }
      node.value
    else
      nil
    end
  end

  def length
    puts "@number_of_elements = #{@number_of_elements}"
    puts "@hashmap_size = #{@hashmap_size}"
  end

  def clear
    @buckets = Array.new(16) { LinkedList.new }
    @number_of_elements = 0
    # Remove all entries in the hashmap.
  end

  def keys
    @buckets.flat_map do |bucket|
      bucket.map(&:key)
    end
    # Returns an array containing all the keys inside the hash map.
  end

  def values
    @buckets.flat_map do |bucket|
      bucket.map { |node| node.value }
    end
  end

  def entries
    @buckets.flat_map do |bucket|
      bucket.map { |node| [node.key, node.value] }
    end
  end

  def resize_required?
    current_load_factor = @number_of_elements.to_f / @hashmap_size

    if current_load_factor > @load_factor
      rehash
    end
  end

  def rehash
    old_buckets = @buckets
    @hashmap_size *= 2
    @buckets = Array.new(@hashmap_size) {LinkedList.new}
    @number_of_elements = 0

    old_buckets.each do |bucket|
      bucket.each do |node|
        set(node.key, node.value)
      end
    end
  end
end