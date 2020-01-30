class Page < ApplicationRecord
  ALLOWED_STATUSES = %w[draft published].freeze

  belongs_to :user

  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: ALLOWED_STATUSES,
                                                  message: "%{value} n'est pas un statut valide" }
end
