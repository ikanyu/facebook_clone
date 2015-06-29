post '/users/:id/statuses/create' do
	@status = Status.new(status: params["status"], user_id: params[:id])
	@user = User.find(params[:id])
	@tag = params[:tags]
	@newtag = @tag.split(',')

	if @status.save
		if @newtag.empty?
		else
			@newtag.each do |tag|
				@status.tags << Tag.find_or_create_by(name:"#{tag}")
			end
		end
		redirect to "/users/#{@user.id}"
	else
		@error = "Error! Please try again!"
		redirect to "/users/#{@user.id}"
	end
end

get '/users/:id/statuses/:status_id' do
	@user = User.find(params[:id])
	@status = Status.find(params[:status_id])
	@checklike = Like.find_by(user_id: params[:id], status_id: params["status_id"])
	# @statuses = Status.all
	# byebug
	@like = Like.where(status_id: params[:status_id]).count
	# @comment = Comment.find_by(status_id: params)
	@comments = @status.comments
	erb :"status/status_show"
end

get '/users/:id/statuses/:status_id/edit' do
	@user = User.find(params[:id])
	@status = Status.find(params[:status_id])
	erb :"status/status_edit"
end

patch '/users/:id/statuses/:status_id/edit' do
	@user = User.find(params[:id])
	@status = Status.find(params[:status_id])
	@status.status = "#{params["status"]}"
	if @status.save
		@error = "Status Updated successful!"
		redirect to "/users/#{@user.id}"
	else
		@error = "Error occurred! Please try again!"
		erb :"user/user_show"
	end
end

delete '/users/:id/statuses/:status_id' do
	@user = User.find(params[:id])
  @status = Status.find(params[:status_id])
  @status.destroy
  redirect to "/users/#{@user.id}"
end

post '/users/:id/statuses/:status_id/like' do
	@like = Like.new(status_id: params["status_id"], user_id: params["id"])
	# @user = User.find(params[:id])
	if @like.save
		@error = ""
		redirect to "/users/#{@like.user_id}/statuses/#{@like.status_id}"
	else
		@error = "Error! Please try again!"
		redirect to "/users/#{@like.user_id}/statuses/#{@like.status_id}"
	end
end

delete '/users/:id/statuses/:status_id/unlike' do
	# @user = User.find(params[:id])
  @like = Like.find_by(status_id: params[:status_id])
  @like.destroy
  redirect to "/users/#{@like.user_id}/statuses/#{@like.status_id}"
end