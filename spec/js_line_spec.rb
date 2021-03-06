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

  describe '#single_line_comment?' do
    it 'returs true if "//" is included in line of code without a semicolon (;)' do
      line = JSLine.new('// This is a single line comment')
      expect(line.single_line_comment?).to eql(true)
    end
    it 'returns false if a semicolon (;) is included in the line of code' do
      line = JSLine.new('let x = 4;  // Variable declaration')
      expect(line.single_line_comment?).to eql(false)
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

  describe '#open_curly_braces?' do
    it 'returns true if line of code includes opening curly braces ({)' do
      line = JSLine.new('function sum(x, y) {')
      expect(line.open_curly_braces?).to eql(true)
    end
    it 'returns false if line of code does not include opening curly braces ({)' do
      line = JSLine.new('function sum(x, y)')
      expect(line.open_curly_braces?).to eql(false)
    end
  end

  describe '#chars_after_opening_curly_braces?' do
    it 'returns true if any characters (other than }) are found after opening curly braces ({)' do
      line = JSLine.new('function sum(x, y) {;')
      expect(line.chars_after_opening_curly_braces?).to eql(true)
    end
    it 'returns false if closing curly braces (}) are found after opening curly braces ({)' do
      line = JSLine.new('let func = () => {};')
      expect(line.chars_after_opening_curly_braces?).to eql(false)
    end
    it 'returns false if no characters are found after opening curly braces ({)' do
      line = JSLine.new('function sum(x, y) {')
      expect(line.chars_after_opening_curly_braces?).to eql(false)
    end
  end

  describe '#same_line_close_curly_braces?' do
    it 'returns true if curly braces open ({) & close (}) on the same line' do
      line = JSLine.new('let func = () => {};')
      expect(line.same_line_close_curly_braces?).to eql(true)
    end
    it 'returns false if curly braces do not open ({) & close (}) on the same line' do
      line = JSLine.new('let func = () => {')
      expect(line.same_line_close_curly_braces?).to eql(false)
    end
  end

  describe '#case_or_default?' do
    it 'returns true if line of code includes "case"' do
      line = JSLine.new('case 0:')
      expect(line.case_or_default?).to eql(true)
    end
    it 'returns true if line of code includes "default"' do
      line = JSLine.new('default:')
      expect(line.case_or_default?).to eql(true)
    end
    it 'returns false if line of code does not include "case" or "switch"' do
      line = JSLine.new('break;')
      expect(line.case_or_default?).to eql(false)
    end
  end

  describe '#ends_with_colon?' do
    it 'returns true if line ends with colon (:)' do
      line = JSLine.new('case 0:')
      expect(line.ends_with_colon?).to eql(true)
    end
    it 'returns false if line does not end with colon (:)' do
      line = JSLine.new('case 0')
      expect(line.ends_with_colon?).to eql(false)
    end
  end

  describe '#missing_semicolon_without_close_braces?' do
    it 'returns true if semicolon (;) is not at end of line & closing curly braces (}) is not in line' do
      line = JSLine.new('return x + y')
      expect(line.missing_semicolon_without_close_braces?).to eql(true)
    end
    it 'returns false if semicolon (;) is at end of line' do
      line = JSLine.new('return x + y; ')
      expect(line.missing_semicolon_without_close_braces?).to eql(false)
    end
    it 'returns false if closing curly braces are found in line' do
      line = JSLine.new('}')
      expect(line.missing_semicolon_without_close_braces?).to eql(false)
    end
  end

  describe '#characters_after_semicolon?' do
    it 'returns true if there are any characters after the semicolon of a line which are not comments' do
      line = JSLine.new('return x + y; /')
      expect(line.characters_after_semicolon?).to eql(true)
    end
    it 'returns false if there are no characters after the semicolon' do
      line = JSLine.new('return x + y;')
      expect(line.characters_after_semicolon?).to eql(false)
    end
  end

  describe '#closed_curly_braces?' do
    it 'returns true if line contains a closed curly braces (})' do
      line = JSLine.new('}')
      expect(line.closed_curly_braces?).to eql(true)
    end
    it 'returns false if line does not contain a closed curly braces (})' do
      line = JSLine.new('return x + y;')
      expect(line.closed_curly_braces?).to eql(false)
    end
  end
end
