require 'rails_helper'

describe 'the moderation system', type: :feature do

  before(:each) do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
  end

  let(:user) do
    FactoryGirl.create(:activated_user, email: 'user@example.com')
  end

  let(:admin_user) do
    FactoryGirl.create(:admin_user, email: 'admin@example.com')
  end

  let(:topic) do
    FactoryGirl.create(:topic, title: 'Inspiring topic title')
  end

  let(:post) do
    FactoryGirl.create(:post)
  end

  let(:flagged_post) do
    FactoryGirl.create(:post, flagged: true,
                              content: 'Bold and motivational message body')
  end

  it 'requires users to be logged in to report posts' do
    visit '/topics/1'
    expect(page).to have_content 'Report'
    click_link 'Report'
    expect(current_path).to eq '/login'
  end

  it 'displays delete links for admin users only' do
    login_as 'admin@example.com'
    visit '/'
    expect(page).to have_link 'X'
    visit '/topics/1'
    expect(page).to have_link 'X'
    log_out
    login_as 'user@example.com'
    expect(page).to_not have_link 'X'
    visit '/'
    expect(page).to_not have_link 'X'
  end

  it 'displays queue flash alert when logged in as an admin' do
    login_as 'admin@example.com'
    visit '/'
    expect(page).to have_css 'alert'
  end

  it 'displays flagged post in the queue' do
    login_as 'admin@example.com'
    visit '/queue'
    expect(page).to have_content 'Bold and motivational message body'
  end
end
