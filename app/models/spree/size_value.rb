module Spree
  class SizeValue < ActiveRecord::Base
    attr_accessible :size_type_id, :option_value_id, :value
    belongs_to  :size_type
    belongs_to  :size_chart
    belongs_to  :option_value
  end
end
