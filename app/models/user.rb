class User < ActiveRecord::Base
  has_many :contacts
  has_one_attached :image

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  def avatar_url
    Rails.application.routes.url_helpers.url_for(:image) if image.attached?
  end
end
