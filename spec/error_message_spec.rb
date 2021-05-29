require_relative '../lib/error_message'
require_relative '../lib/code_section'

describe ErrorMessage do
  describe '#generate_message' do
    it 'returns a message indicating that a colon is missing in a case or default line' do
      c_section = CodeSection.new(2, 3, true)
      message = ErrorMessage.new('    case 0', c_section)
      expect(message.generate_message(3)).to eql('Missing colon (:) at line 3')
    end
    it 'returns a blank message if there is a colon at end of a case or default line' do
      c_section = CodeSection.new(2, 3, true)
      message = ErrorMessage.new('    case 0:', c_section)
      expect(message.generate_message(3)).to eql('')
    end
    it 'returns a message indicating that there are characters (other than comment) after semicolon' do
      c_section = CodeSection.new(2, 3, true)
      message = ErrorMessage.new('    return x + y; /', c_section)
      # rubocop: disable Layout/LineLength
      expect(message.generate_message(3)).to eql('Line 3 must end with a semicolon (;) & no characters should come after the semicolon (;).')
      # rubocop: enable Layout/LineLength
    end
    it 'returns a blank message if there are comments after semicolon' do
      c_section = CodeSection.new(2, 3, true)
      message = ErrorMessage.new('    return x + y; //Return statement', c_section)
      expect(message.generate_message(3)).to eql('')
    end
    it 'returns a message indicating that a semicolon is missing in end of a line of code that requires it' do
      c_section = CodeSection.new(2, 3, true)
      message = ErrorMessage.new('    return x + y', c_section)
      expect(message.generate_message(3)).to eql('Missing semicolon (;) at line 3.')
    end
    it 'returns a blank message if the line requires a semicolon and has one at the end of it' do
      c_section = CodeSection.new(2, 3, true)
      message = ErrorMessage.new('    return x + y;', c_section)
      expect(message.generate_message(3)).to eql('')
    end
    it 'returns a blank message if the section is open & the line contains a closing curly brace' do
      c_section = CodeSection.new(1, 5, true)
      message = ErrorMessage.new('}', c_section)
      expect(message.generate_message(5)).to eql('Section closed')
    end
    it 'returns a message indicating an extra closing curly brace if the section is already closed' do
      c_section = CodeSection.new(1, 6, false)
      message = ErrorMessage.new('}', c_section)
      expect(message.generate_message(6)).to eql('Remove extra closing curely braces (}) at line 6')
    end
    it 'returns a blank message if the indentation of the line is correct' do
      c_section = CodeSection.new(2, 8, true)
      message = ErrorMessage.new('    let diff = x - y;', c_section)
      expect(message.generate_message(8)).to eql('')
    end
  end
end
