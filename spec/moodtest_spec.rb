require 'spec_helper'

describe MoodTest do
  describe '#new' do
    it 'should raise an error if required args aren\'t present' do
      expect { MoodTest.new }.to raise_error
      expect { MoodTest.new({ :date => Time.now }) }.to raise_error(ArgumentError, /must be instantiated/)
      expect { MoodTest.new({ :user => "david" }) }.to raise_error(ArgumentError, /must be instantiated/)
    end

    it 'should exist when created' do
      now = Time.now
      user = "david"

      m = MoodTest.new({:date => now, :user => user})
      expect(m.date).to eq(now)
      expect(m.user).to eq(user)
    end
  end
end
