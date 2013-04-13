class CreateSpreeSizeTypesPrototypes < ActiveRecord::Migration
  def up
    create_table :spree_size_types_prototypes, :id => false do |t|
      t.references :prototype
      t.references :size_type
    end
  end

  def down
    drop_table :spree_size_types_prototypes
  end
end
