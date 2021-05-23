require_relative '../lib/js_line'
require_relative '../lib/code_section'

class ErrorMessage
  def initialize(line, section)
    @cur_line = line
    @prev_section = section
  end

  # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength
  def generate_message(line_no)
    code_line = JSLine.new(@cur_line)
    if code_line.case_or_default?
      return "Missing colon (:) at line #{line_no}" unless code_line.ends_with_colon?

      return ''
    elsif code_line.missing_semicolon_without_close_braces?
      if code_line.characters_after_semicolon?
        return "Line #{line_no} must end with a semicolon (;) & no characters should come after the semicolon (;)."
      end
      return "Missing semicolon (;) at line #{line_no}." unless @cur_line.include? ';'

      return ''
    elsif code_line.closed_curly_braces?
      if @prev_section&.is_open
        @prev_section.is_open = false
        return ''
      end
      return "Remove extra closing curely braces (}) at line #{line_no}" unless @prev_section&.is_open
    elsif @prev_section&.is_open
      unless @prev_section.correct_indentation?(@cur_line)
        return "Line #{line_no} should be indented with #{@prev_section.indentation_no} spaces."
      end

      return ''
    end
    ''
  end
  # rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength
end
