class CodeSection
  attr_reader :indentation_no, :line_no
  attr_accessor :is_open

  def initialize(tabs, line, opened)
    @indentation_no = tabs * 2
    @line_no = line
    @is_open = opened
  end

  def correct_indentation?(line)
    index = 0
    space_count = 0
    while index < line.length
      break unless line[index] == ' '

      space_count += 1
      index += 1
    end

    return true if space_count == indentation_no

    false
  end
end
