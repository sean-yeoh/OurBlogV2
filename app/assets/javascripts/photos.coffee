# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@uncheck = () ->
  $(event.target).siblings("input[type='checkbox']").prop("checked", false)
  $(event.target).siblings("a").children("img").removeClass("checked-photo")
  $(event.target).remove()

$(document).on "turbolinks:load", ->
  initPhotoSwipeFromDOM = (gallerySelector) ->
    $(gallerySelector)[0].setAttribute('data-pswp-uid', 1)
    hashData = photoswipeParseHash()
    if hashData.pid and hashData.gid
      openPhotoSwipe hashData.pid, $(gallerySelector)[hashData.gid - 1], true, true
    return

  parseThumbnailElements = (gallerySelector) ->
    thumbElements = $(gallerySelector).children()
    numThumbElements = thumbElements.length
    items = []
    for thumb in thumbElements
      link = $(thumb).find('a')
      dimensions = link.data('size').split('x')
      item = {
        src: link.attr("href"),
        w: parseInt(dimensions[0], 10),
        h: parseInt(dimensions[1], 10),
        msrc: link.find('img').attr('src')
        el: thumb
      }
      items.push(item)
    return items

  closest = (el, fn) ->
    el and (if fn(el) then el else closest(el.parentNode, fn))

  $('.photo-link').click ->
    if $('.pswp').length
      event.preventDefault()
      eTarget = event.target or event.srcElement
      clickedItem = closest(eTarget, (el) ->
        el.tagName and el.tagName.toUpperCase() == 'DIV'
      )
      clickedIndex = undefined
      for photo, index in $('.photo-gallery').children()
        if photo == clickedItem
          clickedIndex = index

      openPhotoSwipe(clickedIndex, $('.photo-gallery')[0])

    else if $("#edit-album-form").length
      event.preventDefault()
      if $(this).siblings("input[type='checkbox']").is(":checked")
        $(this).siblings("input[type='checkbox']").prop("checked", false)
        $(this).children("img").removeClass("checked-photo")
        $(this).siblings("p").remove()
      else
        $(this).siblings("input[type='checkbox']").prop("checked", true)
        $(this).children("img").addClass("checked-photo")
        $(this).parent().append("<p onclick='uncheck()' class='checked button alert'>Selected</p>")

  photoswipeParseHash = ->
    hash = window.location.hash.substring(1)
    params = {}
    if hash.length < 5
      return params
    vars = hash.split('&')
    i = 0
    while i < vars.length
      if !vars[i]
        i++
        continue
      pair = vars[i].split('=')
      if pair.length < 2
        i++
        continue
      params[pair[0]] = pair[1]
      i++
    if params.gid
      params.gid = parseInt(params.gid, 10)
    params

  openPhotoSwipe = (index, galleryElement, disableAnimation) ->
    pswpElement = $('.pswp')[0]
    items = parseThumbnailElements(galleryElement)
    options = {
      galleryUID: $(galleryElement).data('pswp-uid'),
      index: index,
      getThumbBoundsFn: (index) ->
        # See Options -> getThumbBoundsFn section of documentation for more info
        thumbnail = items[index].el.getElementsByTagName('img')[0]
        pageYScroll = window.pageYOffset or document.documentElement.scrollTop
        rect = thumbnail.getBoundingClientRect()
        {
          x: rect.left
          y: rect.top + pageYScroll
          w: rect.width
        }
    }
    if disableAnimation
      options.showAnimationDuration = 0
    gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options)
    gallery.init()

  if $('.pswp').length > 0
    initPhotoSwipeFromDOM('.photo-gallery')
