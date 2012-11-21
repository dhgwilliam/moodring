$:.unshift('./lib', './models')
require 'sinatra'
require 'slim'
require 'helpers'
require 'json'

get '/test' do
  @elements = get_config('config.yml', "elements")
  @elements = @elements.to_a
  slim :test
end

get '/elements.json' do
  @elements = get_config('config.yml', 'elements')
  @elements = @elements.to_a.shuffle
  JSON.dump(@elements)
end
