class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def last_page_of topic
    topic.posts.paginate(page: 1, per_page: 20).total_pages
  end
end
