class App
  attr_reader :request

  def call(env)
    @request = Rack::Request.new(env)

    if path_valid?
      unless @request.query_string.empty?
        format_time
        return_time
      else
        [200, headers, body]
      end
    else
      [404, headers, body]
    end
  end

  private
  def path_valid?
    case @request.path_info
    when /time/
      true
    else
      false
    end
  end

  def format_time
    query = @request.query_string
    formats = query.split('=')[1].split('%2C')

    format_string = ""
    unsupported_formats = []

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
        unsupported_formats.push(format)
      end
    end

    if unsupported_formats.empty?
      return Time.now.strftime(format_string)
    else
      return unsupported_formats
    end
  end

  def return_time
    formatted_time = format_time

    if formatted_time.is_a?(String)
      [200, headers, [formatted_time]]
    else
      [400, headers, ["Unknown time format #{formatted_time}"]]
    end
  end

  def headers
    { 'Content-Type' => 'text/plain '}
  end

  def body
    []
  end
end
