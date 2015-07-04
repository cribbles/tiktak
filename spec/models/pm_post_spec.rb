require 'rails_helper'

describe PmPost do
  let(:pm_post) { FactoryGirl.create(:pm_post) }

  it 'is valid with valid attributes' do
    expect(pm_post).to be_valid
  end

  describe 'validations' do
    it 'requires content' do
      pm_post.content = nil
      expect(pm_post).to_not be_valid
    end

    it 'limits content to 50000 characters' do
      pm_post.content = 'x' * 50001
      expect(pm_post).to_not be_valid
    end

    it 'requires associated pm_topic' do
      pm_post.pm_topic = nil
      expect(pm_post).to_not be_valid
    end
  end
end
