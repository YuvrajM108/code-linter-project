class JSLine
  def initialize(string)
    @contents = string
  end

  def is_single_line_comment?()
    return true if (@contents.include? '//') && !(@contents.include? ';')

    false
  end
end
