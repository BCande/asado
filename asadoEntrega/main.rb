require 'sinatra'
require 'sinatra/reloader' if development?
require 'mysql2'
require 'json'

Mysqlclient = Mysql2::Client.new(host: 'localhost',
                                 username: 'usuario',
                                 password: 'usuario',
                                 database: 'asado')
def get_asistentes
  Mysqlclient.query('SELECT asistente.id_asistente, asistente.nombre FROM asistente', :as => :hash).to_a
end

def get_detallegasto
  Mysqlclient.query('SELECT * FROM detallegasto', :as => :hash).to_a
end
def get_detallePorAsistente
  Mysqlclient.query('SELECT* FROM detalleporasistente', :as => :hash).to_a
end
def get_resumenAsado
  Mysqlclient.query('SELECT gastototal.sumaTotal, gastototal.cantidadAsistentes, gastototal.cadaUnoPone 
    FROM gastototal', :as => :hash).to_a
end



post '/nuevoGasto' do  
  concepto = params[:concepto]
  cantidad = params[:cantidad]
  id_asistente = params[:id_asistente]  
  insert = "INSERT INTO gasto (gasto.concepto, gasto.cantidad, gasto.id_asistente) VALUES ('#{@params[:concepto]}', #{@params[:cantidad]}, #{@params[:id_asistente]})"
  Mysqlclient.query(insert, :as => :hash).to_a
  #"la cantidad es #{params[:cantidad]} y el concepto es #{concepto}. Gastos por #{id_asistente}"
  @asistentes = get_asistentes 
  @detalleGasto = get_detallegasto
  @detallePorAsistente = get_detallePorAsistente 
  @resumenAsado = get_resumenAsado
  erb :main  
end

post '/nuevoAsistente' do  
  nuevoAsistente = params[:nuevoAsistente]  
  insert = "INSERT INTO asistente (nombre) SELECT * FROM (SELECT '#{@params[:nuevoAsistente]}') AS tmp
WHERE NOT EXISTS (SELECT nombre FROM asistente WHERE nombre = '#{@params[:nuevoAsistente]}') LIMIT 1;
"
  Mysqlclient.query(insert, :as => :hash).to_a
  #"la cantidad es #{params[:cantidad]} y el concepto es #{concepto}. Gastos por #{id_asistente}"
  @asistentes = get_asistentes 
  @detalleGasto = get_detallegasto
  @detallePorAsistente = get_detallePorAsistente 
  @resumenAsado = get_resumenAsado
  erb :main
end


get '/' do
  @asistentes = get_asistentes 
  @detalleGasto = get_detallegasto
  @detallePorAsistente = get_detallePorAsistente 
  @resumenAsado = get_resumenAsado 
  erb :main
end
post '/borrar' do  
  nuevoAsistente = params[:nuevoAsistente]  
  delete = "DELETE FROM asistente"
  Mysqlclient.query(delete, :as => :hash).to_a
  delete = "DELETE FROM gasto"
  Mysqlclient.query(delete, :as => :hash).to_a
  #"la cantidad es #{params[:cantidad]} y el concepto es #{concepto}. Gastos por #{id_asistente}"
  @asistentes = get_asistentes 
  @detalleGasto = get_detallegasto
  @detallePorAsistente = get_detallePorAsistente 
  @resumenAsado = get_resumenAsado
  erb :main
end
