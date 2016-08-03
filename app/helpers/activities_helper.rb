module ActivitiesHelper

  def show_link activity
    action_type = activity.action_type
    case action_type
    when "user_create", "user_update", "follow", "unfollow"
      user = User.find  activity.target_id
    when "lesson_create", "lesson_do"
      lesson = Lesson.find activity.target_id
    end
  end

  def activity_name object
    case object.class.name
    when User.name
      name = object.name
    when Lesson.name
      name = Lesson.name + "-" + object.id.to_s
    end
  end

  def show_user_name user
    if user == current_user
      I18n.t("activity.you")
    else
      user.name
    end
  end
  def show_action_type action_type
    case action_type
    when "user_create"
      I18n.t "activity.user_create"
    when "user_update"
      I18n.t "activity.user_update"
    when "follow"
      I18n.t "activity.follow"
    when "unfollow"
      I18n.t "activity.unfollow"
    when "lesson_create"
      I18n.t "activity.lesson_create"
    when "do"
      I18n.t "activity.lesson_do"
    when "login"
      I18n.t "activity.user_login"
    when "logout"
      I18n.t "activity.user_logout"
    end
  end
end
