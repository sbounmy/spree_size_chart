  # use for multi select 2 without remote data loading
  #
  # No remote data loading
  # select2 'shirt', :from => 'Taxon', :remote => false
  def mselect2(value, options)
    id = find_label_by_text(options[:from])
    options[:from] = "#s2id_#{id}"

    find("#{options[:from]} ul.select2-choices").click
    find(:xpath, "//div[@class='select2-result-label' and contains(., '#{value}')]").click
  end