class Product < ActiveRecord::Base
  ratyrate_rateable "price"
  belongs_to :category
  belongs_to :user
  has_many :product_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  mount_uploader :image, PictureUploader

  validates :name, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 200}
  validates :detail, presence: true
  validates :price, presence: true
  validates :image, presence: true
  before_save :upcase_name

  scope :concern_products, -> product{where.not id: product.id}
  scope :display, ->{where is_display: true}
  scope :not_display, ->{where is_display: false}
  scope :sorted_by_price_rating, ->{joins(:price_average).order('rating_caches.avg DESC')}
  scope :get_by_minimun_star, ->star{joins(:price_average).where('rating_caches.avg >= ?', star)}
  scope :get_by_maximun_star, ->star{joins(:price_average).where('rating_caches.avg <= ?', star)}
  private

  def upcase_name
    self.name = self.name.mb_chars.upcase.to_s
  end
end
