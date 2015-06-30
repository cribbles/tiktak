require 'rails_helper'

describe Topic do
  let(:topic) do
    FactoryGirl.create(:topic)
  end

  it 'is valid with valid attributes' do
    expect(topic).to be_valid
  end

  it 'should be visible by default' do
    expect(topic.visible).to be true
  end

  it 'should not be hellbanned by default' do
    expect(topic.hellbanned).to be false 
  end

  describe 'validations' do
    it 'requires a title' do
      topic.title = nil
      expect(topic).to_not be_valid
    end

    it 'limits a title to 140 characters' do
      topic.title = 'x' * 141
      expect(topic).to_not be_valid
    end
  end
end
