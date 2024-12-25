class Voiceover < ApplicationRecord
  has_one_attached :file
  validates :text, presence: true
end
