class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line] # この1行を追加

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

  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
    # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end





  def self.create_unique_string
    SecureRandom.uuid
  end
end
