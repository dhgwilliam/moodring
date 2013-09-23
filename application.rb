$:.unshift('lib', '.', 'app/models')
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'yajl'
require 'config/redis'
require 'config/datamapper'
require 'moodring'
require 'models'

# finalize all models
# XXX move to a more reasonable place
DataMapper.finalize

# retrieve list of all Traits
get '/api/v1/list' do
  list = Trait.all.map {|x| x.name}
  Yajl::Encoder.encode(list)
end

post '/api/v1/trait/new' do
  # is this rewind really necessary? it's in the sinatra docs...
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

# retrieve trait attributes
get '/api/v1/trait/by/name/:name' do
  Yajl::Encoder.encode(Trait.first(:name => params[:name]).attributes)
end

# TODO initiate test; the behavior of a test should be as follows:
#
# * a test belongs to a single user (for now, there is only one)
# * a test has as many elements as there are traits (hash?)
# * each test element has two qualities (key, value): trait, score
# * for the time being, we'll clone the behavior of Moodscope, e.g. score from
# 0..3
# I just talked about it with Suzy and I'm going to call it a Set, borrowed
# from volleyball, and a Set will have Frames, which refer to scored or
# unscored Traits
post '/api/v1/set/new' do
  "Create a new Set"
end
