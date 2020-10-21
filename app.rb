current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each {|file| require file}
require 'active_record'
require 'sinatra/activerecord'
require 'sinatra'

set :bind, '0.0.0.0'

$empleados = Array.new
$consulta = User.all
$consulta.each do |r|
    $empleados.push(r['usuario'], r['pass'])
end

get '/' do
    erb :index
end

post '/login' do
    @usuario = params['usr_name']
    @pass    = params['pass']

    user = $empleados.include?(@usuario)
    pass = $empleados.include?(@pass)
    if user == true && pass == false
        erb :pass_fail
    elsif user == false
        erb :no_user
    else
        @llamadas = Call.all
        erb :calls
    end
end