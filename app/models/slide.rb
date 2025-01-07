class Slide < ApplicationRecord
  belongs_to :section
  belongs_to :template, optional: true
  has_one_attached :desktop_image
  has_one_attached :mobile_image
end
