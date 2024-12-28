class Voiceover < ApplicationRecord
  has_one_attached :file
  validates :text, presence: true
  belongs_to :slide, optional: true
end
