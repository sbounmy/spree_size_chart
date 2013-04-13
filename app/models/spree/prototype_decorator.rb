Spree::Prototype.class_eval do
  has_one :size_chart_image, :as => :viewable, :class_name => 'Spree::Image'
  attr_accessible :size_chart_image_attributes

  accepts_nested_attributes_for :size_chart_image
end