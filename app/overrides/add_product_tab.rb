Deface::Override.new( :virtual_path => "spree/admin/shared/_product_tabs",
                      :name => "add_size_chart_product_tabs",
		      :insert_bottom => '[data-hook="admin_product_tabs"]',
                      :text => %Q{<li<%== ' class="active"' if current == 'Size Chart' %>>
                        <%= link_to_with_icon 'icon-table', t(:size_chart), edit_admin_product_size_chart_url(@product) %>
                      </li>})