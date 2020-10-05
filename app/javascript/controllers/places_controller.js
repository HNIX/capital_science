import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "field", "latitude", "longitude", "home", "street", "city", "region", "postalCode" ]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))
  }

  placeChanged() {
    let place = this.autocomplete.getPlace()

    if (!place.geometry) {
      window.alert(`No details available for input: ${place.name}`)
      return
    }

    console.log(place);

    var address_components = place.address_components

    var ShouldBeComponent = {
      home: ["street_number"],
      postal_code: ["postal_code"],
      street: ["street_address", "route"],
      region: [
        "administrative_area_level_1",
        "administrative_area_level_2",
        "administrative_area_level_3",
        "administrative_area_level_4",
        "administrative_area_level_5"
      ],
      city: [
        "locality",
        "sublocality",
        "sublocality_level_1",
        "sublocality_level_2",
        "sublocality_level_3",
        "sublocality_level_4"
      ],
      country: ["country"]
    };

    var address = {
      home: "",
      postal_code: "",
      street: "",
      region: "",
      city: "",
      country: ""
    };
    
    address_components.forEach(function(component) {
      for (var shouldBe in ShouldBeComponent) {
        if (ShouldBeComponent[shouldBe].indexOf(component.types[0]) !== -1) {
          if (shouldBe === "country" || shouldBe === "region") {
            address[shouldBe] = component.short_name;
          } else {
            address[shouldBe] = component.long_name;
          }
        }
      }
    });

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
    this.homeTarget.value = address.home
    this.streetTarget.value = address.street
    this.cityTarget.value = address.city
    this.regionTarget.value = address.region
    this.postalCodeTarget.value = address.postal_code
  }

  keydown(event) {
    if (event.key == "Enter") {
      event.preventDefault()
    }
  }
}