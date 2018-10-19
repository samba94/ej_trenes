/**
	No hay un solo test, hacer tests!, es obligatorio.
	
	El resto está muy bien, ver algunos comentarios abajo.
 */

class Formacion{
	var locomotoras = []
	var todosLosVagones = []
	
	method calcularTotalPasajeros(){
		// ojo con el método CuantosPuedeLlevar() no es polimórfico si tenés una lista con vagones de carga y pasajeros esto rompe
		return todosLosVagones.sum({vagon => vagon.cuantosPuedeLlevar()})  
	}
	
	method cantidadDeLivianos(){
		return todosLosVagones.sum({vagon => vagon.esLiviano()})
	}
	
	method velocidadMaximaDeFormacion(){
		return locomotoras.min({locomotora => locomotora.velMax()})
	}
	
	method esEficiente(){
		return locomotoras.all({locomotora => locomotora.arrastreUtil() >= locomotora.peso()*5 })
	}
	
	method puedeMoverse(){
		return locomotoras.sum({locomotora => locomotora.arrastreUtil()}) >= todosLosVagones.sum({vagon => vagon.pesoMaximo()})
	}
	
	method empujeFaltante(){
		var ret
		
		if (self.puedeMoverse()){
			ret = 0
		} else{
			ret = todosLosVagones.sum({vagon => vagon.pesoMaximo()}) - locomotoras.sum({locomotora => locomotora.arrastreUtil()})
		}
		return ret
	}
	
	method elMasPesado(){
		return todosLosVagones.max({vagon => vagon.pesoMaximo()})
	}
	
	method pesoTotal(){
		return todosLosVagones.sum({vagon => vagon.pesoMaximo()}) + locomotoras.sum({locomotora => locomotora.peso()})
	}
	
	
	method esCompleja(){
		var ret = false  // no entiendo que es ret
		var masDe20 = locomotoras.size() + todosLosVagones.size() > 20		
		
		if(masDe20 or self.pesoTotal()>10000){
			ret = true  // que es ret??
		}
		return ret // sigo sin entender que es ret jajaja

	// Este método cumple lo pedido, pero no está bueno es díficil de leer, se puede resolver así:
	// return locomotoras.size() + todosLosVagones.size() > 20 or self.pesoTotal() > 10000
	}
	
}

class VagonPasajeros{
	var largo
	var ancho
	
	method cuantosPuedeLlevar(){
		var total
		if(ancho <= 2.5){
			total = largo * 8
		} else{
			total = largo * 10
		}
		return total
		
		/** Está bien, también se puede escribir así:
			if(ancho <= 2.5){
				return largo * 8
			}
			return largo * 10
		 */
	}
	

	method puedeLlevarCarga(){
		return false
	}
	
	method puedeLlevarPasajeros(){
		return true
	}
	
	method pesoMaximo(){
		return self.cuantosPuedeLlevar()*80
	}
	
	method esLiviano(){
		return self.pesoMaximo() < 2500
	}		
	
}

class VagonCarga{	
	var maxCarga	

	method puedeLlevarCarga(){
		return true
	}
	
	method puedeLlevarPasajeros(){
		return false
	}
	
	method pesoMaximo(){
		return maxCarga + 160
	}
	
	method esLiviano(){
		return self.pesoMaximo() < 2500
	}		
	
}

class Locomotora{	
	var property peso
	var property pesoMaximo
	var property velMax
	
	method arrastreUtil(){
		return pesoMaximo - peso
	}
	
}

class Deposito{
	var formaciones = []
	var locomotoras = []
	
	method vagonesMasPesados(){
		return formaciones.filter({formacion => formacion.elMasPesado()})
	}
	
	method necesitaConductorExperimentado(){
		return formaciones.any({formacion => formacion.esCompleja()})
	}
	
	method agregarLocomotoraA(formacion){
		if(!formacion.puedeMoverse()){
			formaciones.add(formacion)
		}
		
		if(locomotoras.any({locomotora => locomotora.arrastreUtil() >= formacion.empujeFaltante()})){
			locomotoras.add(locomotoras.anyOne({locomotora => locomotora.arrastreUtil() >= formacion.empujeFaltante()}))
		}
		
	}
		
}

