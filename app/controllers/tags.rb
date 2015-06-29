get '/users/:id/tags/:tag_id/show' do
	@tag = Tag.find(params[:tag_id])
	@user = User.find(params[:id])
	erb :"tag/tag_show"
end