class App
  attr_reader :request, :response

  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    unless @request.query_string.empty?
      set_response
    else
      @response.status = 200
      @response.body = []
    end

    @response.finish
  end

  private

  def set_response
    formatter = FormatTime.new(@request)

    formatter.format_time

    if formatter.valid?
      @response.status = 200
      @response.body = formatter.formatted_time
    else
      @response.status = 400
      @response.body = ["Unknown time format #{formatter.unsupported_formats}"]
    end
  end
end
