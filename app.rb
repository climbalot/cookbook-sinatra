require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @cookbook = Cookbook.new('recipes.csv')
  erb :index
end

get '/new' do
  erb :new
end

post '/' do
  @cookbook = Cookbook.new('recipes.csv')
  name = params['recipename']
  description = params['recipedesc']
  prep_time = params['preptime']
  difficulty = params['difficult']
  done = params['done']
  @cookbook.recipes << Recipe.new(name, description, prep_time, difficulty, done)
  @cookbook.save_csv
  redirect to '/'
end

get '/destroy/:index' do
  @cookbook = Cookbook.new('recipes.csv')
  @cookbook.remove_recipe(params[:index].to_i)
  redirect to '/'
end