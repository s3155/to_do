class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[github]
  has_many :authorizations, dependent: :destroy

  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    authorization = Authorization.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    authorization.assign_attributes(name: auth.info.name, email: auth.info.email)

    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.user_name = auth.info.name
      user.remote_profile_url = auth.info.image if auth.info.image.present?
      user.save!
      user.authorizations << authorization unless user.authorizations.exists?(provider: auth.provider, uid: auth.uid)
    end
end

  has_many :authorizations, dependent: :destroy

  def self.create_unique_string
    SecureRandom.uuid
  end
end
