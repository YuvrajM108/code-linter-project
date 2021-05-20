class JSLine
  def initialize(string)
    @contents = string
  end

  def in_comment?(currently, prev_line)
    return true unless currently && !(@contents.include? '/*')
    return true if currently && !(prev_line.include? '*/')

    return false if currently && not_starting_new_comment?(prev_line)
  end

  def single_line_comment?()
    return true if (@contents.include? '//') && !(@contents.include? ';')

    false
  end

  def semicolon_exception?()
    return true if @contents.include? 'function'
    return true if @contents.include? 'if'
    return true if @contents.include? 'else'
    return true if @contents.include? 'while'
    return true if @contents.include? 'for'
  
    false
  end

  private

  def not_starting_new_comment?(last_line)
    return true if (last_line.include? '*/') && !(@contents.include? '/*')

    false
  end
end