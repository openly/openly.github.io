animateOnLoadItems = undefined
animateWithDelayItems = undefined
animateOnScrollItems = undefined

plainImg = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQMAAAAl21bKAAAAA1BMVEU0SV2weamTAAAAAXRSTlPM0jRW/QAAAApJREFUeJxjYgAAAAYAAzY3fKgAAAAASUVORK5CYII='

isMobileBrowser = ->
  if navigator.userAgent.match(/Android/i) or
      navigator.userAgent.match(/webOS/i) or
      navigator.userAgent.match(/iPhone/i) or
      navigator.userAgent.match(/iPad/i) or
      navigator.userAgent.match(/iPod/i) or
      navigator.userAgent.match(/BlackBerry/i) or
      navigator.userAgent.match(/Windows Phone/i)
    return true
  else
    return false


$ ->
  animateOnLoadItems = $('.do-animate').css('opacity', 0).show()
  animateWithDelayItems = $('.do-animate-with-delay').css('opacity', 0).show()
  animateOnScrollItems = $('.do-animate-on-scroll').css('opacity', 0).show()

  animateOnLoad = ->
    animateOnLoadItems?.css 'opacity', ''
    animateOnLoadItems?.each ->
      $(this).addClass 'animated ' + $(this).attr('data-target-animation')

    animateWithDelayItems?.each ->
      item = $(this)
      delay = item.attr('data-delay') || 1000;
      animate = ->
        item.addClass 'animated ' + item.attr('data-target-animation')
      setTimeout animate, delay
  setTimeout animateOnLoad,200

  animateOnScrollItems?.each ->
    top = $(this).offset().top
    $(this).data 'offset-top', top

  handleScroll()

  $(document).on('click', 'a[href^="#"]', (event) ->
    event.preventDefault();

    $('html, body').animate({
        scrollTop: $($.attr(this, 'href')).offset().top
    }, 500);
  );

  autosize($('textarea'));
  messageDiv = $('#ajaxmessage')
  ajaxSubmit = (theForm)->
    url = theForm.attr('action')
    data = theForm.serialize()

    button = theForm
      .find("button");
    button.html("<span class='fa fa-refresh fa-spin'></span> Sending...")
      .attr("disabled",true);

    $.ajax({
      type: "POST",
      url: url,
      data: data,
      success: (data) ->
        button.html("Get started").attr("disabled", false);
        messageDiv.html('<p>Thank you for contacting us, we will be in touch shortly</p>')
        return
      error: (e)->
        button.html("Get started").attr("disabled", false);
        messageDiv.html('<p>Thank you for contacting us, we will be in touch shortly</p>')
        return
    });

    $.post url, data, (data) ->
      button.html("Get started").attr("disabled", false);
      messageDiv.html('<p>Thank you for contacting us, we will be in touch shortly</p>')
      return

  $('form.contact').submit (e)->
    e.preventDefault();
    $form = $(this)
    # $form.hide();

    ajaxSubmit($form);


handleScroll = ->
  st = $(window).scrollTop() || $(document.body).scrollTop()
  animateOnScrollItems.each ->
    myTop = $(this).data('offset-top')
    if st >= myTop - 600
      $(this).css('opacity', 1).addClass 'animated ' + $(this).attr('data-target-animation')
      $(this).removeClass 'do-animate-on-scroll'
      animateOnScrollItems = $('.do-animate-on-scroll')

$(window).load ->
  if isMobileBrowser()
    $('.do-animate-on-scroll').each (e,el)->
      $(el).css('opacity', 1)

unless isMobileBrowser()
  $(window).scroll handleScroll
