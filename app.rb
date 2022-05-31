class App
  attr_reader :request

  def call(env)
    @request = Rack::Request.new(env)

    unless @request.query_string.empty?
      create_response
    else
      [200, headers, body]
    end
  end

  private

  def create_response
    formatter = FormatTime.new(@request)

    formatter.format_time

    if formatter.valid?
      return [200, headers, formatter.formatted_time]
    else
      return [400, headers, ["Unknown time format #{formatter.unsupported_formats}"]]
    end
  end

  def headers
    { 'Content-Type' => 'text/plain '}
  end

  def body
    []
  end
end
