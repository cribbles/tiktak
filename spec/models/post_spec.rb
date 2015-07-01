require 'rails_helper'

describe Post do
  let(:post) { FactoryGirl.create(:post) }

  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end

  it 'should be visible by default' do
    expect(post.visible).to be true
  end

  it 'should not be hellbanned by default' do
    expect(post.hellbanned).to be false
  end

  describe 'validations' do
    it 'requires content' do
      post.content = nil
      expect(post).to_not be_valid
    end

    it 'limits content to 50000 characters' do
      post.content = 'x' * 50001
      expect(post).to_not be_valid
    end

    it 'requires associated topic' do
      post.topic = nil
      expect(post).to_not be_valid
    end
  end
end
