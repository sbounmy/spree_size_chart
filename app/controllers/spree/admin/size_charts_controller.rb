module Spree
  module Admin
    class SizeChartsController < ResourceController

      def edit
        @product = Product.find_by_permalink params[:product_id]
        @size_chart = @product.size_chart || @product.build_size_chart
      end

      def update
        @product = Product.find_by_permalink params[:product_id]
        if (@product.size_chart || @product.build_size_chart).update_attributes params[:size_chart]
          flash[:notice] = "Size Chart successfully updated"
        else
        end
        redirect_to edit_admin_product_size_chart_path(@product)
      end

      def collection_url
        admin_product_size_chart_url(@product)
      end
    end
  end
end