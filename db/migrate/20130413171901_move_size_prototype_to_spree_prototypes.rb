class MoveSizePrototypeToSpreePrototypes < ActiveRecord::Migration
  def up
    class SizePrototype < ActiveRecord::Base
      has_one :image, :as => :viewable
    end

    prototypes = {}
    # For each size prototype create its corresponding Spree::Prototype by prefixing name 'SizeChart : %{name}'
    Spree::SizePrototype.all.each do |prototype|
      say "Creating Spree::Prototype 'SizeChart : #{prototype.name}'"
      spree_prototype = Spree::Prototype.create(:name => "SizeChart : #{prototype.name}", :size_chart_image => prototype.image)

      prototypes[prototype.id] = spree_prototype.id
    end

    # move size chart prototype to newly create Spree::Prototype
    Spree::SizeChart.where('size_prototype_id IS NOT NULL').each do |chart|
      say "Updating Size chart##{chart.id}..."
      chart.update_attribute :size_prototype_id, prototypes[chart.size_prototype_id]
    end

    rename_column :spree_size_charts, :size_prototype_id, :prototype_id
  end

end
