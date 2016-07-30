@show_word_answer = (el) ->
  url = $(el).attr('href')
  $.get
    url: url
    dataType: 'json'
    success: (data) ->
      $('.show_word_answer_' + data.word_id).html(data.answers)
      return false
  return false

@category_add_word = (el) ->
  $('.category_notifi').addClass('hidden')
  url = $(el).attr('data-url')
  method = 'PUT'
  if($(el).hasClass('glyphicon-minus'))
    method = 'DELETE'
  $.ajax
    url: url
    dataType: 'json'
    method: method
    data: {category_id: $(el).attr('data-category-id')}
    success: (data) ->
      if(data.result)
        if(method == 'PUT')
          $(el).removeClass('glyphicon-plus-sign');
          $(el).addClass('glyphicon-minus');
          $($(el).parents('tr').find('.depend')).removeClass('hidden')
          $($(el).parents('tr').find('.independ')).addClass('hidden')
        else
          $(el).removeClass('glyphicon-minus');
          $(el).addClass('glyphicon-plus-sign');
          $($(el).parents('tr').find('.independ')).removeClass('hidden')
          $($(el).parents('tr').find('.depend')).addClass('hidden')
      else
        $('.category_notifi').removeClass('hidden')
      return false
  return false
