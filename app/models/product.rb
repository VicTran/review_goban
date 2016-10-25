class Product < ActiveRecord::Base
  ratyrate_rateable "price"
  belongs_to :category
  belongs_to :user
  has_many :product_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :image, PictureUploader

  validates :name, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 200}
  validates :detail, presence: true
  validates :price, presence: true

  scope :concern_products, -> product{where.not id: product.id}
  scope :display, ->{where is_display: true}
end
