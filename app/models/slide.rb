class Slide < ApplicationRecord
  belongs_to :course
  has_one_attached :desktop_image
  has_one_attached :mobile_image
  validates :text_for_display, presence: true
end
