class JSLine
  def initialize(string)
    @contents = string
  end

  def in_comment?(currently, prev_line)
    return true if (@contents.include? '/*') && !(@contents.include? '*/')
    return true if currently && !(prev_line.include? '*/')
    return false if currently && not_starting_new_comment?(prev_line)

    false
  end

  def single_line_comment?()
    return true if (@contents.include? '//') && !(@contents.include? ';')

    false
  end

  # rubocop: disable Metrics/CyclomaticComplexity
  def semicolon_exception?()
    return true if @contents.include? 'function'
    return true if @contents.include? 'if'
    return true if @contents.include? 'else'
    return true if @contents.include? 'while'
    return true if @contents.include? 'for'
    return true if @contents.include? 'switch'

    return arrow_function_check if @contents.include? '=>'

    false
  end
  # rubocop: enable Metrics/CyclomaticComplexity

  def open_curly_braces?()
    return true if @contents.include? '{'

    false
  end

  def chars_after_opening_curly_braces?
    return true if @contents.include?('{') && other_than_close_braces?(@contents[/(?<={).*/])

    false
  end

  def same_line_close_curly_braces?
    return true if (@contents.include? '{') && (@contents[/(?<={).*/].include? '}')

    false
  end

  def case_or_default?
    return true if @contents.include?('case') || @contents.include?('default')

    false
  end

  def ends_with_colon?
    return true if @contents.gsub(/\s+/, '')[@contents.gsub(/\s+/, '').length - 1] == ':'

    false
  end

  def missing_semicolon_without_close_braces?()
    return true if @contents[@contents.length - 2] != ';' && @contents.gsub(/\s+/, '') != '}'

    false
  end

  def characters_after_semicolon?()
    return true if (@contents.include? ';') && not_single_line_comment?(@contents[/(?<=;).*/])

    false
  end

  def closed_curly_braces?()
    return true if @contents.gsub(/\s+/, '') == '}'

    false
  end

  private

  def not_starting_new_comment?(last_line)
    return true if (last_line.include? '*/') && !(@contents.include? '/*')

    false
  end

  def arrow_function_check()
    return true if (@contents[/(?<=>).*/].include? '{') || @contents[/(?<=>).*/].gsub(/\s+/, '').empty?

    return false unless @contents[/(?<=>).*/].gsub(/\s+/, '').empty?
  end

  def not_single_line_comment?(chars)
    return true unless chars.empty? || (chars.include? '//')

    false
  end

  def other_than_close_braces?(chars)
    return true unless chars.empty? || (chars.include? '}')

    false
  end
end
