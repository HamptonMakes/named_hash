require_relative './lib/named_hash'

value = _{{Hi: "mom"}}

puts value.inspect

def test(name, options = _{{}})
  puts options.inspect
  puts options.class
end

test("hi", a: 1)