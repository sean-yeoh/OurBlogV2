# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Dropzone.autoDiscover = false

$(document).on "turbolinks:load", ->
  if $("#new_photo").length
    newPhoto = new Dropzone("#new_photo")
    Dropzone.options.newPhoto = false;
    newPhoto.options.acceptedFiles = ".jpeg,.jpg,.png,.gif";
    newPhoto.on 'complete', (files) ->
      _this = this
      if _this.getUploadingFiles().length == 0 and _this.getQueuedFiles().length == 0
        setTimeout (->
          $('#dropzone-form').foundation("close")
          acceptedFiles = _this.getAcceptedFiles()
          rejectedFiles = _this.getRejectedFiles()
          index = 0
          while index < acceptedFiles.length
            file = acceptedFiles[index]
            response = JSON.parse(file.xhr.response)
            addToGallery response.url, response.size
            index++
          if rejectedFiles.length != 0
            alert 'Error uploading ' + rejectedFiles.length + ' files. Only image files are accepted.'
          _this.removeAllFiles()
          return
        ), 2000
      return

  addToGallery = (url, size) ->
    $("#empty-album").remove()
    $(".photo-gallery").prepend(
      '<div class="small-6 medium-4 large-3 column photo-container">' +
        '<a class="photo-link" data-size="' + size + '" href="' + url + '">' +
          '<img style="background-image:url(' + url + ')"' + ' class="photo-image">'
        '</a>'
      '</div>'
    )
