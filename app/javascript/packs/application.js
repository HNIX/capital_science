/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Rails functionality
window.Rails = require("@rails/ujs")
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("trix")
require("@rails/actiontext")
require("jquery")

// Tailwind CSS
import "stylesheets/application"

// Stimulus controllers
import "controllers"

// Jumpstart Pro & other Functionality
import "src/actiontext"
import "src/confirm"
import "src/direct_uploads"
import "src/forms"
import "src/timezone"
import "src/tooltips"
import "src/wizard"


import { singleFileUpload, multipleFileUpload, multipleImageUpload, multipleSecureFileUpload } from 'fileUpload'

// Use 'DOMContentLoaded' event if not using Turbolinks
document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('input[type=file]').forEach(fileInput => {
    if (fileInput.multiple && fileInput.id == "listing_listing_documents") {
      multipleFileUpload(fileInput)
    } else if (fileInput.multiple && fileInput.id == "listing_listing_images") {
      multipleImageUpload(fileInput)
    } else if (fileInput.multiple && fileInput.id == "listing_listing_secure_documents") {
      multipleSecureFileUpload(fileInput)
    } else {
      singleFileUpload(fileInput)
    }
  })
})

// listen on 'turbolinks:load' instead of 'DOMContentLoaded' if using Turbolinks
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.upload-file').forEach(fileInput => {
    fileUpload(fileInput)
  })
})


import LocalTime from "local-time"
LocalTime.start()

// ADD YOUR JAVACSRIPT HERE


// Start Rails UJS
Rails.start()
