require 'rails_helper'

describe 'the login process', type: :feature do

  before(:each) do
    FactoryGirl.create(:ip_cache, ip_address: '1.2.3.4')
  end

  let!(:new_user) do
    FactoryGirl.create(:user, email: 'new_user@example.com')
  end

  let!(:activated_user) do
    FactoryGirl.create(:activated_user, email: 'activated_user@example.com')
  end

  it 'logs in an activated user' do
    visit '/login'
    fill_in 'E-mail', with: 'activated_user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    expect(current_path).to eq '/'
  end

  it 'does not log in an unactivated user' do
    visit '/login'
    fill_in 'E-mail', with: 'new_user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    expect(current_path).to eq '/login'
    expect(page).to have_selector '.alert'
  end
end
