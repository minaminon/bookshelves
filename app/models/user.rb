class User < ApplicationRecord
  validates :name,presence: true,length: {maximum: 50}
  validates :email,presence: true,length: {maximum: 255},
                   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                   uniqueness: { case_sensitive: false}
  has_secure_password
  has_many :reviews
  has_many :books, through: :reviews
  before_save{self.email.downcase!}
  
  def add(book,status,content)
    self.reviews.find_or_create_by(book_id: book.id,status: status,content: content)
  end
  
  def remove(id)
    data=self.reviews.find_by(book_id: id)
    data.destroy if data
  end
  
  def have?(gbook)
    self.reviews.include?(code: gbook.id)
  end
end
