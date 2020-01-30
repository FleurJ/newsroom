class Newsletter < ApplicationRecord
  belongs_to :user
  has_many :newsletter_article
  has_many :articles, through: :newsletter_article
end
