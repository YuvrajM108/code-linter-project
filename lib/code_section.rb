class CodeSection
  attr_reader :start_line, :indentaion_no, :line_no
  attr_accessor :is_open

  def initialize(start, tabs, line, opened)
    @start_line = start
    @indentaion_no = tabs * 2
    @line_no = line
    @is_open = opened
  end

  def correct_indentation?(line)
    index = 0
    space_count = 0
    while(index < line.length)
      if line[index] == ' '
        space_count += 1
      else
        break
      end
      index += 1
    end
    
    return true if space_count == indentaion_no
      
    false
  end
end
