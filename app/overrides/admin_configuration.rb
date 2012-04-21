Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_size_chart_type_link_configuration_menu",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text => %q{<%= configurations_sidebar_menu_item t("size_types"), admin_size_types_path %>},
                     :disabled => false)


Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                    :name => "add_size_types_to_configuration_menu",
                    :insert_bottom => "[data-hook='admin_configurations_menu']",
                    :partial => "spree/admin/shared/configurations_menu",
                    :original => '2645fce66adc090d7ce0aa34f7cdfcaabf1be9f0',
                    :disabled => false)