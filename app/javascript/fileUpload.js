import 'uppy/dist/uppy.min.css'

import {
  Core,
  FileInput,
  Informer,
  ProgressBar,
  ThumbnailGenerator,
  Dashboard,
  XHRUpload,
  AwsS3,
  AwsS3Multipart,
} from 'uppy'




// document.addEventListener('turbolinks:load', () => {
//   document.querySelectorAll('[data-uppy]').forEach(element => setupUppy(element))
// })

// function setupUppy(element) {
//   let trigger = element.querySelector('[data-behavior="uppy-trigger"]')
//   let form = element.closest('form')
//   let direct_upload_url = document.querySelector("meta[name='direct-upload-url']").getAttribute("content")
//   let field_name = element.dataset.uppy

//   trigger.addEventListener("click", (event) => event.preventDefault())

//   let uppy = Core({
//     autoProceed: true,
//     allowMultipleUploads: true,
//     logger: Core.debugLogger
//   })

//   uppy.use(Dashboard, {
//     trigger: trigger,
//     closeAfterFinish: true,
//   })

//   uppy.use(AwsS3, {
//     companionUrl: '/', // will call the presign endpoint on `/s3/params`
//   })

//   uppy.on('upload-success', (file, response) => {
//     const hiddenInput = document.querySelector('.upload-data')
//     // construct uploaded file data in the format that Shrine expects
//     const uploadedFileData = {
//       id: file.meta['key'].match(/^cache\/(.+)/)[1], // object key without prefix
//       storage: 'cache',
//       metadata: {
//         size: file.size,
//         filename: file.name,
//         mime_type: file.type,
//       }
//     }

//     // set hidden field value to the uploaded file data so that it's submitted
//     // with the form as the attachment
//     hiddenInput.value = JSON.stringify(uploadedFileData)
//   })

//   uppy.on('complete', (result) => {
//     // Rails.ajax
//     // or show a preview:
//     element.querySelectorAll('[data-pending-upload]').forEach(element => element.parentNode.removeChild(element))

//     result.successful.forEach(file => {
//       appendUploadedFile(element, file, field_name)
//       setPreview(element, file)
//     })

//     uppy.reset()
//   })
// }

// function appendUploadedFile(element, file, field_name) {
//   const hiddenField = document.createElement('input')

//   hiddenField.setAttribute('type', 'hidden')
//   hiddenField.setAttribute('name', field_name)
//   hiddenField.setAttribute('data-pending-upload', true)
//   hiddenField.setAttribute('value', file.response.signed_id)

//   element.appendChild(hiddenField)
// }

// function setPreview(element, file) {
//   let preview = element.querySelector('[data-behavior="uppy-preview"]')
//   if (preview) {
//     let src = (file.preview) ? file.preview : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSpj0DBTVsaja01_xWh37bcutvpd7rh7zEd528HD0d_l6A73osY"
//     preview.src = src
//   }
// }




const randomstring = require('randomstring')

const singleFileUpload = (fileInput) => {
  const imagePreview = document.getElementById(fileInput.dataset.previewElement)
  const formGroup    = fileInput.parentNode

  formGroup.removeChild(fileInput)

  const uppy = fileUpload(fileInput)

  uppy
    .use(FileInput, {
      target: formGroup,
      locale: { strings: { chooseFiles: 'Choose file' } },
    })
    .use(Informer, {
      target: formGroup,
    })
    .use(ProgressBar, {
      target: imagePreview.parentNode,
    })
    .use(ThumbnailGenerator, {
      thumbnailWidth: 600,
    })

  uppy.on('upload-success', (file, response) => {
    const fileData = uploadedFileData(file, response, fileInput)

    // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
    const hiddenInput = document.getElementById(fileInput.dataset.uploadResultElement)
    hiddenInput.value = fileData
  })

  uppy.on('thumbnail:generated', (file, preview) => {
    imagePreview.src = preview
  })
}

const multipleImageUpload = (fileInput) => {
  const formGroup = fileInput.parentNode

  const uppy = fileUpload(fileInput)

  uppy
    .use(Dashboard, {
      target: formGroup,
      inline: true,
      width: "100%",
      height: 300,
      replaceTargetContent: true,
    })

  uppy.on('upload-success', (file, response) => {
    const hiddenField = document.createElement('input')

    hiddenField.type = 'hidden'
    console.log(file);
    console.log(response);
    hiddenField.name = `listing[listing_images_attributes][${randomstring.generate()}][image]`
    hiddenField.value = uploadedFileData(file, response, fileInput)

    document.querySelector('form').appendChild(hiddenField)
  })
}

const multipleFileUpload = (fileInput) => {
  const formGroup = fileInput.parentNode

  const uppy = fileUpload(fileInput)

  uppy
    .use(Dashboard, {
      target: formGroup,
      inline: true,
      width: "100%",
      height: 300,
      replaceTargetContent: true,
    })

  uppy.on('upload-success', (file, response) => {
    const hiddenField = document.createElement('input')

    hiddenField.type = 'hidden'
    console.log(file);
    console.log(response);
    hiddenField.name = `listing[listing_documents_attributes][${randomstring.generate()}][document]`
    hiddenField.value = uploadedFileData(file, response, fileInput)

    document.querySelector('form').appendChild(hiddenField)
  })
}

const multipleSecureFileUpload = (fileInput) => {
  const formGroup = fileInput.parentNode

  const uppy = fileUpload(fileInput)

  uppy
    .use(Dashboard, {
      target: formGroup,
      inline: true,
      width: "100%",
      height: 300,
      replaceTargetContent: true,
    })

  uppy.on('upload-success', (file, response) => {
    const hiddenField = document.createElement('input')

    hiddenField.type = 'hidden'
    console.log(file);
    console.log(response);
    hiddenField.name = `listing[listing_secure_documents_attributes][${randomstring.generate()}][secure_document]`
    hiddenField.value = uploadedFileData(file, response, fileInput)

    document.querySelector('form').appendChild(hiddenField)
  })
}

const fileUpload = (fileInput) => {
  const uppy = Core({
    id: fileInput.id,
    autoProceed: true,
    restrictions: {
      allowedFileTypes: fileInput.accept.split(','),
    },
  })

  if (fileInput.dataset.uploadServer == 's3') {
    uppy.use(AwsS3, {
      companionUrl: '/', // will call Shrine's presign endpoint mounted on `/s3/params`
    })
  } else if (fileInput.dataset.uploadServer == 's3_multipart') {
    uppy.use(AwsS3Multipart, {
      companionUrl: '/' // will call uppy-s3_multipart endpoint mounted on `/s3/multipart`
    })
  } else {
    uppy.use(XHRUpload, {
      endpoint: '/upload', // Shrine's upload endpoint
    })
  }

  return uppy
}

const uploadedFileData = (file, response, fileInput) => {
  if (fileInput.dataset.uploadServer == 's3') {
    const id = file.meta['key'].match(/^cache\/(.+)/)[1]; // object key without prefix

    return JSON.stringify(fileData(file, id))
  } else if (fileInput.dataset.uploadServer == 's3_multipart') {
    const id = response.uploadURL.match(/\/cache\/([^\?]+)/)[1]; // object key without prefix

    return JSON.stringify(fileData(file, id))
  } else {
    return JSON.stringify(response.body)
  }
}

// constructs uploaded file data in the format that Shrine expects
const fileData = (file, id) => ({
  id: id,
  storage: 'cache',
  metadata: {
    size:      file.size,
    filename:  file.name,
    mime_type: file.type,
  }
})

export { singleFileUpload, multipleFileUpload, multipleSecureFileUpload, multipleImageUpload }