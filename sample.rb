

value = _{{Hi: "mom"}}

puts value.inspect

def test(name, options = _{{}})
  puts options.inspect
  puts options.class
end

test("hi", a: 1)