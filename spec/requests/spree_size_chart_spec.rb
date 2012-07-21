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

  def fill_size_chart
    fill_in "size_chart_size_values_attributes_0_value", :with => 50
    fill_in "size_chart_size_values_attributes_1_value", :with => 70

    fill_in "size_chart_size_values_attributes_2_value", :with => 54
    fill_in "size_chart_size_values_attributes_3_value", :with => 76

    fill_in "size_chart_size_values_attributes_4_value", :with => 56
    fill_in "size_chart_size_values_attributes_5_value", :with => 78
  end

  scenario "create size chart" do
    visit spree.edit_admin_product_path(@product)
    click_link "Size Chart"
    select "Size", :from => "Option Type"
    check "Chest"
    check "Sleeves"
    click_button "Create"

    fill_size_chart
    click_button "Create"

    visit spree.product_path(@product)
    page.should have_content "50"
    page.should have_content "70"
  end

  scenario "update size chart" do
    visit spree.edit_admin_product_path(@product)
    click_link "Size Chart"
    select "Size", :from => "Option Type"
    check "Chest"
    check "Sleeves"
    click_button "Create"

    fill_size_chart
    click_button "Create"

    fill_in "size_chart_size_values_attributes_0_value", :with => 52
    uncheck "Sleeves"

    click_button "Create"

    visit spree.product_path(@product)
    # should have chest size
    page.should have_content "52"
    page.should have_content "54"
    page.should have_content "56"

    # should not have sleeves size
    page.should_not have_content "70"
    page.should_not have_content "76"
    page.should_not have_content "78"
  end

  scenario "chart can have a prototype" do
    visit spree.new_admin_size_prototype_path
    fill_in "Name", :with => "TSHIRT"
    click_button "Create"

    visit spree.edit_admin_product_path(@product)
    click_link "Size Chart"
    select "Size", :from => "Option Type"
    check "Chest"
    check "Sleeves"
    select "TSHIRT", :from => "Size Prototype Id"
    click_button "Create"

    page.should have_content "Size Chart successfully updated"
  end
end