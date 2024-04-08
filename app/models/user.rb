class User < ApplicationRecord
  # 他のコード...

  devise :omniauthable, omniauth_providers: %i[google_oauth2]
  
  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.avatar = auth.info.image
      user.skip_confirmation!
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  def self.create_unique_string
    SecureRandom.uuid
  end
end
