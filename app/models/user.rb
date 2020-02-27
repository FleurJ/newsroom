class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :articles
  has_many :comments, dependent: :destroy
  has_many :favorite_articles
  has_many :favorites, through: :favorite_articles, source: :article
end
