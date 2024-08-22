require_relative 'linked_list'

class HashMap



  def initialize
    # class variables are initialized including the buckets (allows us to store our linked lists of elements)
    # load_factor sets the rate new buckets will be formed. def resize_required? updates buckets when 75% used)
    # @hachmap_size keeps track of the buckets available which can be updated through def resize_required?
    # @number_of_elements tracks the number of elements fed into the HashMap.
    
    @buckets = Array.new(16) { LinkedList.new }
    @load_factor = 0.75
    @hashmap_size = 16
    @number_of_elements = 0
  end

  def hash(key)
    # The hashcode is calculated using each character of the key provided and the prime number 31 to generate a code.
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    # Here we use the hash calculated in hash(key) and the modulus operator to get a remainder / bucket number.
    bucket_index = hash(key) % @hashmap_size
    puts bucket_index
    bucket = @buckets[bucket_index]
    # An iterator is used to determine if the key already exists, and replace the value if true.
    # If false, the key; value pair is prepended to the appropriate bucket.
    node = bucket.find { |node| node.key == key }
    
    if node
      node.value = value
    else
      # 1 is added to the number of elements, checked against the load_factor and the values are added to the bucket.
      @number_of_elements += 1
      resize_required?
      bucket.prepend(key, value)
    end
  end

  def get(key)
    # This method will search the buckets for the corresponding key; value pair returning the value of the key if found.
    bucket_index = hash(key) % @hashmap_size
    pair = @buckets[bucket_index].find { |hash| hash.key == key }
    pair ? pair.value : nil
  end

  def has?(key)
    bucket_index = hash(key) % @hashmap_size
    !!@buckets[bucket_index].find { |hash| hash.key == key }
    # Search the buckets for the corresponding key; value pair, return TRUE if found.
  end

  def remove(key)
    # This method will search the buckets for the corresponding key and delete the node from the linked list.
    bucket_index = hash(key) % @hashmap_size
    node = @buckets[bucket_index].find { |node| node.key == key }
    if node
      @buckets[bucket_index].delete_if { |n| n.key == key }
      node.value
    else
      nil
    end
  end

  def to_string(bucket_index)
    if bucket_index < 0 || bucket_index >= @hashmap_size
      puts "Bucket index out of range."
      return
    end

    @buckets[bucket_index].to_string
  end

  def length
    # Return these values for information on the status of the HashMap.
    puts "@number_of_elements = #{@number_of_elements}"
    puts "@hashmap_size = #{@hashmap_size}"
  end

  def clear
    # Removes all entries in the hashmap by creating new HashMap.
    @buckets = Array.new(16) { LinkedList.new }
    @number_of_elements = 0
  end

  def keys
    # Returns an array containing all the keys inside the hash map by iterating through the buckets.
    @buckets.flat_map do |bucket|
      bucket.map(&:key)
    end
  end

  def values
    # Returns an array containing all the values inside the hash map by iterating through the buckets.
    @buckets.flat_map do |bucket|
      bucket.map { |node| node.value }
    end
  end

  def entries
    # Returns an array containing all the key; value pairs inside the hash map by iterating through the buckets.
    @buckets.flat_map do |bucket|
      bucket.map { |node| [node.key, node.value] }
    end
  end

  def resize_required?
    # The number of elements is divided by the hashmap size and theat number is compared against the load factor.
    # If the load factor is less than this number then the HashMap is expanded through the rehash method.
    current_load_factor = @number_of_elements.to_f / @hashmap_size

    if current_load_factor > @load_factor
      rehash
    end
  end

  def rehash
    # The new hash is created using the old bucket key; value pairs but with double the number of buckets.
    # This reduces the likelihood of collisions.
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