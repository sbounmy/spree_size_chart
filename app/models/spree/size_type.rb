module Spree
  class SizeType < ActiveRecord::Base
    def name_with_unit(unit)
      if unit and !unit.blank?
        "#{name} (#{unit})"
      else
        name
      end
    end
  end
end