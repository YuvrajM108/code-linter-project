require_relative '../js_code_linter'

describe '#semicolon_exception?' do
  it 'returns true if "function" is included in the line of code passed into the method' do
    expect(semicolon_exception?('function sum(x, y) {')).to eql(true)
  end
end
