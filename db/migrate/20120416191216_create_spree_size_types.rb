class CreateSpreeSizeTypes < ActiveRecord::Migration
  def change
    create_table :spree_size_types do |t|
      t.string      :name

      t.timestamps
    end

    create_table :spree_size_charts_size_types do |t|
      t.references  :size_chart
      t.references  :size_type
    end

  end
end
