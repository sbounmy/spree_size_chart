module Spree
  class SizeChart < ActiveRecord::Base
    UNITS = ['cm', 'inch']

    belongs_to  :option_type, :class_name => "Spree::OptionType"
    belongs_to  :product
    has_many    :option_values, :through => :option_type
    has_and_belongs_to_many :size_types, :class_name => "Spree::SizeType", :join_table => "spree_size_charts_size_types"
    has_many    :size_values, :class_name => "Spree::SizeValue"

    accepts_nested_attributes_for :size_values, :reject_if => proc { |attributes| attributes['value'].blank? }
    attr_accessible :size_values_attributes, :size_type_ids, :unit, :option_type_id

    def find_or_initialize_size_values
      @size_values = []
      option_value_ids.each do |opt_value_id|
        size_type_ids.each do |size_type_id|
          @size_values << find_or_initialize_size_value(opt_value_id, size_type_id)
        end
      end

      @size_values
    end

    def find_or_initialize_size_value(opt_value_id, size_type_id)
      (hash_size_values[opt_value_id] and hash_size_values[opt_value_id][size_type_id]) || size_values.build(:size_type_id => size_type_id, :option_value_id => opt_value_id)
    end

    def hash_size_values
      return @hsize_values if @hsize_values
      @hsize_values = {}
      size_values(true).each do |size_val|
        if @hsize_values[size_val.option_value_id]
          @hsize_values[size_val.option_value_id].merge!(size_val.size_type_id => size_val)
        else
          @hsize_values[size_val.option_value_id] = { size_val.size_type_id => size_val }
        end
      end
      @hsize_values
    end
  end

end