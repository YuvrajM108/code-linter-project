require_relative '../lib/code_section'

describe CodeSection do
  describe '#correct_indentation?' do
    let(:section) { CodeSection.new(2, 12, true) }
    it 'returns true if line of code passed into code_indentation? has correct indentation of 4 spaces' do
      expect(section.correct_indentation?('    return x + "is larger than" + y')).to eql(true)
    end
    it 'returs false if line of code passed into code_indentation? has incorrect indentation' do
      expect(section.correct_indentation?('  return x + "is larger than" + y')).to eql(false)
    end
  end
end
