class Auditoria < ActiveRecord::Base

    self.table_name="auditorias_012020"  	    
    establish_connection :DB_AUDITORIAS 
  	attr_accessible :usuario, :usuario_update, :ip, :ip_update, :accion, :tabla, :pista_antes, :pista_despues, :sistema

end