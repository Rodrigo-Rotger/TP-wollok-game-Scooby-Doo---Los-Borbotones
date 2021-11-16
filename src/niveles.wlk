import elementos.*
import personajes.*
import wollok.game.*
import utilidades.*

class Nivel {
	
	var property elementosEnNivel = []
	
	method ponerElementos(cantidad, elemento) { 	// debe recibir cantidad y EL NOMBRE DE UN ELEMENTO
		if(cantidad > 0) {
			const unaPosicion = utilidades.posicionRandom() 
			if (not self.hayElementoEn(unaPosicion) ) {	//si la posicion no esta ocupada
				const unaInstancia = elemento.instanciar( unaPosicion ) // instancia el elemento en una posicion
				elementosEnNivel.add(unaInstancia)	//Agrega el elemento a la lista
				game.addVisual(unaInstancia) //Agrega el elemento al juego
				self.ponerElementos(cantidad -1,elemento) //llamada recursiva al proximo elemento a agregar
			}else{
				self.ponerElementos(cantidad,elemento)	
			}
		}
	}
	
	method verificarPerder() {
		if (scooby.energia() <= 0 or scooby.salud()<= 0) { self.perder() }
	}
	// Recibe una coleccion con las 4 direcciones lindantes a scooby
	method hayElementosAlRededorDe(coleccion){
		// Crea una lista con las posiciones que tienen un elemento.
		const posiciones = coleccion.filter({ p => self.hayElementoEn( p ) }) 
		
		if(posiciones.size() > 0){
		// Recorremos la lista y aplicamos una transformacion para tener una lista de elementos para aplicarle la accion
			const elementos = posiciones.map({ e => self.elementoDe( e ) })
			elementos.forEach({ e => e.realizarAccion(self,scooby) })
		}
	}
	
	
	//Metodos para buscar elementos segun sus posiciones
	
	// Nos devuelve el elemento
	method elementoDe(posicion) = elementosEnNivel.find( { e => e.position() == posicion } )
	// Nos devuelve un booleano
	method hayElementoEn(posicion) = elementosEnNivel.any( { e => e.position() == posicion } )
	
	//Borrar un elemento capturado por scooby
	method borrarObjeto(objeto){
		game.removeVisual(objeto)
		
		elementosEnNivel = elementosEnNivel.filter({ e => e != objeto}) 
	}
	
	method configurate(){
		
//FANTASMAS
		
		const fantasma1 = new Fantasma ( position = game.at(0,0))
		const fantasma2 = new Fantasma ( position = game.at(0,0))
		
		const fantasma3 = new Fantasma ( position = game.at(0,0))
		
		game.onTick(2000, "mover", {fantasma1.buscar()})
		game.onTick(2000, "mover", {fantasma2.buscar()})
		
		game.onTick(2000, "mover", {fantasma3.buscar()})
		
		
		game.addVisual(fantasma1)
		game.addVisual(fantasma2)		
		game.addVisual(fantasma3)

		game.addVisual(scooby)
	
	
//	TECLADO
		keyboard.up().onPressDo{ scooby.irArriba() }
		keyboard.down().onPressDo{ scooby.irAbajo() }
		keyboard.left().onPressDo{ scooby.irIzquierda() }
		keyboard.right().onPressDo{ scooby.irDerecha() }
		keyboard.n().onPressDo{ scooby.elementosAlRededor(self) }
		
//	COLISIÓNES
		game.whenCollideDo(scooby, { e => scooby.interactuarCon(e) }) 
		
	}
	
	method perder() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		fondo.cambiarFondo("perdimos.png")	//poner imagen mas chica
				// después de un ratito ...
		game.schedule(1000, {
			game.clear()
				// cambio de fondo
			game.addVisualIn(fondo, game.at(0, 0))
				// después de un ratito ...
			game.schedule(3000, {
				// fin del juego
				game.stop()
			})
			
		}) 
		
	}
	
}

object nivel1 inherits Nivel {

	
	var property amigos = 0
	
	method agregarAmigo() { 
		amigos += 1
		if ( amigos == 4){
			self.terminar()
		}
	} 
	
	override method configurate(){ 
		
		
		game.addVisualIn(fondo, game.at(0, -1))
		game.addVisual(marcadorEnergia)
		game.addVisual(marcadorSalud)
		game.addVisual(marcadorPistas)
		game.addVisual(deposito)
		
		self.ponerElementos(2, botiquin)
		self.ponerElementos(2, curita)
		self.ponerElementos(2, galleta)
		self.ponerElementos(2, hamburguesa)
		self.ponerElementos(1, cofreSorpresa1)
		self.ponerElementos(1, cofreSorpresa2)
		self.ponerElementos(1, cofreSorpresa3)
		self.ponerElementos(1, cofreSorpresa4)
		self.ponerElementos(1, shagy)
		self.ponerElementos(1, fred)
		self.ponerElementos(1, vilma)
		self.ponerElementos(1, daphne)
		

		super()
		
	}
	
	method terminar() {
		
		game.clear()
		
		fondo.cambiarFondo("nivel_2.png")
		
		game.addVisualIn(fondo, game.at(0, 0))
		
		game.schedule(1000, {
			game.clear()
			scooby.reiniciar()
			
			fondo.cambiarFondo("fondoCementerio.jpg")
			
			game.schedule(1000, {
	
				nivel2.configurate()
		
			})
		}) 
		
	}
	
}

object nivel2 inherits Nivel {
	
	var property dinero = 0
	
	method agregarDinero(cantidad) { 
		dinero += cantidad
		if ( dinero == 100){
			self.agregarSalida()
		}
	} 
	
	method agregarSalida() { 
		game.addVisual(salida)
		game.say( salida, "Sube Scooby, ya termino el juego!")
	}
	
	
	override method configurate(){
		
		game.addVisualIn(fondo, game.at(0, -1))
		game.addVisual(marcadorEnergia)
		game.addVisual(marcadorSalud)
		game.addVisual(marcadorDinero)
		
		self.ponerElementos(3, curita)
		self.ponerElementos(2, galleta)
		self.ponerElementos(3, botiquin)
		self.ponerElementos(10, moneda)
		
		
		super()
			
	}
	
	method ganar() {
		
		game.clear()
		
		fondo.cambiarFondo("ganamos.png")
		
		game.schedule(1000, {
		game.clear()
				
		game.addVisualIn(fondo, game.at(0, 0))
				
		game.schedule(3000, {
					
		game.stop()
				})
			}) 
		
			}
}


