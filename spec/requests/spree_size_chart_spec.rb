require 'spec_helper'

feature "spree size chart" do
  before do
    @option_type = Factory(:option_type, :name => "Size")
    @option_value1 = Factory(:option_value, :name => "M", :option_type => @option_type)
    @option_value2 = Factory(:option_value, :name => "L", :option_type => @option_type)
    @option_value3 = Factory(:option_value, :name => "XL", :option_type => @option_type)
    @size_type1 = Factory(:size_type, :name => "Chest")
    @size_type2 = Factory(:size_type, :name => "Sleeves")
    @product = Factory(:product)
  end

  scenario "create size chart" do
    visit spree.edit_admin_product_path(@product)
    click_link "Size Chart"
    select "Size", :from => "Option Type"
    click_button "Create"
    save_and_open_page
    fill_in "size_chart_size_values_attributes_0_0_value", :with => 50
    fill_in "size_chart_size_values_attributes_1_1_value", :with => 70
    fill_in "size_chart_size_values_attributes_2_2_value", :with => 52
    fill_in "size_chart_size_values_attributes_3_3_value", :with => 74
    fill_in "size_chart_size_values_attributes_4_4_value", :with => 54
    fill_in "size_chart_size_values_attributes_5_5_value", :with => 76
    click_button "Create"
    save_and_open_page
  end
end