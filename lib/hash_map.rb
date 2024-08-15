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

    @element_count += 1
    @buckets[bucket_index].prepend(key, value)
  end

  def get(key)
    # This method will search the buckets for the corresponding key; value pair.
  end

  def has?(key)
    # Search the buckets for the corresponding key; value pair, return TRUE if found.
  end

  def remove(key)
    # Find the 'key' entry, remove the entry with that key and return the deleted entry’s value.
  end

  def length
    
  end
end