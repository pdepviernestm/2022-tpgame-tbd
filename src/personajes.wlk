import eventos.*
import wollok.game.*

object autoJugador {
	var property position= game.at(5,0) // arranca en 10 porque sale del garaje
	method image()= "autoJugador.png"
}
object garaje{
	var property position = game.at(7,0) //estaba en 13
	method image()= "garaje.png"
}

class Obstaculo{
	var property position
	method image()
	method mover(){
		position = self.position().down(1)
	}
}
class Auto inherits Obstaculo{
	//Arrancan siempre en(x,7) x varia de 2 a 5 y siempre par
	var image
	method image(imagen){
		image = imagen
	}
	override method image()= image
	override method mover(){
		game.schedule(100,{=> position = self.position().down(1)})
	}
}

class Arbol inherits Obstaculo{
	override method image()= "arbol.png"
	
}