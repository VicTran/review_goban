class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  attr_accessor :remember_token

  ratyrate_rater

  before_save {self.email = email.downcase}

  mount_uploader :picture, PictureUploader

  validates :name, presence: true, length: {maximum: 50}
  validate :picture_size
  # validates :country, presence: true, length: {maximum: 50}
  # validates :state, presence: true, length: {maximum: 50}
  # validates :phone, length: {minimum: 10, maximum: 11}

  has_many :product, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  def password_required?
    new_record? ? super : false
  end

  def bookmark? product
    bk = self.bookmarks.find_by product_id: product.id
    return !bk.nil?
  end

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.avatar  = auth.info.image
        user.name = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  end

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, t(:picture_size)
    end
  end
end
