require 'rubygems'
require 'rack'

def application(env)
  [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]
end

Rack::Handler::WEBrick.run method(:application), :Port => 9292