$:.unshift('lib', '.')
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'yajl'
require 'config/redis'
require 'config/datamapper'
require 'moodring'

get '/api/v1/list' do
  list = MoodList.moods.map {|x| x.name}
  Yajl::Encoder.encode(list)
end

post '/api/v1/test/:id/new' do
  test = MoodTest.create({:date => Time.now, :user => params[:id]})
  Yajl::Encoder.encode(test.next_question)
end
