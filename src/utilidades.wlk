import wollok.game.*
import elementos.*
import personajes.*

object utilidades {
	//crea posiciones aleatorias para los elementos del juego
	method posicionRandom() {
		
		const x = 0.randomUpTo(game.width()).truncate(0)
		const y = 0.randomUpTo(game.height() - 1).truncate(0)

		return game.at(x, y)
	}
}


//alimentos y salud
object galleta{ method instanciar(unaPosicion) = new Galleta(position=unaPosicion) }
object hamburguesa{ method instanciar(unaPosicion) = new Hamburguesa(position=unaPosicion) }
object fantasma{ method instanciar(unaPosicion) = new Fantasma(position=unaPosicion) }
object botiquin{ method instanciar(unaPosicion) = new Botiquin(position=unaPosicion) }
object curita{ method instanciar(unaPosicion) = new Curita(position=unaPosicion) }

object moneda{ method instanciar(unaPosicion) = new Moneda(position=unaPosicion) }
//cofres sorpresa
object cofreSorpresa1{ method instanciar(unaPosicion) = new CofreSorpresa1(position=unaPosicion) }
object cofreSorpresa2{ method instanciar(unaPosicion) = new CofreSorpresa2(position=unaPosicion) }
object cofreSorpresa3{ method instanciar(unaPosicion) = new CofreSorpresa3(position=unaPosicion) }
object cofreSorpresa4{ method instanciar(unaPosicion) = new CofreSorpresa4(position=unaPosicion) }
//amigos
object shagy{ method instanciar(unaPosicion) = new Amigos(position=unaPosicion, imagen = "shaggy.png" ) }
object fred{ method instanciar(unaPosicion) = new Amigos(position=unaPosicion, imagen = "fred.png" ) }
object vilma{ method instanciar(unaPosicion) = new Amigos(position=unaPosicion, imagen = "vilma.png" ) }
object daphne{ method instanciar(unaPosicion) = new Amigos(position=unaPosicion, imagen = "daphne.png" ) }


