module CreateActivity
  def create_activity user_id, target_id, action_type
    Activity.create! user_id: user_id, action_type: action_type,
      target_id: target_id
  end
end
