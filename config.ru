require 'rack'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run ->(_) { [200, {'Content-Type' => 'text/html'}, ['OK']] }

require './app'
run MyApp