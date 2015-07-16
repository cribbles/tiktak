require 'rails_helper'

describe 'the login/logout process', type: :feature do

  before(:each) do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
  end

  let!(:new_user) do
    FactoryGirl.create(:user, email: 'new_user@example.com')
  end

  let!(:activated_user) do
    FactoryGirl.create(:activated_user, email: 'activated_user@example.com')
  end

  it 'does not log in user with invalid information' do
    login_as('', password: '')
    expect(current_path).to eq '/login'
    expect(page).to have_selector '.alert'
  end

  it 'does not log in an unactivated user' do
    login_as('new_user@example.com')
    expect(current_path).to eq '/login'
    expect(page).to have_selector '.alert'
  end

  it 'does not log in user with incorrect password' do
    login_as('activated_user@example.com', password: 'wrong_password')
    expect(current_path).to eq '/login'
    expect(page).to have_selector '.alert'
  end

  it 'logs in from root_path as an activated user followed by log out' do
    visit '/'
    click_link 'Log In'
    expect(current_path).to eq '/login'
    fill_in 'E-mail', with: 'activated_user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    expect(current_path).to eq '/'
    click_link 'Log Out'
    expect(current_path).to eq '/'
    expect(page).not_to have_link 'Log Out'
  end
end
