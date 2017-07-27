# Brown Bag version - 2014-11-06
def add_long(str)
  dlm = str[%r{//(\[.*?\])\n}] ? $1.scan(/\[(.*?)\]/).flatten.map { |d| Regexp.quote(d) }.join('|') : ','
  ns = str.split(/#{dlm}|\n/).map(&:to_i)
  raise ArgumentError, "Negatives Not Allowed: #{ns.select { |n| n < 0 }.join(',') }" if ns.find { |n| n < 0 }
  ns.reject { |n| n > 1000 }.reduce(0, :+)
end

# One-Liner version - 2014-11-07
# (day after the Brown Bag as a colleague asked for a 'tweet' version)
# - Text for Exception was changed from Negatives Not Allowed to shorter version
# - Exception will scan for -\d+ so less precise than the original
# - All spaces removed for compactness (but didn't reach tweet size!)
def add(s)
  s.split(/#{s[%r{//(\[.*?\])\n}]?$1.scan(/\[(.*?)\]/).flatten.map{|d|Regexp.quote(d)}.join('|'):','}|\n/).map(&:to_i).select{|n|n<0?(fail ArgumentError,"Negs errors:#{s.scan(/-\d+/).join(',')}"):n}.reject{|n|n>1000}.reduce(0,:+)
end

# Tests - RSpec
describe "StringCalculator.add" do
  it 'should return 0 for empty string' do
    expect(add("")).to eql(0)
  end

  it 'should return value for one number' do
    expect(add("1")).to eql(1)
  end

  it 'should return sum of 2 numbers' do
    expect(add("1,2")).to eql(3)
  end

  it 'should return sum of multiple numbers' do
    expect(add("1,2,3,4,5,6,7,8,9")).to eql(45)
  end

  it 'should handle new line as delimiter' do
    expect(add("1,2\n3")).to eql(6)
  end

  it 'should be able to specify new delimiter' do
    expect(add("//[;]\n1;2\n3")).to eql(6)
  end

  it 'should raise an exception for negative numbers' do
    expect { add("-1,2\n-3") }.to raise_error ArgumentError, /-1,-3/
  end

  it 'should ignore number greater than 1000' do
    expect(add("1001,2\n3000")).to eql(2)
  end

  it 'should handle delimiter of multiple length' do
    expect(add("//[;;;]\n1;;;2\n3")).to eql(6)
  end

  it 'should handle multiple delimiters of multiple lengths' do
    expect(add("//[;;;][$$$]\n1;;;2$$$3")).to eql(6)
  end
end
