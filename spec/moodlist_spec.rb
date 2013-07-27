require 'spec_helper'

describe MoodList do
  describe '.moods' do
    it 'should have some moods' do
      expect(MoodList.moods).to have_at_least(16).moods
    end
  end
end
