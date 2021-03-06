require('sinatra/activerecord')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
# require('./lib/list')
require('pg')

get('/') do
  @tasks = Task.all()
  erb(:index)
end


get('/tasks') do
  @tasks = Task.all()
  erb(:tasks)
end

# get('/lists/new') do
#   erb(:list_form)
# end
#
# get('/lists') do
#   @lists = List.all()
#   erb(:lists)
# end
#
# post('/lists') do
#   name = params.fetch('name')
#   list = List.new({:name => name, :id => nil})
#   list.save()
#   erb(:list_success)
# end
#
# get('/lists/:id') do
#   @list = List.find(params.fetch("id").to_i())
#   erb(:list)
# end

post('/tasks') do
  description = params.fetch("description")
  # list_id = params.fetch("list_id").to_i()
  # @list = List.find(list_id)
  @task = Task.new({:description => description})
  @task.save()
  erb(:success)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task_edit)
end

patch('/tasks/:id') do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:index)
end
