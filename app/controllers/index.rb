enable :sessions

#homepage, includes registration and longing fields
get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/login' do

  erb :login
end

#if successful validation return to user profile page
post '/login' do
  # Look in app/views/index.erb
  #specify if form takes a string or symbol for session key
  if user = User.where(handle: params[:handle]).first
    if user.password == params[:password]
      session[:user] = user
      redirect to("/users/#{user.handle}/feed")
    else
      @error_message = "Passwords do not match"
      redirect to('/')
    end
  @error_message = "Not a valid handle"
  redirect to('/')
  end
end

get '/register' do
  erb :register
end


#post for registration
  #if failed validation for unique handle name, error displayed on same page, no redirect
post '/register' do
  # Look in app/views/index.erb
  #specify if form takes a string or symbol for session key
  user = User.new(params)
  if user.save # will return false if validations failed
    session[:user] = user
    redirect to("/users/#{user.handle}/feed")
  else
    @error_message = "Invalid registration information"
    erb :index
  end
  #redirect to(/users) #stay on same page and deliver error
end


#get user profile page
  #link to display of all tweets
  #logout button: redirect top sign-in index page
get '/users/:handle' do
  @user = User.where(handle: params[:handle]).first
  if session[:user] == @user
    erb :profile
  else
    erb :index
  end
end

#get user tweet feed
get '/users/:handle/feed' do
  @user = User.where(handle: params[:handle]).first
  @tweets = Tweet.all
  if session[:user] == @user
    erb :feed
  else
    erb :index
  end
end

# ADDED THIS METHOD - CHECK WITH RAVI FOR USER PROFILE PAGE ERROR MESSAGE
post '/users/:handle/tweets' do
  user = User.where(handle: params[:handle]).first
  tweet = user.tweets.new(params)
  if tweet.save
    redirect("/users/#{user.handle}")
  else
    @error_message = "Tweet must be between 1 and 140 characters, sorry."
    #erb :profile  WARNINGWARNINGWARNING CHECK WITH RAVI IMPLEMENT THIS IN PROFILE VIEW BACK? WHERE???
  end
end

get '/users/:handle/followers' do

  erb :followers
end

get '/users/:handle/following' do

  erb :following
end

post '/users/:handle/following/:handle_2' do

  redirect("/users/#{params[:handle_2]}")
end

post '/users/:handle/tweets/:tweet_id/delete' do

  redirect("/users/#{params[:handle]}")
end

get '/users/:handle/delete' do

  erb :delete
end

post '/users/:handle/delete' do

  redirect('/')
end

get '/logout' do
  session[:user] = nil
  redirect('/')
end

# post '/users/:handle/tweets' do
#   @user = User.where(handle: params[:handle]).first


# end





