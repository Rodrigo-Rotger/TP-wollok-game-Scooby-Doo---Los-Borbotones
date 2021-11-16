
import wollok.game.*
import movimiento.*
import niveles.*
import utilidades.*

object scooby {
	
	var property position = utilidades.posicionRandom() 
	var property energia = 30
	var property salud = 100
	
	var property direccion = arriba

	method image() = "scooby.png"
	
	method aumentarEnergia(cantidad){ energia += cantidad }
	
	method perderSalud(cantidad) { salud -= cantidad }  
	
	method aumentarSalud(cantidad){ salud += cantidad }
	
	method reiniciar(){ 
		energia = 30
		salud = 100
	}
	
	method interactuarCon(unElemento) {
		unElemento.interactuar()
    }
    
      
	method verificarPerder(){
		if (energia <= 0 or salud <= 0) { nivel1.perder() }
	}
	
	method elementosAlRededor(nivel){
	//Preguntamos si hay algo alrededor (las cuatro direcciones)
		nivel.hayElementosAlRededorDe([
			arriba.siguiente(position), 
			abajo.siguiente(position),
			derecha.siguiente(position),
			izquierda.siguiente(position)
		])
	}
	
	
	method retrocede() {
		position = direccion.opuesto().siguiente(position)
		energia += 1
	}
	
	method irArriba() {
		direccion = arriba
		self.avanzar()
	}

	method irAbajo() {
		direccion = abajo
		self.avanzar()
	}

	method irIzquierda() {
		direccion = izquierda
		self.avanzar()
	}

	method irDerecha() {
		direccion = derecha
		self.avanzar()
	}
	
	method avanzar() {
		position = direccion.siguiente(position)
		energia -= 1
		self.verificarPerder()
		
	}
		
}