require_relative './lib/code_section'

def semicolon_exception(snippet)
  return true if snippet.include? 'function'
  return true if snippet.include? 'if'
  return true if snippet.include? 'else'
  return true if snippet.include? 'while'
  return true if snippet.include? 'for'

  false
end

# rubocop: disable Metrics/BlockLength

File.open('code.js', 'r') do |file|
  lines = file.readlines
  tab_no = 0
  sections = []
  section_index = 0
  in_comment = false
  lines.each_with_index do |line, number|
    in_comment = true if (line.include? '/*') && !in_comment

    if in_comment
      in_comment = false if line.include? '*/'
    elsif line.include? '*/'
      puts "Comment closed (*/) without opening at line #{number + 1}."
    end

    unless line.strip.empty? && !in_comment
      if semicolon_exception(line)
        puts "Forgot open curly braces ({) at line #{number + 1}." if line.gsub(/\s+/,
                                                                                '')[line.gsub(/\s+/,
                                                                                              '').length - 1] != '{'
        if line.gsub(/\s+/, '')[line.gsub(/\s+/, '').length - 1] == '{'
          tab_no += 1
          sections[section_index] = CodeSection.new(line, tab_no, (number + 1), true)
          section_index += 1
        end
      elsif line[line.length - 2] != ';' && line.gsub(/\s+/, '') != '}'
        if (line.include? ';') && !(line[/(?<=;).*/].include? '//')
          puts "Line #{number + 1} must end with a semicolon (;) & no characters should come after the semicolon (;)."
        end
        puts "Missing semicolon (;) at line #{number + 1}." unless line.include? ';'

      elsif line.gsub(/\s+/, '') == '}'
        if sections[section_index - 1]&.is_open
          sections[section_index - 1].is_open = false
          tab_no -= 1
          section_index -= 1
        else
          puts "Remove extra closing curely braces (}) at line #{number + 1}"
        end
      elsif sections[section_index - 1]&.is_open
        unless sections[section_index - 1].correct_indentation?(line)
          puts "Line #{number + 1} should be indented with #{sections[section_index - 1].indentaion_no} spaces."
        end
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
