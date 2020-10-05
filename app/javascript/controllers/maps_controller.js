import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "map" ]

  connect() {
    if (typeof (google) != "undefined") {
        this.initMap()
    }
  }

  initMap() {
    var properties = JSON.parse(document.querySelector("#map").dataset.properties)
    var bounds = new google.maps.LatLngBounds();
    
    var map = new google.maps.Map(this.mapTarget, {
        center: new google.maps.LatLng(properties[0].latitude || 39.5, properties[0].longitude || -98.35),
        zoom: (properties[0].latitude == null ? 4 : 15)
    })

    properties.forEach(function(property) {
        if (property.latitude && property.longitude) {
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(property.latitude, property.longitude),
                title: property.address,
                map: map,
                anchorPoint: new google.maps.Point(0, -29),
                infoWindow: { 
                    content: `<p><a href='/properties/${property.id}'>${property.address}</a></p>`
                }
            });

            //extend the bounds to include each marker's position
            bounds.extend(marker.position);
        }
    });

    //now fit the map to the newly inclusive bounds
    if(properties.length > 1) {
      map.fitBounds(bounds);
    }   
   
  }
  
}


  

