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

#  def render_header
#    render 'layouts/header'
#  end
#
#  def render_header_links
#    links = []
#    links << link_to('Home',   root_path)  unless current_page?(root_path)
#    links << link_to('Log In', login_path) unless logged_in? \
#                                               || current_page?(login_path)
#    links << link_to('Topic',  @topic)     unless @topic.nil? \
#                                               || current_page?(action: 'show')
#    links << link_to('New Topic', new_topic_path) if current_page?(root_path)
#    links.join ' &nbsp;|&nbsp; '
#  end

end
