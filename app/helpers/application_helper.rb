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

  def format_date(datetime)
    datetime.strftime("%-m/%-d/%y %I\:%M %p")
  end

  def info_cell
    @info_cell ||= 'info'
    @info_cell = (@info_cell == 'info') ? 'cell4' : 'info'
  end

  def dot_notation(ip_addr)
    [24, 16, 8, 0].map {|b| (ip_addr.to_i >> b) & 255}.join('.')
  end
end
