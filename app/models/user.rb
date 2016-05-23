class User < ActiveRecord::Base
  before_save{self.email = email.downcase}
  has_many :entries,dependent: :destroy
  has_many :active_relationships,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  has_many :passive_relationships,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy
  has_many :following,through: :active_relationships,source: :followed
  has_many :folowers,through: :passive_relationships,source: :follower
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,presence: true, length: {maximum:50}
  validates :email,presence: true,
  length:{maximum:50},format:{with: VALID_EMAIL_REGEX},uniqueness:{case_sensitive:false}
  validates :password,presence:true,length:{minimum:6}
  has_secure_password

  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id=:user_id"
    Entry.where("user_id IN (#{following_ids}) OR user_id = :user_id",user_id: id)
  end

  def follow(other_user)
    active_relationships.create(followed_id:other_user.id)
  end

  def unfollow(other_user)
    following_include?(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
