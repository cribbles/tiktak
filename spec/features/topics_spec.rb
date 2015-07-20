require 'rails_helper'

describe 'posting a topic', type: :feature do

  let(:user) do
    FactoryGirl.create(:activated_user, email: 'activated_user@example.com')
  end

  it 'lets a valid user post a valid topic without logging in' do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
    visit '/'
    click_link 'New Topic'
    expect(current_path).to eq '/topics/new'
    make_new_topic(title: 'Inspiring topic title',
                   post:  'Bold and motivational message body')
    expect(current_path).to eq '/topics/1'
    expect(page).to have_content 'Inspiring topic title'
    expect(page).to have_content 'Bold and motivational message body'
    visit '/'
    expect(page).to have_content 'Inspiring topic title'
    expect(page).to have_content 'Bold and motivational message body'
  end

  it 'bars a blacklisted user from posting a topic' do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4', blacklisted: true)
    make_new_topic(title: 'Inspiring topic title',
                   post:  'Bold and motivational message body')
    expect(page).to_not have_content 'Inspiring topic title'
    visit '/'
    expect(page).to have_content 'Forbidden'
  end
end

describe 'viewing the topic list' do

  let(:topic) do
    FactoryGirl.create(:topic, title: 'Hellbanned topic', hellbanned: true)
  end

  let(:post) do
    FactoryGirl.create(:post,
      content: 'Hellbanned post', hellbanned: true, topic: topic)
  end

  it 'displays a hellbanned topic to a hellbanned ip address' do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4', hellbanned: true)
    visit '/'
    expect(page).to have_content 'Hellbanned topic'
  end

  it 'does not display a hellbanned topic to a non hellbanned ip address' do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
    visit '/'
    expect(page).to_not have_content 'Hellbanned topic'
  end
end
