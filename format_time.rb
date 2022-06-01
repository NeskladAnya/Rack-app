class FormatTime
  FORMATS = {
    'year' => '%Y-', 'month' => '%m-', 'day' => '%d-',
    'hour' => '%H:', 'minute' => '%M:', 'second' => '%S:'
  }.freeze

  attr_reader :request, :unsupported_formats, :formatted_time

  def initialize(request)
    @request = request
    @unsupported_formats = []
    @formatted_time = []
  end

  def format_time
    query = @request.query_string
    formats = query.split('=')[1].split('%2C')

    format_string = formats.map { |key| FORMATS[key] }.join

    @unsupported_formats = formats.difference(FORMATS.keys)

    @formatted_time = [Time.now.strftime(format_string)]
  end

  def valid?
    @unsupported_formats.empty?
  end
end
