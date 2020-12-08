module PropertiesHelper
 
    def property_thumbnail(property, options = {})
      size = options[:size] || 48
      classes = options[:class]
  
      if property.property_images.exists?
        image_tag property.property_images.first.image_url, class: classes
      else
        content = content_tag(:span, property.name.to_s.first, class: "initials")
  
        content_tag :span, content, class: "avatar bg-blue-500 #{classes}"
      end
    end
  
  end
  