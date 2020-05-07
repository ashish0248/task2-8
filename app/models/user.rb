class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

 	has_many :books, dependent: :destroy
 	has_many :post_comments, dependent: :destroy
 	has_many :favorites, dependent: :destroy
  attachment :profile_image

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  	validates :introduction,    length: { maximum: 50} 

 #以下　フォロー機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
  unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

# ユーザー検索
  def self.search(keyword, search_name)
      if search_name == "完全一致"
        where(['name LIKE ?', "#{keyword}"])
      elsif search_name == "部分一致"
         where(['name LIKE ?', "%#{keyword}%"])
      elsif search_name == "前方一致"
        where(['name LIKE ?', "#{keyword}%"])
      elsif search_name == "後方一致"
        where(['name LIKE ?', "%#{keyword}"])
      else
      end
  end

# 住所検索
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

end

