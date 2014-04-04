enable :sessions

#homepage, includes registration and longing fields
get '/' do
  # Look in app/views/index.erb
  session[:user] = nil
  erb :index
end

#post for registration
  #if failed validation for unique handle name, error displayed on same page, no redirect
post '/users' do
  # Look in app/views/index.erb
  #specify if form takes a string or symbol for session key
  user = User.new(params)
  if user.save # will return false if validations failed
    session[:user] = user
    redirect to("/users/#{user.handle}")
  else
    @error_message = "Invalid registration information"
    erb :index
  end
  #redirect to(/users) #stay on same page and deliver error
end

#if successful validation return to user profile page
post '/login' do
  # Look in app/views/index.erb
  #specify if form takes a string or symbol for session key
  if user = User.where(handle: params[:handle]).first
    if user.password == params[:password]
      session[:user] = user
      redirect to("/users/#{user.handle}")
    else
      @error_message = "Passwords do not match"
      redirect to('/')
    end
  @error_message = "Not a valid handle"
  redirect to('/')
  end
end


#get user profile page
  #link to display of all tweets
  #logout button: redirect top sign-in index page
get '/users/:handle' do
  @user = User.where(handle: params[:handle]).first
  if session[:user] == @user
    erb :user
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
    erb :user # WARNINGWARNINGWARNING CHECK WITH RAVI
  end
end

get '/logout' do
  session[:user] = nil
  redirect('/')
end






