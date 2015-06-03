require 'benchmark'

module ApplicationHelper
  def benchmark
    @benchmark ||= Time.now
  end

  def width_override(width)
    width = 695 if width.empty?
    "width: #{width}px !important;"
  end

  def full_title(page_title = '')
    base_title = "WesACB"
    page_title.empty? ? base_title : base_title + " - " + page_title
  end

  def sanitize_date(datetime)
    datetime.strftime("%-m/%-d/%y %I\:%M %p")
  end

  def last_page_of(topic)
    topic.posts.paginate(page: 1, per_page: 20).total_pages
  end
end
