class MoodTest
  attr_reader :date, :user

  def initialize(args)
    raise ArgumentError, "MoodTest must be instantiated with a date and a user param" unless args[:date] and args[:user]
    @date = args[:date]
    @user = args[:user]
  end
end
