import eventos.*
import wollok.game.*


object autoJugador{
	var property position= game.at(5,0) // arranca en 5 porque sale del garaje
	var property powerUpActual = powerUpDefault
	method image()= "autoJugador.png"
}


object garaje{
	var property position = game.at(7,0) 
	method image()= "garaje.png"
}


object cartel{
	var property position = game.at(2,3) 
	method image()= "fin.png"
}


class Obstaculo{
	var velocidad //cada cuanto se mueve
	var property position
	method image()
	method movimiento(){
		game.onTick(velocidad,"movimiento del obstaculo",{=> self.moverHaciaAbajo()})

	}
	method moverHaciaAbajo(){
		position = position.down(1)
		
	}
	method efectoDeChoque(){}
}
class Auto inherits Obstaculo(velocidad = 500){
	//Arrancan siempre en(x,7) x varia de 2 a 5 
	var image
	method image(imagen){
		image = imagen
	}
	override method image()= image
	override method efectoDeChoque(){
		game.removeTickEvent("generarAuto")
		game.removeTickEvent("generarArbol")
		game.removeTickEvent("movimiento del obstaculo") //no se porque no los para a los autos
		evento.gameOver()
	}


}

class Arbol inherits Obstaculo(velocidad = 300){
	override method image()= "arbol.png"
}



class PowerUp {
	var property duracion
	method moverIzquierda() {
		if(autoJugador.position().x()>2){
			autoJugador.position(autoJugador.position().left(1))
		}	
	}
	method moverDerecha() {
		if(autoJugador.position().x()<5 || game.hasVisual(garaje)){
			autoJugador.position(autoJugador.position().right(1))
		}
	}
	method chocar(obstaculo){
		obstaculo.efectoDeChoque()
	}
}

object powerUpDefault inherits PowerUp(duracion = 0){
	}


class InvertirControles inherits PowerUp(duracion=4000){
	override method moverDerecha() {
		if(autoJugador.position().x()>2){
			autoJugador.position(autoJugador.position().left(1))
		}	
	}
	override method moverIzquierda() {
		if(autoJugador.position().x()<5 || game.hasVisual(garaje)){
			autoJugador.position(autoJugador.position().right(1))
		}
	}
}

class Blindaje inherits PowerUp(duracion = 10000){
	override method chocar(obstaculo){
	}
}

class CajaMisteriosa inherits Obstaculo(velocidad = 500){
	override method image() = "powerUp.png"
	override method efectoDeChoque(){
		autoJugador.powerUpActual(new InvertirControles())
		game.schedule(4000,{=>autoJugador.powerUpActual(powerUpDefault)})
	}	

}

