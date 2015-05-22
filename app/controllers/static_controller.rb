class StaticController < ApplicationController
  def terms
  end

  def faq
  end

  def stats
  end

  def topics
    @topics = Topic.paginate(page: params[:page])
  end
end
