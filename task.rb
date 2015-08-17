require 'sinatra'
require 'rubygems'
require 'make_todo'
require 'httparty'
require 'date'

def searchTask(type)
	array= Array.new
	Tarea.all.each do |task|
		task.each do |key, val|
			if key=="done" && val==type
				array.push(task)
			end
		end
	end
	array
end
get '/' do
	@tasks_lst = nil
	if params[:type]=="completed"
		@tasks_lst=searchTask(true)
	elsif params[:type]=="uncompleted"
		@tasks_lst=searchTask(false)
	else
		@tasks_lst=Tarea.all
	end
	erb :list_all
end

get '/create' do
	erb :new_task
end

post '/create' do
	@created = "Tarea '#{params[:name]}' creada exitosamente!"
	Tarea.create(params[:name])
	erb :new_task
end

post '/update' do 
	Tarea.update(params[:id])
	redirect '/'
end

get '/delete' do 
	Tarea.destroy(params[:id])
	redirect '/'
end