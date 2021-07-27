require 'sinatra/base'
require 'prometheus/client'


class MyApp < Sinatra::Application
  prometheus = Prometheus::Client.registry
  
  http_requests = Prometheus::Client::Counter.new(:http_requests, docstring: 'A counter of HTTP requests made')
  prometheus.register(http_requests)
  get '/' do
    http_requests.increment
    'Hello world!'
  end
end