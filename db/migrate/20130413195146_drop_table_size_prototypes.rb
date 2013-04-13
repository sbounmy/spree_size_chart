class DropTableSizePrototypes < ActiveRecord::Migration
  def up
    drop_table :spree_size_prototypes if table_exists? :spree_size_prototypes
  end
end
