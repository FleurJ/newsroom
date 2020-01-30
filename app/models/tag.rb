class Tag < ApplicationRecord
  ALLOWED_STATUSES = %w[draft published].freeze

  has_many :article_tags

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: ALLOWED_STATUSES,
                                                  message: "%{value} n'est pas un statut valide" }
end
