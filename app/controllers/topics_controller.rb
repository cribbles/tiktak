class TopicsController < ApplicationController

  def create
  end

  def destroy
  end

  def show
  end

  def index
    @topics = Topic.paginate(page: params[:page])
  end
end
