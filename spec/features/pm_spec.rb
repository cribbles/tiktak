require 'rails_helper'

describe 'the private messaging system', type: feature do

  before(:each) do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
  end

  let(:sender) do
    FactoryGirl.create(:activated_user, email: 'sender@example.com')
  end

#  let(:recipient) do
#    FactoryGirl.create(:activated_user, email: 'recipient@example.com')
#  end

  it 'disallows a user from sending themselves a private message' do
    visit '/login'
    fill_in 'E-mail', with: 'sender@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    expect(current_path).to eq '/'
    expect(page).to have_content 'sender@example.com'
    click_link 'New Topic'
    fill_in 'Title', with: 'Inspiring topic title'
    fill_in 'Message', with: 'Bold and motivational message body'
    click_button 'Post'
    expect(current_path).to eq '/topics/1'
    click_link 'Contact'
    expect(current_path).to eq '/topics/1'
    expect(page).to have_css 'alert'
  end
end
