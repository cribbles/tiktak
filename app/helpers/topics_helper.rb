module TopicsHelper

  def top_partial
    @td_count ||= 0
    @td_count += 1
    "border-top: 7px solid #FFFFFF !important;" unless @td_count > 2
  end
end