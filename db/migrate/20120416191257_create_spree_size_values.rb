class CreateSpreeSizeValues < ActiveRecord::Migration
  def change
    create_table :spree_size_values do |t|
      t.decimal     :value, :precision => 8, :scale => 2

      t.references  :option_value
      t.references  :size_type
      t.references  :size_chart
      t.timestamps
    end
  end
end
