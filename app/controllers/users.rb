require 'byebug'

get '/users' do
	if session[:id] != nil
		@user = User.find(session[:id])
		erb :"user/user_show"
	else
		erb :"user/user_index"
	end
end

get '/users/new' do
	@user = User.new
	erb :"user/user_index"
end

post '/users/create' do
	@user = User.new(params[:user])
	# byebug
	if @user.save
		@error = "Welcome!"
		session[:id] = @user.id
		redirect to "/users/#{@user.id}"
	else
		@error = "Invalid Email. Please create your account again!"
		erb :"user/user_index"
	end
end

get '/users/:id' do
	@user = User.find(params[:id])
	@statuses = Status.all
	erb :"user/user_show"
end

get '/users/:id/edit' do
	@user = User.find(params[:id])
	erb :"user/user_edit"
end

patch '/users/:id/edit' do
	@user = User.find(params[:id])
	@user.update(params[:user])
	if @user.save
		@error = "Update successful!"
		erb :"user/user_show"
	else
		@error = "Invalid email or password"
		erb :"user/user_show"
	end
end

post '/users/login' do
	@user = User.find_by_email(params["email"])

	@password = params["password"]

	if @user.nil?
		@error = "Invalid email and password combination"
		erb :"user/user_index"
	elsif @user.check_password(@password) == true
		session[:id] = @user.id
		redirect to "/users/#{@user.id}"
	else
		erb :"user/user_edit"
	end
end

post '/users/logout' do
	session.clear
	@error = "Logout successful"
	erb :"user/user_index"
end

delete '/users/:id' do
  @user = User.find(params[:id])
  @user.destroy
  session.clear
  redirect to '/users'
end