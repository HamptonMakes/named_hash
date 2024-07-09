require_relative './lib/named_hash'

config = ~{
  "name": "Hampton",
  deep: {
    value: 123
  }
}

# Indifferent access
config[:name] == "Hampton" #true
config["name"] == "Hampton" #true
config[:Name] == nil #true
config.is_a? Hash #true
config.instance_of? Hash #false

# Protects against invalid key types
config[1982] #raise NamedHash::InvalidKeyError
config[{}] #raise NamedHash::InvalidKeyError
config[OpenStruct.new] #raise NamedHash::InvalidKeyError

# Doesn't by default do a 'deep' protection
config["deep"].is_a?(NamedHash) #true
config["deep"][:value] #123
config["deep"]["value"] #null
config["deep"][1982] = true #true

# You can do a deep coercion by using ~~ either at hash-creation or calling on an existing NamedHash
config = ~~config

config["deep"][:value] #123
config["deep"]["value"] #123
config["deep"][1982] #raise NamedHash::InvalidKeyError

# Example way to use the object without fear of invalid key types
def initialize(options = {})
  options = ~options
  options[:living_legend] ||= true
end