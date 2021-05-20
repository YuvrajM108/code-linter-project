require_relative '../lib/js_line'

describe '#semicolon_exception?' do
  it 'returns true if "function" is included in the line of code' do
    line = JSLine.new('function sum(x, y) {')
    expect(line.semicolon_exception?).to eql(true)
  end
  it 'returns true if "if" is included in the line of code' do
    line = JSLine.new('if(x > y) {')
    expect(line.semicolon_exception?).to eql(true)
  end
  it 'returns true if "else" is included in the line of code' do
    line = JSLine.new('else {')
    expect(line.semicolon_exception?).to eql(true)
  end
  it 'returns true if "while" is included in the line of code' do
    line = JSLine.new('while(count < arr.length) {')
    expect(line.semicolon_exception?).to eql(true)
  end
  it 'returns true if "for" is included in the line of code' do
    line = JSLine.new('for(i = 0; i < arr.length; i++) {')
    expect(line.semicolon_exception?).to eql(true)
  end
  it 'returns true if "=>" & open curly braces ({) are included in the line of code' do
    line = JSLine.new('let isEven = x => {')
    expect(line.semicolon_exception?).to eql(true)
  end
  it 'returns false if "=>" is followed by one line of code' do
    line = JSLine.new('let addOne = x => x + 1;')
    expect(line.semicolon_exception?).to eql(false)
  end
  it 'returns false if the line of code passed into the method does not pass above test cases' do
    line = JSLine.new('return total;')
    expect(line.semicolon_exception?).to eql(false)
  end
end
