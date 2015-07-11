module Anchorable
  extend ActiveSupport::Concern

  def anchor
    'p' + self.id.to_s
  end
end
