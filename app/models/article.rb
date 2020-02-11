class Article < ApplicationRecord
  ALLOWED_STATUSES = %w[draft published].freeze

  belongs_to :user
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :source_name, presence: true
  validates :status, presence: true, inclusion: { in: ALLOWED_STATUSES,
                                                  message: "%{value} n'est pas un statut valide" }
end
