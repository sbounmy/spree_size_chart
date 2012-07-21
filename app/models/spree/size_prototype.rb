module Spree
  class SizePrototype < ActiveRecord::Base
    attr_accessible :name, :image_attributes
    has_one :image, :as => :viewable

    accepts_nested_attributes_for :image
  end
end