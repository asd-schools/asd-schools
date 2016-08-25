class Review < ApplicationRecord
  belongs_to :school

  TYPES = [
    'My kid went here',
    'I spoke to them',
    "I've heard about them",
    'Reported in the media'
  ];
  validates :school_id, presence: true
  validates :review_type, inclusion: TYPES
  validates :score, inclusion: 0..10

  scope :published, lambda { where(published: true) }
  scope :recent, lambda { order(:created_at) }
end
