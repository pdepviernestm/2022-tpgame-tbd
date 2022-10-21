import wollok.game.*
import eventos.*
object autoJugador {
	var property position= game.at(5,0) // arranca en 10 porque sale del garaje
	method image()= "autoJugador.png"
}
object garaje{
	var property position = game.at(7,0) 
	method image()= "garaje.png"
}
class Arbol{
	var property position = game.at(0,6) 
	var posicionesMovidas = 0
	method image()= "arbol.png"
	method meMovieron(){
		self.position(self.position().down(1))
		posicionesMovidas = posicionesMovidas + 1
		if (posicionesMovidas > 7) {
			game.removeVisual(self)
			generarArbol.arboles().remove(self)
		}
	}
}
class Auto{
	//Arrancan siempre en(x,7) x varia de 2 a 5 
	var property position
	var image
	
	method image(unaImagen){
		image= unaImagen
	}
	method image()= image
}
