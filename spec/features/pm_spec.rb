require 'rails_helper'

describe 'the private messaging system', type: :feature do

  before(:each) do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
  end

  let(:sender) do
    FactoryGirl.create(:activated_user, email: 'sender@example.com')
  end

  let(:recipient) do
    FactoryGirl.create(:activated_user, email: 'recipient@example.com')
  end

  it 'disallows a user from sending themselves a private message' do
    login_as('sender@example.com')
    expect(current_path).to eq '/'
    make_new_topic
    click_link 'Contact'
    expect(current_path).to eq '/topics/1'
    expect(page).to have_css 'alert'
  end

  it 'allows a user to private message another user and exchange e-mails' do
    login_as 'recipient@example.com'
    expect(current_path).to eq '/'
    make_new_topic
    log_out
    login_as 'sender@example.com'
    click_link 'Contact'
    expect(current_path).to eq '/topics/1/posts/1/contact'
    fill_in 'Title', with: 'Hello, sender!'
    fill_in 'Message', with: 'What\'s the haps?'
    check 'Offer to exchange e-mails?'
    click_button 'Post'
    expect(current_path).to eq '/private-messages/1'
    expect(page).to have_content 'Hello, sender!'
    expect(page).to have_content 'What\'s the haps?'
    log_out
    login_as 'recipient@example.com'
    click_link 'New PMs!'
    click_link 'Hello, sender!'
    expect(page).to have_content 'Anonymous'
    click_botton 'Exchange e-mails'
    expect(page).to_not have_content 'Anonymous'
    expect(page).to have_content 'recipient@example.com'
  end
end
