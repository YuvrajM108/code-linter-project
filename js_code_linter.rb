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
  lines.each_with_index do |line, number|
    unless line.strip.empty?
      if semicolon_exception(line)
        puts "Forgot open curly braces ({) at line #{number + 1}." if line.gsub(/\s+/, "")[line.gsub(/\s+/, "").length - 1] != '{'
      elsif line[line.length - 2] != ';' && line.gsub(/\s+/, "") != '}'
        if line.include? ';'
          puts "Line #{number + 1} must end with a semicolon (;) and no characters should come after the semicolon (;)."
        end
        puts "Missing semicolon (;) at line #{number + 1}." unless line.include? ';'

      end
    end
  end
end
