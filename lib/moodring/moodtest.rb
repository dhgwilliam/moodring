class MoodTest
  attr_reader :date, :user

  def initialize(args)
    raise ArgumentError, "MoodTest must be instantiated with a date and a user param" unless args[:date] and args[:user]
    @date = args[:date]
    @user = args[:user]
    @questions = questions
    @answers = []
  end

  def record(key, value)
    key.to_s = value
  end

  def answers
    @answers
  end

  def complete?
    @answers.count == @questions ? true : false
  end

  def questions
    @questions || MoodList.moods
  end
end
