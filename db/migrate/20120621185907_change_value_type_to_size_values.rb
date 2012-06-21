class ChangeValueTypeToSizeValues < ActiveRecord::Migration
  def up
    change_table :spree_size_values do |t|
      t.change :value, :string
    end
  end

  def down
    change_table :spree_size_values do |t|
      t.change :value, :decimal, :precision => 8, :scale => 2
    end
  end
end
