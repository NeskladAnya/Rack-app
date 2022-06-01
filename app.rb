class App
  attr_reader :request, :response, :formatter

  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    set_response

    @response.finish
  end

  private

  def set_response
    if !request.query_string.empty?
      format_time_in_body

      if @formatter.valid?
        @response.status = 200
        @response.body = formatter.formatted_time
      else
        @response.status = 400
        @response.body = ["Unknown time format #{formatter.unsupported_formats}"]
      end
    else
      @response.status = 200
      @response.body = []
    end
  end

  def format_time_in_body
    @formatter = FormatTime.new(@request)

    @formatter.format_time
  end
end
