class GuestOrder < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, allow_destroy: true
  validates :name_from, presence: true, length: {maximum: 50}
  validates :name_to, presence: true, length: {maximum: 50}
  validates :email_from, presence: true, length: {maximum: 50}
  validates :email_to, presence: true, length: {maximum: 50}
  validates :phone_from, presence: true, length: {minimum: 10, maximum: 11}
  validates :phone_to, presence: true, length: {minimum: 10, maximum: 11}
  validates :address_from, presence: true, length: {maximum: 500}
  validates :address_to, presence: true, length: {maximum: 500}
end
