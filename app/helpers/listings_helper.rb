module ListingsHelper
  
  def asset_classes(listing)
    asset_classes = []
    listing.properties.each do |property|
      asset_classes << property.asset_class if !property.asset_class.blank?
    end
    asset_classes.uniq
  end

  def asset_types(listing)
    asset_types = []
    listing.properties.each do |property|
      asset_types << property.primary_type if !property.primary_type.blank?
    end
    asset_types.uniq
  end

  def total_sf(listing)
    total_sf = 0

    listing.properties.each do |property|
      total_sf += property.sf if !property.sf.nil? 
    end

    total_sf.to_s(:delimited)
  end

  def total_units(listing)
    total_units = 0

    listing.properties.each do |property|
      total_units += property.units if !property.units.nil? 
    end

    total_units.to_s(:delimited)
  end

  def total_land_area(listing)
  	total_la = 0

    listing.properties.each do |property|
      total_la += property.land_area if !property.land_area.nil? 
    end

    total_la

  end

  def sf_price(listing)
  	total_sf = 0

    listing.properties.each do |property|
      total_sf += property.sf if !property.sf.nil? 
    end

    psf = listing.price / total_sf if !total_sf.nil? && !listing.price.nil? 

    psf

  end 

  def listing_state_color(listing)
    case listing.aasm_state
    when "draft"
      "bg-blue-100 text-blue-800"
    when "active"
      "bg-green-100 text-green-800"
    when "closed"
      "bg-gray-100 text-gray-800"
    when "inactive"
      "bg-yellow-100 text-yellow-800"
    end
  end

  def city_state(listing)
    if listing.properties.exists? 
      city = listing.properties.first.address_city
      state = listing.properties.first.address_state

      if !city.blank? && !state.blank? 
        city + ", " + state
      elsif !city.blank?
        city
      else
        state
      end
    else
      ""
    end
  end


  def listing_thumbnail(listing, options = {})
    size = options[:size] || 48
    classes = options[:class]

    if listing.listing_images.exists?
      image_tag listing.listing_images.first.image_url, class: classes
    else
      content = content_tag(:span, listing.title.to_s.first, class: "initials")

      content_tag :span, content, class: "avatar bg-blue-500 #{classes}"
    end
  end

end
