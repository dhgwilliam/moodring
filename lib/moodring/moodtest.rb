class MoodTest
  attr_reader :date, :user

  def initialize(args)
    @date = args[:date] || Time.now
    @user = args[:user]
    @questions = questions
    @answers = answers
  end

  def answers
    @answers || []
  end

  def complete?
    @questions.empty?
  end

  def questions
    @questions || TestQueue.new.stack
  end

  def next_question
    @questions.shift.to_s
  end
end
