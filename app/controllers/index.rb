get '/' do
  if session[:user_id]
    redirect '/main'
  else
    erb :welcome
  end
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(username: params[:username])
  redirect '/login' unless user
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/main'
  else
    erb :login
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/register' do
  erb :register
end

post '/register' do
  user = User.new(name: params[:name], email: params[:email], username: params[:username], password: params[:password])
  if user.save
    session[:user_id] = user.id
    redirect '/main'
  else
    erb :register
  end
end

get '/main' do
  @users = User.all
  @current_user = User.find(session[:user_id])
  @tweets_to_include = @current_user.tweets + Tweet.where(user: @current_user.idols)
  erb :main
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :profile
end

get '/follow/:id' do
  user = User.find(params[:id])
  current_user = User.find(session[:user_id])
  relationship = Relationship.create(idol_id: user.id, fan_id: current_user.id)
  redirect '/main'
end

get '/unfollow/:id' do
  user = User.find(params[:id])
  current_user = User.find(session[:user_id])
  relationship = Relationship.where(idol_id: user.id, fan_id: current_user.id).first
  relationship.delete
  redirect '/main'
end

post '/tweets' do
  current_user = User.find(session[:user_id])
  current_user.tweets.create(content: params[:content])
  redirect '/main'
end
