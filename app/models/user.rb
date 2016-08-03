class User < ActiveRecord::Base
  include CreateActivity

  attr_accessor :remember_token
  before_save :downcase_email
  scope :search, ->(keyword) {where("name LIKE ?", "%#{keyword}%")}
  default_scope -> {order(name: :asc)}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USER_REGEX = /\A[A-Za-z0-9._-][A-Za-z0-9._-]{2,19}\z/

  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :email, presence: true, length: {maximum: 255},
    uniqueness: {case_sensitive:false}, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  validates :name, presence: true
  validate :picture_size
  has_secure_password
  mount_uploader :avatar, AvatarUploader
  accepts_nested_attributes_for :lessons

  after_create :activity_create

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
     BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def current_user? user
    self == user
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def activity_user_update user_id, target_id, action_type
    Activity.create! user_id: user_id, action_type: action_type,
      target_id: target_id
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def picture_size
    if avatar.size > 2.megabytes
      errors.add :picture, t("upload_avatar_notice")
    end
  end

  def activity_create
    create_activity self.id, self.id, Settings.activity_user_create
  end
end
