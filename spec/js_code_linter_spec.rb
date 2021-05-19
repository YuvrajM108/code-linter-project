require_relative '../js_code_linter'

describe '#semicolon_exception?' do
  it 'returns true if "function" is included in the line of code passed into the method' do
    expect(semicolon_exception?('function sum(x, y) {')).to eql(true)
  end
  it 'returns true if "if" is included in the line of code passed into the method' do
    expect(semicolon_exception?('if(x > y) {')).to eql(true)
  end
  it 'returns true if "else" is included in the line of code passed into the method' do
    expect(semicolon_exception?('else {')).to eql(true)
  end
  it 'returns true if "while" is included in the line of code passed into the method' do
    expect(semicolon_exception?('while(count < arr.length) {')).to eql(true)
  end
  it 'returns true if "for" is included in the line of code passed into the method' do
    expect(semicolon_exception?('for(i = 0; i < arr.length; i++) {')).to eql(true)
  end
  it 'returns false if the line of code passed into the method does not include any of the words in the above test cases' do
    expect(semicolon_exception?('return total;')).to eql(false)
  end
end
