require_relative '../lib/js_line'

describe JSLine do
  describe '#in_comment?' do
    it 'returns true if "/*" is included in the line of code and "*/" is not in the line of code' do
      line = JSLine.new('/* This is a multi-line comment')
      expect(line.in_comment?(false, 'let x = 4;')).to eql(true)
    end
    it 'returns true if currently in a comment & previous line does not include "*/"' do
      line = JSLine.new('This is another line in a comment')
      expect(line.in_comment?(true, '/* This is a multi-line comment')).to eql(true)
    end
    it 'returns false if previous line includes "*/", if currently in a comment, & if line does not include "/*"' do
      line = JSLine.new('let y = 7;')
      expect(line.in_comment?(true, '*/')).to eql(false)
    end
    it 'returns false if line does not pass any of the above cases' do
      line = JSLine.new('let sum = x + y;')
      expect(line.in_comment?(false, 'let y = 7;')).to eql(false)
    end
  end

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
    it 'returns true if "switch" is included in the line of code' do
      line = JSLine.new('switch(expr) {')
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
end
