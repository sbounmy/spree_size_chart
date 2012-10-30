FactoryGirl.define do

  factory :size_type, :class => Spree::SizeType do |t|
    t.name  "Chest"
  end

  factory :size_chart, :class => Spree::SizeChart do |t|
    t.association(:product)
    t.association(:option_type)
  end

  factory :size_value, :class => Spree::SizeValue do |t|
    t.value 74
    t.association(:option_value)
    t.association(:size_type)
    t.association(:size_chart)
  end

end