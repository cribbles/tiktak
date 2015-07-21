require 'rails_helper'

describe 'the moderation system', type: :feature do

  before(:each) do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
  end

  let(:user) do
    FactoryGirl.create(:user, email: 'user@example.com')
  end

  let(:admin_user) do
    FactoryGirl.create(:admin_user, email: 'admin@example.com')
  end

  let(:topic) do
    FactoryGirl.create(:topic)
  end

  let(:post) do
    FactoryGirl.create(:post)
  end

  it 'requires users to be logged in to report posts' do
    visit '/topics/1'
    click_link 'Report'
    expect(current_path).to eq '/login'
  end
end
