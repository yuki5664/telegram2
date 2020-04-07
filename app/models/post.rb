class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
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
      unless image.attached?
        errors.add(:image, 'ファイルを添付してください')
      end
    end  
  end

  scope :find_newest_post, -> (page) { with_attached_image.order(created_at: :desc).page(page).per(5) }
  scope :with_user_and_comment, -> { includes(user: [avatar_attachment: :blob], comments: [user: [avatar_attachment: :blob]]) }
end
