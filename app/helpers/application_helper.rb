require 'benchmark'

module ApplicationHelper
  def benchmark_start
    @benchmark ||= Time.now
  end

  def benchmark_result
    (Time.now - benchmark_start).round(3)
  end

  def titleize(page_title)
    page_name = (page_title.empty? ? "" : (" - " + page_title))

    Settings.site_name + page_name
  end

  def sizeify(page_size)
    page_size.empty? ? "large" : page_size
  end

  def format_date(datetime)
    datetime.strftime("%-m/%-d/%y %I\:%M %p")
  end

  def format_text(text)
    h(text).gsub("\n", "<br />").html_safe
  end
end
