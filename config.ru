require_relative 'app'
require_relative 'format_time'

ROUTES = {
  '/time' => App.new
}

run Rack::URLMap.new(ROUTES)
