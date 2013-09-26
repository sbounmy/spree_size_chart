require 'spec_helper'

describe Spree::SizeChart do
  before do
    @option_type = create(:option_type, name: "Size")
    @option_value1 = create(:option_value, name: "M", option_type: @option_type)
    @option_value2 = create(:option_value, name: "L", option_type: @option_type)
    @option_value3 = create(:option_value, name: "XL", option_type: @option_type)

    @product = create(:product)
    @size_chart = create(:size_chart, option_type: @option_type, product: @product)
    @size_chart.size_types << @size_type1 = create(:size_type, name: "Chest")
    @size_chart.size_types << @size_type2 = create(:size_type, name: "Sleeves")
  end

  describe "#find_or_initialize_size_types" do

    it "initialize all size_values when no existing records" do
      @size_chart.find_or_initialize_size_values.count.should == 6
      @size_chart.find_or_initialize_size_values.all?(&:new_record?).should be_true
    end

    it "finds existing record and initialize size value left" do
      @size_value1 = create(:size_value, option_value: @option_value1, size_chart: @size_chart, size_type: @size_type1)
      @size_value2 = create(:size_value, option_value: @option_value1, size_chart: @size_chart, size_type: @size_type2)

      @size_chart.find_or_initialize_size_values.count.should == 6
      @size_chart.find_or_initialize_size_values.all?(&:new_record?).should be_false
      @size_chart.find_or_initialize_size_values.should include(@size_value1, @size_value2)
    end

  end

  describe "#hash_size_values" do
    before do
      @size_value1 = create(:size_value, option_value: @option_value1, size_chart: @size_chart, size_type: @size_type1)
      @size_value2 = create(:size_value, option_value: @option_value1, size_chart: @size_chart, size_type: @size_type2)
      @size_value3 = create(:size_value, option_value: @option_value3, size_chart: @size_chart, size_type: @size_type2)
    end

    it "returns hash with option_value_id as first key and size_type_id as second key" do
      @size_chart.hash_size_values.should == {@option_value1.id => {@size_type1.id => @size_value1, @size_type2.id => @size_value2}, @option_value3.id => {@size_type2.id => @size_value3}}
    end
  end

  describe "#find_size_values" do
    before do
      @variant = create(:variant, product: @product)
      @variant.option_values << @option_value3
      @size_value3 = create(:size_value, option_value: @option_value3, size_chart: @size_chart, size_type: @size_type2)
    end

    it "returns only if product variants has option_value" do
      @size_chart.find_size_values.count.should == 1
      @size_chart.find_size_values.first.should == @size_value3
    end
  end

  describe "size_values_attributes=" do
    before do
      @size_value1 = create(:size_value, option_value: @option_value1, size_chart: @size_chart, size_type: @size_type1)
      @size_value2 = create(:size_value, option_value: @option_value1, size_chart: @size_chart, size_type: @size_type2)
      @size_value3 = create(:size_value, option_value: @option_value3, size_chart: @size_chart, size_type: @size_type2)
    end

    it "should destroy existing record if value is blank" do
      @size_chart.update_attributes size_values_attributes: {"0"=>{"id" => @size_value1.id, "size_type_id"=> @size_type1.id, "option_value_id"=> @size_type1.id, "value"=>"" },
      "1"=>{"id" => @size_value2.id, "size_type_id"=> @size_type2.id, "option_value_id"=> @option_value1.id, "value"=>"123" }}
      @size_chart.size_values.count.should == 2
      @size_chart.size_value_ids.should =~ [@size_value2.reload.id, @size_value3.id]
      @size_chart.size_values.map(&:value).should =~ ['123', '74']
    end

    it "should destroy existing record if value is blank" do
      @size_chart.update_attributes size_values_attributes: {"0"=>{"size_type_id"=> @size_type1.id, "option_value_id"=> @option_value2.id, "value"=>"" }}
      @size_chart.size_values.count.should == 3
    end

  end
end
