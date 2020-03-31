class Post < ApplicationRecord
  has_one_attached :image
  validates :caption, presence: true
  validate :image_check

  def image_check
    ##### 中身を確認 #####
    if image.present?
      ##### ファイルの種類をチェック #####
      unless image.content_type.in?(%w(image/jpeg image/png))
        errors.add(:image, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end
end
