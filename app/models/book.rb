class Book < ApplicationRecord
	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	
	 def favorited_by?(user)
            favorites.where(user_id: user.id).exists?
        end
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	# book検索
	  def self.search(keyword, search_name)
      if search_name == "完全一致"
        where(['title LIKE ?', "#{keyword}"])
      elsif search_name == "部分一致"
         where(['title LIKE ?', "%#{keyword}%"])
      elsif search_name == "前方一致"
        where(['title LIKE ?', "#{keyword}%"])
      elsif search_name == "後方一致"
        where(['title LIKE ?', "%#{keyword}"])
      else
      end
  end
end

