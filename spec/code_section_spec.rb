require_relative '../lib/code_section'

describe CodeSection do
  describe '#correct_indentation?' do
    let(:section) { CodeSection.new('if (x > y) {', 2, 12, true) }
    it 'returns true if line of code has the correct indentation of 4 spaces' do
      expect(section.correct_indentation?('    return x + "is larger than" + y')).to eql(true)
    end
  end
end