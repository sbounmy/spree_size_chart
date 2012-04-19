class CreateSpreeSizeCharts < ActiveRecord::Migration
  def change
    create_table :spree_size_charts do |t|
      t.string      :name
      t.references  :product
      t.references  :option_type

      t.timestamps
    end
  end
end
