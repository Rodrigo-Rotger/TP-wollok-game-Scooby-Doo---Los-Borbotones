import wollok.game.*
import utilidades.*
import niveles.*
import personajes.*


class Elementos{
	
	var property position
	
	method image()
	
	method otorga()
	
	method realizarAccion(nivel, elemento){ 
		nivel.borrarObjeto(self)
	}
	
	//Cuando colisiona...
	method interactuar(){ scooby.retrocede()}
	
	method esEnemigo() = false
	 
	method puedePisarte(_) = false

}


//alimentos, botiquin y moneda

class Galleta inherits Elementos{
	
	override method otorga() = 10
	override method image() = "burger.png"
	
	override method realizarAccion(nivel,elemento){
		
		elemento.aumentarEnergia(self.otorga())
		super(nivel,elemento)
	}
}

class Hamburguesa inherits Elementos{
	
	override method otorga() = 20
	override method image() = "galleta.png"
	
	override method realizarAccion(nivel,elemento){
		
		elemento.aumentarEnergia(self.otorga())
		super(nivel,elemento)
	}
}

class Botiquin inherits Elementos {
	
	override method otorga() = 10
	override method image() = "botiquin.png"
	
	override method realizarAccion(nivel,elemento){
		
		elemento.aumentarSalud(self.otorga())
		super(nivel,elemento)
	}
}

class Curita inherits Elementos {	
	override method otorga() = 5
	override method image() = "curitas.png"
	
	override method realizarAccion(nivel,elemento){
		
		elemento.aumentarSalud(self.otorga())
		super(nivel,elemento)
	}
}

class Moneda inherits Elementos {
	
	var property danio = 10
	
	override method otorga() = 10
	override method image() = "dinero.png"
	
	override method realizarAccion(nivel,elemento){}
	
	//Cuando colisiona...
	override method interactuar() { 
		nivel2.agregarDinero(self.otorga())
		nivel2.borrarObjeto(self)
		scooby.perderSalud(danio)
		scooby.verificarPerder()
	}
}
//cofres sorpresa
class CofreSorpresa{
	var property position
	var property fueActivada = false
	var property image = "sorpresa.png"
	
	method cambiarImagen(){image="sorpresaUsada.png"}
	
	method realizarAccion(nivel,elemento){
        if (not  fueActivada ) { 
            self.cambiarImagen()
            fueActivada = true 
            self.sorpresa(elemento)
        }
    }

    method sorpresa(elemento)
    
    method esEnemigo() = false
	
	method puedePisarte(_) = false
	
	//Cuando colisiona...
	method interactuar(){scooby.retrocede()}
}

class CofreSorpresa1 inherits CofreSorpresa{
	
	override method sorpresa(elemento){
        elemento.aumentarEnergia( -15 )
    }
}

class CofreSorpresa2 inherits CofreSorpresa{
	
	override method sorpresa(elemento){
        elemento.aumentarEnergia( 30 )
    }
}

class CofreSorpresa3 inherits CofreSorpresa{
	
	override method sorpresa(elemento){
        nivel1.ponerElementos(1, hamburguesa)
    }
}

class CofreSorpresa4 inherits CofreSorpresa{
	
	override method sorpresa(elemento){
        elemento.position(utilidades.posicionRandom())
    }
}
class Amigos {
	
	var property position
	var imagen 
	
	
	method image () = imagen
	
	//Cuando colisiona...
	method interactuar() {
		// Verifica si se puede mover en la direccion en la que se mueve scooby,en caso positivo 
		// lo mueve en la siguiente posicion de scooby generando el efecto de ser empujado
		if (self.puedeSerMovido(scooby.direccion())){
			position = scooby.direccion().siguiente(position)
			// Una vez que se mueve verifica si esta en el deposito
			self.dentroDeposito() 		 
		}
		else {
			game.say(self, "Algo me traba.")
			scooby.retrocede()
		}
			
	}
	// Verifica si en la siguiente posicion hay algun objeto y retorna una booleano.
	method puedeSerMovido(direccion) {
		const posAlLado = direccion.siguiente(position) 
		const lugarLibre = game.getObjectsIn(posAlLado)
			.all{ obj => obj.puedePisarte(self) } 
		
		return lugarLibre
		
	}
	
	method dentroDeposito() {
		if (self.estoyEnDeposito()){
			nivel1.borrarObjeto(self)
			nivel1.agregarAmigo()
		}
	}
	method esEnemigo() = false
	
	method puedePisarte(_) = false
	
	
	method realizarAccion(nivel, elemento) = game.say(self, "Llevame a la camioneta! Scooby!")
	
	method estoyEnDeposito() = position == deposito.position()
}


class Fantasma {
	
	var property position
	
	var property danio = 15
	
	method image() = "fantasma.png"
	method buscar(){position = utilidades.posicionRandom()}
	
	method esEnemigo() = true
	
	method realizarAccion(nivel,elemento){}
	
	//Cuando colisiona...
	method interactuar() { 
		scooby.perderSalud(danio)
		scooby.retrocede()
		scooby.verificarPerder()
	}
	
	method puedePisarte(_) = false
}

object deposito {
	var property position = utilidades.posicionRandom()
	method image () = "maquina_del_misterio.png"
	method puedePisarte(_) = true
	method interactuar(){scooby.retrocede()}
	method realizarAccion(elemento) {}
}

object fondo{
	var property imagen = "fondoCementerio.jpg"
	method image() = imagen 
	
	method cambiarFondo(nuevaImagen) { 
		imagen = nuevaImagen
	}
}
object salida{
	var property position = utilidades.posicionRandom()
	
	method image () = "maquina_del_misterio.png"
	
	method interactuar(){nivel2.ganar()}
}


object marcadorEnergia{
	method position() =  game.at(2, 8)
	method text() = "Energia: " + scooby.energia()   
}

object marcadorSalud{
	method position() =  game.at(4, 8)
	method text() = "Salud: " + scooby.salud()   	
}

object marcadorPistas{
	method position() =  game.at(6, 8)
	method text() = "Amigos: " + nivel1.amigos()  
}

object marcadorDinero{
	method position() =  game.at(6, 8)
	method text() = "Dinero: " + nivel2.dinero() 
}