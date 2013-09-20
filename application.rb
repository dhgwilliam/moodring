$:.unshift('lib')
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'moodring'
require 'yajl'

get '/list' do
  list = MoodList.moods.map {|x| x.name}
  Yajl::Encoder.encode(list)
end
