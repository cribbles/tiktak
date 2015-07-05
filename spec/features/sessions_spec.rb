require 'rails_helper'

describe 'the login process', type: :feature do

  let!(:new_user) do
    FactoryGirl.create(:user, email: 'new_user@example.com')
  end

  let!(:activated_user) do
    FactoryGirl.create(:activated_user, email: 'activated_user@example.com')
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
