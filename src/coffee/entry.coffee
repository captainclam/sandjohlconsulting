$ ->

  # main menu tabs
  $('.nav a').click (e) ->
    e.preventDefault()
    window.location.hash = $(this).attr('href')
    $('.section').hide()
    $('.nav li').removeClass('active')
    $(this).closest('li').addClass('active')
    sectionId = $(this).attr('href')
    $(sectionId).show()
    # $(sectionId).get(0).scrollIntoView()

  if window.location.hash
    window.scrollTo(0)
    link = $('.nav a[href='+window.location.hash+']')
    if link.length
      link.click()

  # section submenus
  # $('.section').each (i) ->
  #   menu = $ '<ul class="submenu">'
  #   $(this).find('.item').each (j) ->
  #     id = "item-#{i}-#{j}"
  #     $(this).attr 'id', id
  #     text = $(this).find('h3').text()
  #     btn = $ "<li><a href='##{id}'>#{text}</a></li>"
  #     menu.append btn
  #   if menu.children().length
  #     $(this).prepend menu


