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

    @number_of_elements += 1
    @buckets[bucket_index].prepend(key, value)
  end

  def get(key)
    bucket_index = hash(key) % @hashmap_size
    pair = @buckets[bucket_index].find { |hash| hash[:key] == key }
    pair ? pair[:value] : nil
    # This method will search the buckets for the corresponding key; value pair.
  end

  def has?(key)
    bucket_index = hash(key) % @hashmap_size
    !!@buckets[bucket_index].find { |hash| hash[:key] == key }
    # Search the buckets for the corresponding key; value pair, return TRUE if found.
  end

  def remove(key)
    bucket_index = hash(key) % @hashmap_size
    @buckets[bucket_index].delete_if { |hash| hash[:key] == key }
    # Find the 'key' entry, remove the entry with that key and return the deleted entry’s value.
  end

  def length
    print @element_count
  end

  def clear
    @buckets = Array.new(16) { LinkedList.new }
    @number_of_elements = 0
    # Remove all entries in the hashmap.
  end

  def keys
    @buckets.flat_map do |bucket|
      bucket.map { |node| node[:key] }
    end
    # Returns an array containing all the keys inside the hash map.
  end

  def values
    @buckets.flat_map do |bucket|
      bucket.map { |node| node[:value] }
    end
  end

  def entries
    @buckets.flat_map do |bucket|
      bucket.map { |node| [node[:key], node[:value]] }
    end
  end
end