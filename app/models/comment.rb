class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  mount_uploader :image, PictureUploader
  validate :check_content_image

  private
  def check_content_image
    if self.content.empty? && self.image.file.nil?
      errors.add :comment, "Please comment"
    end
  end
end
