class TestQueue
  attr_reader :stack

  def initialize
    @stack = stack
  end

  def stack
    unless @stack
      @stack = Array.new
      MoodList.moods.each { |mood|
        @stack << mood.name }
    end
    @stack
  end
end
