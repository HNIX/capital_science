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
      total_sf += property.sf
    end

    total_sf.to_s(:delimited)
  end

  def total_units(listing)
    total_units = 0

    listing.properties.each do |property|
      total_units += property.units
    end

    total_units.to_s(:delimited)
  end

  def total_land_area(listing)
  	total_la = 0

    listing.properties.each do |property|
      total_la += property.land_area
    end

    total_la

  end

  def sf_price(listing)
  	total_sf = 0

    listing.properties.each do |property|
      total_sf += property.sf
    end

    psf = listing.price / total_sf

    psf

  end 

end
