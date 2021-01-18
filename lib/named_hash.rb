class NamedHash < Hash
  def initialize(hash)
    super(nil)
    merge(hash)
  end

  def set(key, value)
    check_key_type(key)
    if value.is_a?(Hash) && !value.is_a?(NamedHash)
      value = NamedHash.new(value)
    end
    native_set(key.to_s, value)
  end
  alias_method :native_set, :[]=
  alias_method :[]=, :set

  def [](key)
    check_key_type(key)
    super(key.to_s)
  end

  def merge(hash)
    hash.each do |key, value|
      set(key, value)
    end
  end

  private

  def check_key_type(key)
    throw "Only Strings and Keys are Valid" unless (key.is_a?(String) || key.is_a?(Symbol))
  end
end

def _(value = nil, &block)
  if value == nil && block_given?
    value = block.call
    puts value
  end

  return self if value.is_a? NamedHash

  if value.is_a? Hash
    return NamedHash.new(value)
  end
end