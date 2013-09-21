class Trait
  include DataMapper::Resource
  include Redis::Objects

  property :id,      Serial
  property :name,    String, :unique => true, :required => true, :index => true
  property :valence, Integer, :required => true
  property :arousal, Integer, :required => true
end
