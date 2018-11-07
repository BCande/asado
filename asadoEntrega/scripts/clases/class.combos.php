<?php

class selects extends MySQL
{
	var $code = "";
	
	function cargarCampos()
	{
		$consulta = parent::consulta("SELECT * FROM campo ORDER BY campo_nb ASC");
		$num_total_registros = parent::num_rows($consulta);
		if($num_total_registros>0)
		{
			$campos = array();
			while($campo = parent::fetch_assoc($consulta))
			{
				$code = $campo["id_campo"];
				$name = $campo["campo_nb"];				
				$campos[$code]=$name;
			}
			return $campos;
		}
		else
		{
			return false;
		}
	}
	function cargarLotes()
	{
		$consulta = parent::consulta("SELECT * FROM lote WHERE id_campo='".$this->code."'");

		$num_total_registros = parent::num_rows($consulta);
		if($num_total_registros>0)
		{
			$lotes = array();
			while($lote = parent::fetch_assoc($consulta))
			{
				$name = $lote["lote_nb"];				
				$lotes[$name]=$name;
			}
			return $lotes;
		}
		else
		{
			return false;
		}
	}
		
		
}
?>