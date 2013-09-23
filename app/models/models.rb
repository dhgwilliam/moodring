class Trait
  include DataMapper::Resource
  include Redis::Objects

  property :id,      Serial
  property :name,    String, :unique => true, :required => true, :index => true
  property :valence, Integer, :required => true
  property :arousal, Integer, :required => true
end

class Frame
  include DataMapper::Resource
  include Redis::Objects

  property :id,         Serial
  property :score,      Integer
  property :created_at, DateTime
  property :trait,      String

  belongs_to :testing
  belongs_to :user
end

class Testing
  include DataMapper::Resource
  include Redis::Objects

  property :id, Serial

  has n, :frames
  belongs_to :user

  def prime!
    Trait.all.each { |trait|
      f = Frame.create(:trait => trait.name, :testing => self, :user => self.user)
      self.frames << f }
    self.save
  end
end

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :frames, :through => :testings
  has n, :testings
end
