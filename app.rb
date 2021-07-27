require 'sinatra/base'
require 'prometheus/client'


class MyApp < Sinatra::Application
  prometheus = Prometheus::Client.registry
  
  http_requests = Prometheus::Client::Counter.new(:http_requests, docstring: 'A counter of HTTP requests made')
  prometheus.register(http_requests)
  
  viewer_gauge = Prometheus::Client::Gauge.new(:viewers, docstring: 'E_TOOMANY_VIERERS', labels: [:service])
  prometheus.register(viewer_gauge)
  get '/' do
    http_requests.increment
    'Hello world!'
  end
  
  get '/twitchy' do
    num_viewers = rand(50)
    viewer_gauge.set(num_viewers, labels: { service: 'twich' })
  end
end