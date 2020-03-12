class User < ApplicationRecord
  has_secure_password
  attr_accessor :remember_token, :activation_token
   before_create :create_activation_digest

  validates :user_name, presence: true, uniqueness: true,
              format: { with: /\A[A-Za-z][A-Za-z0-9]*\z/, allowblank: true }

  validates :family_furigana, :first_furigana, presence: true,
              format: { with: /\A[ァ-ヶー－]+\z/, allowblank: false },
              length: { minimum: 1, maximum: 50, allowblank: false }

  validates :family_name, :first_name, presence: true,
              format: { with: /\A[ぁ-んァ-ン一-龥]/, allowblank: false },
              length: { minimum: 1, maximum: 50, allowblank: false }

  # 与えられた文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :                                                             BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続的セッションで使用するユーザーをデータベースに記憶する
 def remember
   self.remember_token = User.new_token
   update_attribute(:remember_digest, User.digest(remember_token))
 end

 def authenticated?(attribute, token)
   BCrypt::Password.new(digest).is_password?(remember_token)
 end

 # ユーザーログインを破棄する
 def forget
   update_attribute(:remember_digest, nil)
 end

private
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
