require 'spec_helper'

describe MoodTest do
  before(:all) do
    @now = Time.now
    @user = "david"
    @m = MoodTest.new({:date => @now, :user => @user})
  end

  describe 'instance' do
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
    it 'should return a list of moods' do
      expect(@m.questions).to have_at_least(16).moods
    end
  end

  describe '#next_question' do
    it 'should return a single mood as a string' do
      expect(@m.next_question).to be_a(String)
    end
  end

  describe 'questions queue' do
    it 'should be complete? when all the questions are popped' do
      counter, questions = 0, @m.questions.count
      until counter == questions
        @m.next_question
        counter += 1
      end
      expect(@m.complete?).to be_true
    end
  end
end
