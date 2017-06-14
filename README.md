# String Calculator Kata - Ruby version
This Code Kata is based on Roy Osherove's String Calculator. See http://osherove.com/tdd-kata-1

At my previous employer, in 2014-2015,  we used to practice Code Katas with a twist:

**Live coding in front of an audience of fellow programmers!**

Sessions were fun, it was in general the Thursdays during the Brown Bag timeslot, and it was a good way to discover new languages and paradigms. We did the String Calculator with at least 20 different languages (my last count), from x86 Assembly (yes) to Monadic Parsers in Haskell via RPG (Arhh!), Rust, Elixir and many more (including the more common languages obviosuly). 

As much as one would have practiced the Kata on her/his own before, to be in the *hot seat* was always pushing people out of their comfort zone.

## Live Coding Version - 4 Lines
Version done during the live coding Brown Bag session, using TDD: write the test, fail, write the code, refactor

This is not readable, and not the way I usally leave code behind, I just wanted something terse to contrast with other languages
```ruby
def add(str)
  dlm = str[%r{//(\[.*?\])\n}] ? $1.scan(/\[(.*?)\]/).flatten.map { |d| Regexp.quote(d) }.join('|') : ','
  ns = str.split(/#{dlm}|\n/).map(&:to_i)
  raise ArgumentError, "Negatives Not Allowed: #{ns.select { |n| n < 0 }.join(',') }" if ns.find { |n| n < 0 }
  ns.reject { |n| n > 1000 }.reduce(0, :+)
end
```

## One Liner Version
```ruby
def add(s)
  s.split(/#{s[%r{//(\[.*?\])\n}]?$1.scan(/\[(.*?)\]/).flatten.map{|d|Regexp.quote(d)}.join('|'):','}|\n/).map(&:to_i).select{|n|n<0?(fail ArgumentError,"Negs errors:#{s.scan(/-\d+/).join(',')}"):n}.reject{|n|n>1000}.reduce(0,:+)
end
```

Note that there is no semi-colon, and so not a group of statements joined on one line - that would have been cheating!
## Tests


