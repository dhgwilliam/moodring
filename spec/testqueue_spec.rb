require 'spec_helper'

describe TestQueue do
  describe '#new' do
    it 'should create a new TestQueue' do
      expect(subject).to be
    end

    it 'should return a TestQueue with a stack' do
      expect(subject.stack).to include(:sad)
    end
  end
end
