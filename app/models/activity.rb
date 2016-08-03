class Activity < ActiveRecord::Base
  enum action_type: [:user_create, :user_update, :follow, :unfollow,
    :lesson_create, :do, :login, :logout]

  belongs_to :user
  belongs_to :lesson

  validates :user_id, presence: true
end
