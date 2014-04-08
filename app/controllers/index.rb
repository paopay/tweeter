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
  # there is some debate as to whether you should use .where.
  # as an alternative, you can use User.find_by(handle: params[:handle] )
  if @user = User.where(handle: params[:handle]).first
    if user.password == params[:password]
      session[:user] = user
      redirect("/users/#{@user.handle}/feed")
    else
      # try to avoid rendering a page in a post route -- that's what get routes are for
      # errors can be passed in the session, or the flash hash.
      @error_message = "Passwords do not match"
      erb :index
    end
  @error_message = "Not a valid handle"
  erb :index
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
  # nice use of the .save function!
  if user.save # will return false if validations failed
    # don't store the entire user in the session! that's way too big for the 4k
    # space the browser allots. just store the user.id
    session[:user] = user
    redirect("/users/#{user.handle}/feed")
  else
    @error_message = "Invalid registration information"
    # nice use of redirect
    redirect back
  end
  #redirect to(/users) #stay on same page and deliver error
end


#get user profile page
  #link to display of all tweets
  #logout button: redirect top sign-in index page
get '/users/:handle' do
  # when you only care abou the first value, use .find_by
  @user = User.where(handle: params[:handle]).first
  @tweets = Tweet.all
  if session[:user] == @user
    erb :profile
  else
  redirect('/')
  end
end

#get user tweet feed
get '/users/:handle/feed' do
  @user = User.where(handle: params[:handle]).first
  @tweets = Tweet.first
  if session[:user] == @user
    erb :feed
  else
    @error_message = "Only #{params[:handle]} can see that page!"
    erb :index
  end
end

# this is just in case a user tries to get to the tweet feed manually
get '/users/:handle/tweets' do
  # nice UI error handling.
  redirect('/users/' + params[:handle])
end

get '/users/:handle/tweets/new' do
  @user = User.where(handle: params[:handle]).first
  if session[:user] == @user
    erb :create_tweet
  end
end

# comments should happen on github, not in your code!
# ADDED THIS METHOD - CHECK WITH RAVI FOR USER PROFILE PAGE ERROR MESSAGE
post '/users/:handle/tweets' do
  @user = User.where(handle: params[:handle]).first
  @tweet = @user.tweets.new(content: params[:content])
  if @tweet.save
    redirect("/users/#{@user.handle}")
  else
    # try to avoid rendering pages in a post route. just redirect to a get route!
    @error_message = "Tweet must be between 1 and 140 characters, sorry."
    erb :feed
  end
end

get '/users/:handle/followers' do
  user = User.where(handle: params[:handle]).first
  # good use of the active record query interface
  @followers = user.followers
  erb :followers
end

get '/users/:handle/following' do
  user = User.where(handle: params[:handle]).first
  @following = user.following
  erb :following
end

post '/users/:handle/following/:handle_2' do
  user = User.where(handle: params[:handle]).first
  followed_user = User.where(handle: params[:handle_2]).first
  user.following << followed_user
  redirect("/users/#{params[:handle_2]}")
end

post '/users/:handle/tweets/:tweet_id/delete' do
  # in general, you should use .destroy, as it will first verify that the object exists.
  Tweet.find(:tweet_id).delete
  redirect("/users/#{params[:handle]}")
end

get '/users/:handle/delete' do
  erb :delete
end

post '/users/:handle/delete' do
  User.where(handle: params[:handle]).first.delete
  redirect('/')
end

get '/logout' do
  session[:user] = nil
  redirect('/')
end



