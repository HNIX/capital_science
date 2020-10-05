import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "toggleable" ]

  connect() {
    this.toggleClass = this.data.get("class") || "hidden"
  }

  toggle(event) {
    event.preventDefault()

    this.toggleableTargets.forEach( target => {
      target.classList.toggle(this.toggleClass)
    })
  }

  clickOutside(event) {
    //event.preventDefault()
  
    // Ignore event if clicked within element
    if(this.element === event.target || this.element.contains(event.target)) return;
  
    // Execute the actual action we're interested in
    this.toggleableTargets.forEach( target => {
      if(!target.classList.contains('hidden')){
        target.classList.add('hidden');
       }
    })
  }
}
