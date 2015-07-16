module SessionsHelper

  def login_as(email, password: nil)
    password ||= password
    visit '/login'
    fill_in 'E-mail', with: email 
    fill_in 'Password', with: password
    click_button 'Log In'
  end

  def make_new_topic(title: nil, post: nil)
    title ||= 'Inspiring topic title'
    post  ||= 'Bold and motivational message body'
    visit '/topics/new'
    fill_in 'Title', with: title
    fill_in 'Message', with: post
    click_button 'Post'
  end

  def log_out
    visit '/logout'
  end
end

RSpec.configure do |config|
  config.include SessionsHelper, type: :feature
end
