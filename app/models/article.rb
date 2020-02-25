class Article < ApplicationRecord
  ALLOWED_STATUSES = %w[draft published].freeze
  ALLOWED_TYPES = %w[belga presse media].freeze

  belongs_to :user
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :favorite_articles, dependent: :destroy
  has_many :favorited_by, through: :favorite_articles, source: :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :newsletter_articles, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :source_name, presence: true
  validates :status, presence: true, inclusion: { in: ALLOWED_STATUSES,
                                                  message: "%{value} n'est pas un statut valide" }
  validates :article_type, presence: true, inclusion: { in: ALLOWED_TYPES,
                                                  message: "%{value} n'est pas un type d'article valide" }

  scope :published_between, -> (sd, ed) do
    where('publication_date BETWEEN :sd AND :ed',
      sd: sd.present? ? sd : Date.parse('0000-01-01'),
      ed: ed.present? ? sd : Date.parse('3000-01-01'))
  end

  scope :published, -> { where(status: :published) }

  scope :by_keywords, -> (keywords) do
    where('articles.title @@ :keywords OR articles.body @@ :keywords', keywords: "%#{keywords}%")
  end
end
