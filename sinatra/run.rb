require 'sinatra'

enable :sessions

db_array = {}

get '/' do
	erb :index
end

post '/login' do
	# simulate database results
	db_array[params[:user][:name]] = {
		:username => 'test',
		:password => 'test'
	}

	db_row = db_array[params[:user][:name]]

	# validate form
    if db_row[:username] == params[:user][:name] && db_row[:password] == params[:user][:password]
		# form is valid, assign a session
  		session[:username] = params[:user][:name]
  		redirect '/todos'
    else
    	# form is invalid, redirect to login page
		redirect '/'
    end
end

get '/logout' do
	session[:username] = nil
	redirect "/"
end

get '/todos' do
	 if session[:username].nil?
	 	redirect '/'
	 else
	 	erb :todos
	 end
end