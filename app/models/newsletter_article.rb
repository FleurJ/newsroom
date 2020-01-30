class NewsletterArticle < ApplicationRecord
  belongs_to :newsletter
  belongs_to :article
end
