class Pin < ActiveRecord::Base
  validates_presence_of :title, :url, :slug, :text, :category_id
  validates_uniqueness_of :slug
  belongs_to :category
  belongs_to :user
  has_many :pinnings
  has_many :users, through: :pinnings
  has_attached_file :image, styles: { medium: "300x300>", thumb: "90x90>" }, default_url: "http://placebear.com/90/90"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  accepts_nested_attributes_for :pinnings
end
