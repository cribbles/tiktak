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
    page_title.empty? ? Settings.site_name : Settings.site_name + " - " + page_title
  end

  def format_date(datetime)
    datetime.strftime("%-m/%-d/%y %I\:%M %p")
  end

  def info_cell
    @info_cell ||= 'info'
    @info_cell = (@info_cell == 'info') ? 'cell4' : 'info'
  end
end
