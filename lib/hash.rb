class Hash
  def to_named_hash
    NamedHash.new(self)
  end
  alias_method :~, :to_named_hash
end