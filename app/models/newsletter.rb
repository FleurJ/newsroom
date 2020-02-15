class Newsletter < ApplicationRecord
  ALLOWED_STATUSES = %w[draft published].freeze

  belongs_to :user
  has_many :newsletter_article
  has_many :articles, through: :newsletter_article

  validates :newsletter_type, presence: true
  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: ALLOWED_STATUSES,
                                                  message: "%{value} n'est pas un statut valide" }

  validates_associated :articles
end
