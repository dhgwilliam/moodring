require 'spec_helper'

describe MoodTest do
  describe 'instance' do
    before(:all) do
      @now = Time.now
      @user = "david"
      @m = MoodTest.new({:date => @now, :user => @user})
    end

    it 'should exist when created' do
      expect(@m.date).to eq(@now)
      expect(@m.user).to eq(@user)
    end

    it 'should contain an empty answers array' do
      expect(@m.answers).to eq([])
    end

    it 'should not be complete' do
      expect(@m.complete?).to be_false
    end
  end

  describe '#questions' do
    before(:all) do
      @now = Time.now
      @user = "david"
      @m = MoodTest.new({:date => @now, :user => @user})
    end

    it 'should return a list of moods' do
      expect(@m.questions).to have_at_least(16).moods
    end
  end
end
