Deface::Override.new( :virtual_path => "spree/products/show",
                      :name => "add_size_chart_to_show_product",
                      :insert_bottom => '[data-hook="product_left_part_wrap"]',
                      :partial => "spree/shared/size_chart")