class Course < ApplicationRecord
  has_one_attached :desktop_video
  has_one_attached :mobile_video
end
