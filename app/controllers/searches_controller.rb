class SearchesController < ApplicationController
	def index
	end

	def new
	end

	def search 
		if params[:model_name] == "ユーザー"
			keyword = params[:keyword]
			search_name = params[:search_name]
			@searched_users = User.search(keyword,search_name)
			render 'new'
		elsif params[:model_name] == "ブック"
			keyword = params[:keyword]
			search_name = params[:search_name]
			@searched_books = Book.search(keyword,search_name)
			render 'index'
		else
		end
	end
end

