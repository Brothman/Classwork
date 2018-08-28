# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :session_token, :password_digest, presence: true
  validates :username, presence:true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :subs,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: 'Sub',
    dependent: :destroy

  has_many :posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: 'Post',
    dependent: :destroy

  has_many :comments,
    foreign_key: :author_id,
    class_name: 'Comment',
    dependent: :destroy

  attr_reader :password

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    if user && BCrypt::Password.new(user.password_digest).is_password?(password)
      user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end