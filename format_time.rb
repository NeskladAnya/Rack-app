class FormatTime
  attr_reader :request, :unsupported_formats, :formatted_time

  def initialize(request)
    @request = request
    @unsupported_formats = []
    @formatted_time = []
  end

  def format_time

    query = @request.query_string
    formats = query.split('=')[1].split('%2C')

    format_string = ""

    formats.each do |format|
      case format
      when "year"
        format_string += "%Y-"
      when "month"
        format_string += "%m-"
      when "day"
        format_string += "%d-"
      when "hour"
        format_string += "%H:"
      when "minute"
        format_string += "%M:"
      when "second"
        format_string += "%S:"
      else
        @unsupported_formats.push(format)
      end
    end

    @formatted_time = [Time.now.strftime(format_string)]
  end 

  def valid?
    @unsupported_formats.empty? ? true : false
  end
end
