class TopicsController < ApplicationController

  def create
  end

  def destroy
  end

  def show
  end

  def index
    @topics = Topic.paginate(page: params[:page], per_page: 20)
  end
end
