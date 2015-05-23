module PostsHelper

  def poster_for post, page
    page   ||= 1 # for when params[:page] is nil
    @count ||= 0
    if @count < 1 and page.to_i < 2
      @count += 1
      return "OP"
    else
      post_number = (page.to_i - 1) * 20 + @count
      @count += 1
    end
    post_number
  end
end
