import wollok.game.*

class Direccion {
	method siguiente(position)
}

object izquierda inherits Direccion { 
	
	override method siguiente(position){
		var nueva = position.left(1)
        if (position.x() == 0 ){
            nueva = game.at( game.width() - 1, position.y()  )
        }
        return nueva
    } 

	method opuesto() = derecha
}

object derecha inherits Direccion { 
	override method siguiente(position) {
		
    var nueva = position.right(1)
        if (position.x() > game.width() -2 ){
            nueva = game.at( 0, position.y()  )
        }
        return nueva
    }  
    
	method opuesto() = izquierda
}

object abajo inherits Direccion { 
	override method siguiente(position) {
        
    var nueva = position.down(1) 
        if (position.y() - 1 < 0 ){
            nueva =  game.at( position.x(), game.height() - 2  )
        }
        return nueva
    }
     
	method opuesto() = arriba
}

object arriba inherits Direccion { 
	
	override method siguiente(position) {
		
	var nueva = position.up(1)
        if (position.y() > game.height() - 3 ) {
            nueva = game.at( position.x(), 0  )
        }

        return nueva
	} 
	method opuesto() = abajo
}
