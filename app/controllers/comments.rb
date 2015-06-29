post '/users/:id/statuses/:status_id/comments/create' do
	@comment = Comment.new(comment: params["comment"], user_id: params[:id], status_id: params[:status_id])
	# @user = User.find(params[:id])
	@status = Status.find(params[:status_id])
	if @comment.save
		@error = ""
		redirect to "/users/#{@status.user_id}/statuses/#{@status.id}"
	else
		@error = "Error! Please try again!"
		erb :"status/status_show"
	end

end

get '/users/:id/statuses/:status_id/comments/:comment_id' do
	@user = User.find(params[:id])
	@status = Status.find(params[:status_id])
	erb :"comment/comment_show"
end

delete '/users/:id/statuses/:status_id/comments/:comment_id' do
	# @user = User.find(params[:id])
  @comment = Comment.find(params[:comment_id])
  @comment.destroy
  redirect to "/users/#{@comment.user_id}/statuses/#{@comment.status_id}"
end

get '/users/:id/statuses/:status_id/comments/:comment_id/edit' do
	# @user = User.find(params[:id])
	@comment = Comment.find(params[:comment_id])
	erb :"comment/comment_edit"
end

patch '/users/:id/statuses/:status_id/comments/:comment_id/edit' do
	@user = User.find(params[:id])
	@comment = Comment.find(params[:comment_id])
	@comment.comment = "#{params["comment"]}"
	
	if @comment.save
		@error = "Status Updated successful!"
		redirect to "/users/#{@user.id}/statuses/#{@comment.status_id}"
	else
		@error = "Error occurred! Please try again!"
		erb :"status/status_show"
	end
end