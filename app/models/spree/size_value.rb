module Spree
  class SizeValue < ActiveRecord::Base
    belongs_to  :size_type
    belongs_to  :size_chart
    belongs_to  :option_value
  end
end