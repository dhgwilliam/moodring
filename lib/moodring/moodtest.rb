class MoodTest
  attr_reader :date, :user

  def initialize(args)
    @date = args[:date]
    @user = args[:user]
    @questions = questions
    @answers = []
  end

  def answers
    @answers
  end

  def complete?
    @answers.count == @questions ? true : false
  end

  def questions
    @questions || TestQueue.new.stack
  end
end
