SpreeSizeChart
==============

SpreeSizeChart feature extracted from [http://www.hallyustyle.com](http://www.hallyustyle.com).

SpreeSizeChart is a spree extension helping your store to provide pertinent product information.

Example
-------

![Spree SizeChart Admin](http://i49.tinypic.com/27ybj8x.png)

![Spree SizeChart Store](http://i50.tinypic.com/wk2fs.png)

Installation
------------

To install SpreeSizeChart, just add the following to your Gemfile:

```ruby
# for spree 1.0.X
gem 'spree_size_chart', '~> 1.0.0'

# for spree 1.1.X
gem 'spree_size_chart', '~> 1.1.0'

```

Now, bundle up and run the generator:

```ruby
bundle
rails g spree_minicart:install
```

Customization
-------------

The SizeChart markup should let you customize the way you want your SizeChart by using Deface or overriding views/spree/shared/_size_chart_.html.erb in your spree app.

If you want to display yourself the size chart, just disable the deface :

```ruby
# disable size_chart, explicitly put in the view
Deface::Override.new( :virtual_path => "spree/products/show",
                      :name => "add_size_chart_to_show_product",
                      :replace => '',
                      :disabled => true)
```

See [Spree Guide](http://guides.spreecommerce.com/view_customization.html) for more information.


Todo
-------

- Better html markup and HTML test for customization
- Add translation to size type.

Compatibility
------------

Tested under Spree 1.0.4
Need feedback on Spree 1.1.X


Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec


Contribute
----------

Pull requests for features and bug fix with tests are welcome.

Copyright (c) 2012 [Stephane BOUNMY], released under the New BSD License
