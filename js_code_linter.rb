require_relative './lib/code_section'

def semicolon_exception(snippet)
  return true if snippet.include? 'function'
  return true if snippet.include? 'if'
  return true if snippet.include? 'else'
  return true if snippet.include? 'while'
  return true if snippet.include? 'for'

  false
end

File.open('code.js', 'r') do |file|
  lines = file.readlines
  tab_no = 0
  sections = []
  section_index = 0
  lines.each_with_index do |line, number|
    unless line.strip.empty?
      if semicolon_exception(line)
        puts "Forgot open curly braces ({) at line #{number + 1}." if line.gsub(/\s+/,
                                                                                '')[line.gsub(/\s+/,
                                                                                              '').length - 1] != '{'
        if line.gsub(/\s+/, '')[line.gsub(/\s+/, '').length - 1] == '{'
          tab_no += 1
          sections[section_index] = CodeSection.new(line, tab_no, number, true)
          section_index += 1
        end
      elsif line[line.length - 2] != ';' && line.gsub(/\s+/, '') != '}'
        if line.include? ';'
          puts "Line #{number + 1} must end with a semicolon (;) and no characters should come after the semicolon (;)."
        end
        puts "Missing semicolon (;) at line #{number + 1}." unless line.include? ';'

      elsif line.gsub(/\s+/, '') == '}'
        if sections[section_index - 1]&.is_open
          sections[section_index - 1].is_open = false
          tab_no -= 1
        else
          puts "Remove extra closing curely braces (}) at line #{number}"
        end
      end
    end
  end
end
