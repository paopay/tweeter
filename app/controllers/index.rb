enable :sessions

#homepage, includes registration and longing fields
get '/' do
  # Look in app/views/index.erb
  erb :index
end

#post for registration
  #if failed validation for unique handle name, error displayed on same page, no redirect
post '/users' do
  # Look in app/views/index.erb
  #specify if form takes a string or symbol for session key
  session[:handle] = params[:handle]
  session[:email] = params[:email]
  session[:password] = params[:password]
  #redirect to(/users) #stay on same page and deliver error
end

#if successful validation return to user profile page
post '/login' do
  # Look in app/views/index.erb
  #specify if form takes a string or symbol for session key
  if @user = User.where(:handle, params[:handle]).first
    if @user.password == params[:password]
      session[:user] = @user
      redirect to('/users /#{@user.id}')
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
