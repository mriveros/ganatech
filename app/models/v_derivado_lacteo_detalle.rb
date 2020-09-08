class VDerivadoLacteoDetalle < ActiveRecord::Base

  self.table_name="v_derivados_lacteos_detalles"
  self.primary_key="id"
  
  attr_accessible :derivado_lacteo_detalle_id,
	:derivado_lacteo_id,
	:fecha_salida,
	:monto,
	:cliente_id,
	:nombre_razon_social,
	:observacion,
	:estado_derivado_lacteo_detalle_id,
	:estado_derivado_lacteo_detalle ,
	:cantidad_inicial,
	:cantidad_actual,
	:tipo_salida_derivado_id ,
	:tipo_salida_derivado,
	:cantidad_salida 
  scope :orden_01, -> { order("derivado_lacteo_detalle_id")}
  
end