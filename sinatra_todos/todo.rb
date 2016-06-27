require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "sinatra/content_for"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

helpers do 
  def list_complete? (list)
    list[:todos].size > 0 && list[:todos].all? {|todo| todo[:completed] }
  end

  def list_class(list)
    if list_complete?(@list) 
     "complete"
    end
  end

  def todos_count(list) 
    list[:todos].size
  end

  def todos_remaining_count(list)
    list[:todos].select {|todo| !todo[:completed]}.size
  end

  def todo_class(todo)
    if todo[:completed]
      "complete"
    end
  end

  def sort_list(lists, &block)
     incomplete_lists = {}
     complete_lists = {}

     lists.each_with_index do |list,index| 
       if list_complete?(list)
         complete_lists[index] = list
       else
        incomplete_lists[index] = list
       end

      incomplete_lists.each{ |id, list|  yield list,id}
      complete_lists.each {|id,list| yield list, id }
     end
  end

  def sort_todo(todos,&block) 
     incomplete_todos = {}
     complete_todos = {}

     todos.each_with_index do |todo,index| 
       if todo[:completed]
         complete_todos[index] = todo
       else
         incomplete_todos[index] = todo
       end

      incomplete_todos.each{ |id, todo|  yield todo,id}
      complete_todos.each {|id,todo| yield todo, id }
     end
  end 

end

before do
  session[:lists] ||= []

end

get "/" do
  redirect "/lists"
  erb layout: :layout
end

#view lists 
get "/lists" do
  @lists = session[:lists]

  erb :lists, layout: :layout
end

#go to a page for adding a list
get "/lists/new" do
  erb :new_list, layout: :layout
end


def error_from_list_name(list_name)
   if list_name.size < 1 || list_name.size > 100
     "The list name has to be within 1 to 100 characters."
   elsif session[:lists].any? {|list| list[:name] == list_name}
     "The list name has to be unique."
   end 
end

def error_from_todo_name(todo_name)
   if todo_name.size < 1 || todo_name.size > 100
     "The todo name has to be within 1 to 100 characters."
   elsif session[:lists][@list_id][:todos].any? {|todo| todo[:name] == todo_name}
     "The todo name has to be unique."
   end 
end


#route for sending a form to lists
post "/lists" do
  list_name = params[:list_name].strip
  error = error_from_list_name(list_name)
  if error
   session[:error] = error 
   erb :new_list, layout: :layout 
  else
   session[:lists] << {name: list_name, todos:[]}
   session[:success] = "You have successfully added a new list !"
   redirect "/lists"
  end
end

#each list has its showing page
get "/lists/:id" do
  @list_id = params[:id].to_i
  @list = session[:lists][@list_id]
  erb :list, layout: :layout
end

#eahc list has its editing page
get "/lists/:id/edit" do
  @id = params[:id].to_i
  @list = session[:lists][@id] 
  erb :edit_list, layout: :layout
end

#update existing todo list

post "/lists/:id" do 
  @id = params[:id].to_i
  list_name = params[:list_name].strip
  error = error_from_list_name(list_name)
  @list = session[:lists][@id]
  if error
   session[:error] = error 
   erb :edit_list, layout: :layout 
  else
   @list[:name] = list_name
   session[:success] = "The list name has been updated"
   redirect "/lists/#{@id}"
  end
end

#delete todo list 

post "/lists/:id/delete" do 
    id = params[:id].to_i
    session[:lists].delete_at(id)

  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
     "/lists" 
  else
    session[:success] = "The list has been deleted"
    redirect "/lists"
  end
    
end


#adding a todo to list
post "/lists/:list_id/todos" do
  @list_id= params[:list_id].to_i
  #list = session[:lists][list_id]
  todo_name = params[:todo].strip
  @list = session[:lists][@list_id]
  error = error_from_todo_name(todo_name)
  if error 
    session[:error] = error
    erb :list, layout: :layout
  else
   session[:lists][@list_id][:todos] << {name: params[:todo], completed: false }
   session[:success] = "The todo is added successfully"
   redirect "/lists/#{@list_id}"
  end
end


#deleteing a todo from a list 

post "/lists/:list_id/todos/:id/destroy" do
  @list_id= params[:list_id].to_i
  @list = session[:lists][@list_id]

  todo_id = params[:id].to_i
  @list[:todos].delete_at todo_id

  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
     status 204  #success 
  else
   session[:success] = "The todo has been deleted."
   redirect "/lists/#{@list_id}"
  end
end

#update the status of todo

post "/lists/:list_id/todos/:id" do
  @list_id= params[:list_id].to_i
  @list = session[:lists][@list_id]

  todo_id = params[:id].to_i
  is_completed = params[:completed] == "true"
  @list[:todos][todo_id][:completed] = is_completed
  session[:success] = "The todo has been updated"
  redirect "/lists/#{@list_id}"
end

#complete all the status of a todo

post "/lists/:id/complete_all" do
      @list_id= params[:id].to_i
      @list = session[:lists][@list_id]

      @list[:todos].each do |todo|
          todo[:completed] = true
      end

      session[:success] = "All todos have been completed"
      redirect "/lists/#{@list_id}"
end

