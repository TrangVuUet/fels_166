class User < ActiveRecord::Base

  before_save :downcase_email

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
  validates :name, format: {with: VALID_USER_REGEX}
  validate :picture_size
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  private
  def downcase_email
    self.email = email.downcase
  end

  def picture_size
    if avatar.size > 2.megabytes
      errors.add :picture, t("upload_avatar_notice")
    end
  end
end
