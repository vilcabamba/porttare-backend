# masonry to efficiently use vertical space
$(document).on "ready page:load", ->
  $grid = $(".resource-collection").masonry(
    itemSelector: ".resource-wrapper"
  )

  # reload masonry when images load
  $grid.imagesLoaded().progress ->
    $grid.masonry "layout"
