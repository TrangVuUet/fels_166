$(document).on 'ready page:load', ->
  answer = 0;
  $('#login_button').on 'click', (event) ->
    $('#login_one').slideToggle(1000);
    event.stopPropagation();

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

  $('.row-word-answer').on 'click', '.admin_choose_answer', (event) ->
    el = $(this)
    $('.row-word-answer').find('.row').each ->
      $($(this).find('input')[1]).prop("checked", false)
      correct_answer_input = $(this).find('input')[4]
      $(correct_answer_input).val(0)
    $(this).prop("checked", true)
    id = $(el).attr('id').replace('_true', '');
    $('#'+id).val(1)

  $('.admin_add_word_answer').on 'click', (event) ->
    el = $(this)
    answer_count = parseInt $('#word_answer_count').val()
    row_count = $('.row-word-answer').children('.row').length - $('.row-word-answer').children('.row.hidden').length
    if row_count < 5
      answer_count = answer_count + 1
      strVar = "";
      strVar += "<div id=\"row-1\" class=\"row\">";
      strVar += "<div class=\"form-group\">";
      strVar += "<div class=\"col-md-8\">";
      strVar += "<input type=\"text\" id=\"word_word_answers_attributes_"+answer_count+"_content\""
      strVar += "name=\"word[word_answers_attributes]["+answer_count+"][content]\""
      strVar += "class=\"form-control\">";
      strVar += "<\/div>";
      strVar += "<div class=\"col-md-1\">";
      strVar += "<input type=\"radio\" id=\"word_word_answers_attributes_"+answer_count+"_is_correct_true\" name=\"word[word_answers_attributes]["+answer_count+"][is_correct]\" value=\"true\" class=\"admin_choose_answer\">";
      strVar += "<\/div>";
      strVar += "<div class=\"col-md-2\">";
      strVar += "<input type=\"hidden\" value=\"0\" name=\"word[word_answers_attributes]["+answer_count+"][_destroy]\"><input type=\"checkbox\" id=\"word_word_answers_attributes_1__destroy\" name=\"word[word_answers_attributes]["+answer_count+"][_destroy]\" value=\"1\" class=\"hidden\">";
      strVar += "<input type=\"hidden\" id=\"word_word_answers_attributes_1_is_correct\" name=\"word[word_answers_attributes]["+answer_count+"][is_correct]\">";
      strVar += "<button class=\"btn glyphicon glyphicon-trash ";
      strVar += "admin_delete_word_answer\" type=\"button\" name=\"button\"><\/button>";
      strVar += "<\/div>";
      strVar += "<\/div>";
      strVar += "<\/div>";
      $('.row-word-answer').append(strVar)
      $('#word_answer_count').val(answer_count)
    else
      alert("Answer 2 to 5")

  $('.row-word-answer').on 'click', '.admin_delete_word_answer', (event) ->
    row_count = $('.row-word-answer').children('.row').length - $('.row-word-answer').children('.row.hidden').length
    if row_count > 2
      el = $(this)
      answer_count = parseInt $('#word_answer_count').val()
      row_parents = $($(el).parents('.row'))[0]
      if $($(row_parents).find('input')[1]).is(':checked')
        alert("You don't remove this element")
      else
        answer_count = answer_count - 1
        if $(row_parents).find('input').attr('value') == ""
          $(row_parents).remove()
          $('#word_answer_count').val(answer_count)
        else
          $($(row_parents).find('input')[3]).prop("checked", true)
          $(row_parents).addClass('hidden')
