$:.unshift('lib')
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'moodring'
require 'yajl'

get "/api/v1/list" do
  list = MoodList.moods.map {|x| x.name}
  Yajl::Encoder.encode(list)
end
