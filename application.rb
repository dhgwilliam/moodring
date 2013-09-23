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

configure do
  set :show_exceptions, false
end

# error handling
class ValidationError < StandardError
end

error ValidationError do
  env['sinatra.error'].message
end

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
    raise ValidationError, trait.errors.values
  end
end

# retrieve trait attributes
get '/api/v1/trait/by/name/:name' do
  Yajl::Encoder.encode(Trait.first(:name => params[:name]).attributes)
end

post '/api/v1/test/new' do
  request.body.rewind
  # client must submit user id
  data = Yajl::Parser.parse(request.body.read)
  test = Testing.new(:user => User.get(data["user"]))
  if test.valid?
    test.save
    test.prime!
    Yajl::Encoder.encode(test.attributes)
  else
    raise ValidationError, test.errors.values
  end
end

