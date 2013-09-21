$:.unshift('lib', '.', 'app')
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'yajl'
require 'config/redis'
require 'config/datamapper'
require 'moodring'
require 'models/trait'

DataMapper.finalize

get '/api/v1/list' do
  list = Trait.all.map {|x| x.name}
  Yajl::Encoder.encode(list)
end

post '/api/v1/test/:id/new' do
  test = MoodTest.create({:date => Time.now, :user => params[:id]})
  Yajl::Encoder.encode(test.next_question)
end

post '/api/v1/trait/new' do
  request.body.rewind
  data = Yajl::Parser.parse(request.body.read)
  trait = Trait.new(
    :name    => data["name"],
    :valence => data["valence"],
    :arousal => data["arousal"]
  )
  if trait.valid?
    trait.save
  else
    400
  end
end

get '/api/v1/trait/:id' do
  trait = Trait.get(params[:id])

end
