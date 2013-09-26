require 'spec_helper'

feature "spree size chart", :js => true do
  stub_authorization!

  before do
    @option_type = create(:option_type, :name => "Size")
    @option_value1 = create(:option_value, :name => "M", :option_type => @option_type)
    @option_value2 = create(:option_value, :name => "L", :option_type => @option_type)
    @option_value3 = create(:option_value, :name => "XL", :option_type => @option_type)
    @size_type1 = create(:size_type, :name => "Chest")
    @size_type2 = create(:size_type, :name => "Sleeves")
    @product = create(:product)
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
    select2 'Chest', :from => 'Size Types'
    select2 'Sleeves', :from => 'Size Types'

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

    select2 'Chest', :from => 'Size Types'
    select2 'Sleeves', :from => 'Size Types'

    click_button "Create"

    fill_size_chart
    click_button "Create"

    fill_in "size_chart_size_values_attributes_0_value", :with => 52
    unselect2 "Sleeves", :from => 'Size Types'

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
    visit spree.new_admin_prototype_path
    fill_in "Name", :with => "Sleeveless Tshirt"
    select2 "Chest", :from => "Size Types"

    click_button "Create"

    visit spree.edit_admin_product_path(@product)
    click_link "Size Chart"

    select "Size", :from => "Option Type"
    select "Sleeveless Tshirt", :from => "Prototype"
    click_button "Create"
    page.should have_content "Size Chart successfully updated"

    within('#s2id_size_chart_size_type_ids ul.select2-choices') do
      page.should have_content('Chest')
      page.should_not have_content('Sleeves')
    end
  end

  scenario "chart with prototype can have custom size type" do
    visit spree.new_admin_prototype_path
    fill_in "Name", :with => "Sleeveless Tshirt"
    select2 "Chest", :from => "Size Types"

    click_button "Create"

    visit spree.edit_admin_product_path(@product)
    click_link "Size Chart"

    select "Size", :from => "Option Type"
    select "Sleeveless Tshirt", :from => "Prototype"
    click_button "Create"
    page.should have_content "Size Chart successfully updated"

    select2 'Sleeves', :from => 'Size Types'
    click_button "Create"

    within('#s2id_size_chart_size_type_ids ul.select2-choices') do
      page.should have_content('Chest')
      page.should have_content('Sleeves')
    end
  end

  scenario 'changing prototype should merge size types' do
    visit spree.new_admin_prototype_path
    fill_in "Name", :with => "Sleeveless Tshirt"
    select2 "Chest", :from => "Size Types"

    click_button "Create"

    visit spree.edit_admin_product_path(@product)
    click_link "Size Chart"

    select "Size", :from => "Option Type"
    select2 'Sleeves', :from => 'Size Types'
    click_button "Create"
    page.should have_content "Size Chart successfully updated"

    select "Sleeveless Tshirt", :from => "Prototype"
    click_button "Create"

    within('#s2id_size_chart_size_type_ids ul.select2-choices') do
      page.should have_content('Chest')
      page.should have_content('Sleeves')
    end
  end

  scenario 'default option type name' do
    SpreeSizeChart.default_option_type_name = 'color'
    @color = create(:option_type, :name => "color", :presentation => 'Color')

    visit spree.edit_admin_product_path(@product)
    click_link "Size Chart"
    page.should have_content('Edit')
    find_field('size_chart_option_type_id').value.to_i.should == @color.id
    SpreeSizeChart.default_option_type_name = 'size'
  end
end