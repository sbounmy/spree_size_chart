module Spree
  module Admin
    class SizePrototypesController < ResourceController
      def index
        respond_with(collection) do |format|
          format.html
          format.json { render :json => json_data }
        end
      end
    end
  end
end