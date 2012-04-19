Deface::Override.new( :virtual_path => "spree/admin/shared/_product_tabs",
                      :name => "add_size_chart_product_tabs",
                      :insert_bottom => 'ul[data-hook="admin_product_tabs"].sidebar.product-menu',
                      :text => %Q{<li<%== ' class="active"' if current == 'SizeChart' %>>
                        <%= link_to t(:size_chart), edit_admin_product_size_chart_url(@product) %>
                      </li>})