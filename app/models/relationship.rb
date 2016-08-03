class Relationship < ActiveRecord::Base
  include CreateActivity

  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  after_save :activity_follow
  before_destroy :activity_unfollow

  private
  def activity_follow
    create_activity follower_id, followed_id, Settings.activity_follow
  end

  def activity_unfollow
    create_activity follower_id, followed_id, Settings.activity_unfollow
  end
end
