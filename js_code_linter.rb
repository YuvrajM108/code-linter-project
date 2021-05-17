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
        puts "Forgot open curly braces ({) at line #{number + 1}." if line[line.length - 2] != '{'
      elsif line[line.length - 2] != ';'
        puts "Missing semicolon (;) at line #{number + 1}."
      end
    end
  end
end
