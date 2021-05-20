require_relative '../lib/code_section'
require_relative '../lib/js_line'

# rubocop: disable Metrics/BlockLength

File.open('code.js', 'r') do |file|
  lines = file.readlines
  errors = 0
  tab_no = 0
  sections = []
  section_index = 0
  in_comment = false
  lines.each_with_index do |line, number|
    code_line = JSLine.new(line)
    in_comment = code_line.in_comment?(in_comment, lines[number - 1])

    if !in_comment && (line.include? '*/')
      puts "Comment closed (*/) without opening at line #{number + 1}."
      errors += 1
    end
    unless line.strip.empty? || in_comment || code_line.single_line_comment?
      if code_line.semicolon_exception?
        if code_line.open_curly_braces?
          tab_no += 1
          sections[section_index] = CodeSection.new(line, tab_no, (number + 1), true)
          section_index += 1
        elsif code_line.chars_after_opening_curly_braces?
          puts "Remove characters after opening curly braces ({) at line #{number + 1}."
        else
          puts "Forgot open curly braces ({) at line #{number + 1}."
          errors += 1
        end
      elsif code_line.missing_semicolon_without_close_braces?
        if code_line.characters_after_semicolon?
          puts "Line #{number + 1} must end with a semicolon (;) & no characters should come after the semicolon (;)."
          errors += 1
        end
        unless line.include? ';'
          puts "Missing semicolon (;) at line #{number + 1}."
          errors += 1
        end
      elsif code_line.closed_curly_braces?
        if sections[section_index - 1]&.is_open
          sections[section_index - 1].is_open = false
          tab_no -= 1
          section_index -= 1
        else
          puts "Remove extra closing curely braces (}) at line #{number + 1}"
          errors += 1
        end
      elsif sections[section_index - 1]&.is_open
        unless sections[section_index - 1].correct_indentation?(line)
          puts "Line #{number + 1} should be indented with #{sections[section_index - 1].indentaion_no} spaces."
          errors += 1
        end
      end
    end
  end
  section_count = 0
  while section_count < sections.length
    if sections[section_count].is_open
      puts "Curly braces ({) opened at line #{sections[section_count].line_no} but never closed."
      errors += 1
    end
    section_count += 1
  end
  puts "\nJavaScript code inspected. #{errors} syntax error(s) detected."
end
# rubocop: enable Metrics/BlockLength
