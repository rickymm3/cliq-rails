class MarioLevel < ActiveRecord::Base
  belongs_to :l_category
  has_many :mario_ratings
  belongs_to :user
  has_many :mario_user_comments

  validates :name, :description, :l_category_id, :level_code, presence: true
  validates_uniqueness_of :level_code
  validates_length_of :level_code, minimum: 16, maximum: 19

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
