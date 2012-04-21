class AddUnitToSpreeSizeCharts < ActiveRecord::Migration
  def change
    add_column  :spree_size_charts, :unit, :string
  end
end
