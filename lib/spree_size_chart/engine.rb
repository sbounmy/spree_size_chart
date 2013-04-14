module SpreeSizeChart
  mattr_accessor :default_option_type_name, :default_unit
  @@default_option_type_name = 'size'
  @@default_unit = 'cm'

  class Engine < Rails::Engine
    engine_name 'spree_size_chart'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
