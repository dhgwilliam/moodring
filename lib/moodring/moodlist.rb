class MoodList
  Mood = Struct.new(:name, :valence, :arousal)

  def self.moods
    [ Mood.new(:alert,       1, 1),
      Mood.new(:excited,     1, 1),
      Mood.new(:elated,      1, 1),
      Mood.new(:happy,       1, 1),
      Mood.new(:contented,   1,-1),
      Mood.new(:serene,      1,-1),
      Mood.new(:relaxed,     1,-1),
      Mood.new(:calm,        1,-1),
      Mood.new(:sad,        -1,-1),
      Mood.new(:depressed,  -1,-1),
      Mood.new(:bored,      -1,-1),
      Mood.new(:fatigued,   -1,-1),
      Mood.new(:tense,      -1, 1),
      Mood.new(:nervous,    -1, 1),
      Mood.new(:stressed,   -1, 1),
      Mood.new(:upset,      -1, 1),
    ]
  end
end
