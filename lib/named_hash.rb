require_relative 'hash'

class NamedHash < Hash
  def initialize(hash = nil)
    super
    if hash
      merge(hash)
    end
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

  def to_named_hash
    self
  end

  alias :~ :to_named_hash

  class InvalidKeyError < StandardError
    def initialize
      super("Only Strings and Symbols are Valid")
    end
  end

  private

  def check_key_type(key)
    raise InvalidKeyError unless (key.is_a?(String) || key.is_a?(Symbol))
  end
end