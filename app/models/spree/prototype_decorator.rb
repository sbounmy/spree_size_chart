Spree::Prototype.class_eval do
  has_one :size_chart_image, :as => :viewable, :class_name => 'Spree::Image'
  attr_accessible :size_chart_image_attributes, :size_chart_image, :size_type_ids

  accepts_nested_attributes_for :size_chart_image

  has_and_belongs_to_many :size_types, :join_table => :spree_size_types_prototypes
end