class Set
  include DataMapper::Resource
  include Redis::Objects

  property :id, Serial

  # has 1, :user
  has n, :frames

  def populate
    Trait.all.each { |trait|
      f = Frame.new
      f.trait = trait
      self << f }
    self.save
  end
end

class Frame
  include DataMapper::Resource
  include Redis::Objects

  property :id, Serial
  property :score, Integer

  validates_within :score, :set => 0..3

  has 1, :trait
  belongs_to :set
end
