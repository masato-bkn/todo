class Task < ApplicationRecord
  validates :task, presence: true, length: {minimum: 1, maximum: 100}
end
