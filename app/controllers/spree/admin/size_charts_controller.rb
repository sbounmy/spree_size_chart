module Spree
  module Admin
    class SizeChartsController < ResourceController
      belongs_to 'spree/product', :find_by => :permalink

      def edit
      end

      def update
        if @size_chart.update_attributes params[:size_chart]
          flash[:notice] = "Size Chart successfully updated"
        else
        end
        redirect_to edit_admin_product_size_chart_path(parent)
      end

      def collection_url
        admin_product_size_chart_url(parent)
      end

      def load_resource_instance
        @size_chart ||= parent.size_chart || parent.build_size_chart
      end
    end
  end
end