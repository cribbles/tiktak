module Anchorable
  extend ActiveSupport::Concern

  def anchor
    index.to_s
  end
end
