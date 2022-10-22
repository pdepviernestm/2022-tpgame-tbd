import eventos.*
import wollok.game.*

object autoJugador {
	var property position= game.at(5,0) // arranca en 5 porque sale del garaje
	
	method image()= "autoJugador.png"
	method moverIzquierda() {
		if(position.x()>2){
			position = position.left(1)
		}	
	}
	method moverDerecha() {
		if(position.x()<5){
			position = position.right(1)
		}
	}
}
object garaje{
	var property position = game.at(7,0) //estaba en 13
	method image()= "garaje.png"
}

class Obstaculo{
	var velocidad //cada cuanto se mueve
	var property position
	method image()
	method movimiento(){
		game.onTick(velocidad,"movimiento del obstaculo",{=> position = position.down(1)})
	}
}
class Auto inherits Obstaculo(velocidad = 500){
	//Arrancan siempre en(x,7) x varia de 2 a 5 y siempre par
	var image
	method image(imagen){
		image = imagen
	}
	override method image()= image
		
}

class Arbol inherits Obstaculo(velocidad = 300){
	override method image()= "arbol.png"
	
}