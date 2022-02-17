class Review < ApplicationRecord
  belongs_to :movie

  validates :name, presence: true

  validates :comment, length: { minimum: 4 }

  validates :stars, numericality: {
    only_interger: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    message: "must be between 1 and 5"
  }
end
