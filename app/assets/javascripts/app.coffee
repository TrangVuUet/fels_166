$(document).on 'ready page:load', ->
  answer = 0;
  $('#login_button').on 'click', (event) ->
    $('#login_one').slideToggle(1000);
    event.stopPropagation();

  $('#add_answer').on 'click', (event) ->
    answer += 1;
    strVar="";
    strVar += "<div class=\"row\">";
    strVar += "<div class=\"form-group\">";
    strVar += "<div class=\"col-md-9\">";
    strVar += "<input type=\"text\" id=\"word_word_answers_attributes_"+answer+"_content\" name=\"word[word_answers_attributes]["+answer+"][content]\" class=\"form-control\">";
    strVar += "<\/div>";
    strVar += "<div class=\"col-md-3\">";
    strVar += "<input type=\"hidden\" value=\""+answer+"\" name=\"word[word_answers_attributes]["+answer+"][is_correct]\"><input type=\"checkbox\" id=\"word_word_answers_attributes_"+answer+"_is_correct\" name=\"word[word_answers_attributes]["+answer+"][is_correct]\" value=\"1\">";
    strVar += "<\/div>";
    strVar += "<\/div>";
    strVar += "<\/div>";
    $('.show_answer_form').append(strVar);
  $('#word_category').on 'change', (event) ->
    url = $('#word_category').attr('data-url');
    data = $('#word_category').val();
    url = url + '?search=' +data
    window.location = url
  $('.show-word-answer-show').on 'click', (event) ->
    url = $(this).attr('href')
    $.get
      url: url
      dataType: 'json'
      success: (data) ->
        $('.show_word_answer_' + data.word_id).html(data.answers)
        return false
    return false
  $('.category_add_word').on 'click', (event) ->
    $('.category_notifi').addClass('hidden')
    url = $(this).attr('data-url')
    method = 'PUT'
    el = $(this)
    if($(this).hasClass('glyphicon-minus'))
      method = 'DELETE'
    $.ajax
      url: url
      dataType: 'json'
      method: method
      data: {category_id: $(this).attr('data-category-id')}
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
