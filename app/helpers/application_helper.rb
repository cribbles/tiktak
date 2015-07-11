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
    page_name = page_title.empty? ? '' : (' - ' + page_title)

    Settings.site_name + page_name 
  end

  def format_date(datetime)
    datetime.strftime("%-m/%-d/%y %I\:%M %p")
  end

  def format_text(text)
    (h text).gsub("\n", '<br />').html_safe
  end
end
