require 'rails_helper'

describe 'posting a topic', type: :feature do

  before(:each) do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
  end

  let(:user) do
    FactoryGirl.create(:activated_user, email: 'activated_user@example.com')
  end

  it 'lets a valid user post a valid topic without logging in' do
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
end
