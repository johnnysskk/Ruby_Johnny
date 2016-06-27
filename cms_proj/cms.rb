# cms.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "redcarpet"


configure do 
 enable :sessions
 set :session_secret, 'super secret'
end


def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end

#data_path = File.expand_path("..",__FILE__)

helpers do 
  def render_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(text)
  end

  def load_content(path)
     content = File.read(path)

     if File.extname(path) == ".txt"
       headers["Content-Type"] = "text/plain"
       content
     elsif File.extname(path) == ".md"
       render_markdown(content)
     end
  end

end



get "/" do
  pattern = File.join(data_path,"*")
  @files = Dir.glob(pattern).map do |file_path|
       File.basename(file_path)
  end
  erb :index
end

get "/:filename" do
  file_path = File.join(data_path,params[:filename])

  if File.exist?(file_path)
    headers["Content-Type"] = "text/plain"
    File.read(file_path)
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

get "/:filename/edit" do 
    file_path = File.join(data_path,params[:filename])
    @file_name = params[:filename]
    @content = File.read(file_path)

    erb :edit
end

post "/:filename" do
  file_path = File.join(data_path,params[:filename])

  @content = params[:content]
  File.write(file_path,@content)

  session[:message] = "The file #{params[:filename]} has been updated!"
  redirect "/"
end





