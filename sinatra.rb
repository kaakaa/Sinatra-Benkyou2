#coding: utf-8
require 'sinatra'
require 'active_record'
require 'haml'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('development')

class History < ActiveRecord::Base
end

get '/' do
  redirect '/Sinatra/'
end

get '/:name/' do
  @display_name = params[:name]
  @histories = History.all  
  haml :index  
end

post '/*/hello' do
  @name = params[:name]
  if @name.nil? then
    @name = "Sinatra"
  end

  day = Time.now
  date_time = day.strftime("%Y/%m/%d %H:%M:%S")

  history = History.new
  history.name = @name
  history.date_time = date_time
  history.save

  redirect '/' + @name + '/'
end

delete '/*/delete' do
  History.delete_all
  redirect '/'
end
