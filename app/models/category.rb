class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  validates :name, presence: true, length: {maximum: 25}
  validates :content, presence: true, length: {maximum: 50}
  validates :image, presence: true
  mount_uploader :image, PictureUploader
end
