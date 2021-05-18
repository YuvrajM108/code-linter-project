class CodeSection
  attr_reader :start_line, :indentaion_no, :line_no
  attr_accessor :is_open

  def initialize(start, tabs, line, opened)
    @start_line = start
    @indentaion_no = tabs * 2
    @line_no = line
    @is_open = opened
  end
end
