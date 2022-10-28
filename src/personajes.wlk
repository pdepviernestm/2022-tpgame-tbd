import eventos.*
import wollok.game.*


object autoJugador{
	var property position= game.at(5,0) // arranca en 5 porque sale del garaje
	var property powerUpActual = powerUpDefault
	var property pasajeros = 0
	var property capacidad = 1
	var property image = "autoJugador.png"
	method subirPasajeros(cant){
		if(pasajeros + cant <= capacidad )pasajeros +=cant
		//else deberia perder puntos
	}

}


object hospital{
	var property position 
	method image()= "garaje.png"
	method efectoDeChoque(){
		autoJugador.capacidad(0)
		autoJugador.position(game.at(5,0))
	}
	method aparecer(){
		position = game.at(6,6) 
		game.addVisual(self)
		game.onTick(1000,"moverHospital",{self.position(position.down(1))})
		game.schedule(7000,{game.removeTickEvent("moverHospital")})
		game.schedule(10000,{game.removeVisual(self)})
	}
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
		game.onTick(velocidad,"movimiento del obstaculo",{self.moverHaciaAbajo()})
		game.schedule(5000, {game.removeVisual(self)})
	}
	method moverHaciaAbajo(){
		position = position.down(1)
		
	}
	method efectoDeChoque(){
		if(autoJugador.powerUpActual().estasBlindado())powerUpDefault.default()
		else evento.gameOver()
	}
}

class Accidente inherits Obstaculo(velocidad=300){
	var image
	var personas
	override method image()= image
	override method efectoDeChoque(){
		autoJugador.subirPasajeros(personas)
	}
	
}

class Auto inherits Obstaculo(velocidad = 500){
	//Arrancan siempre en(x,7) x varia de 2 a 5 
	var image

	override method image()= image
	
}

class Arbol inherits Obstaculo(velocidad = 300){
	override method image()= "arbol.png"
}


class CajaMisteriosa inherits Obstaculo(velocidad = 500){
	const powerUpsDispoibles =[blindaje, invertirControles,congelar]
	var efectoQueDoy= powerUpsDispoibles.get(new Range(start=0,end=powerUpsDispoibles.size()-1 ).anyOne())
	override method image() = "cajaMisteriosa.png"
	override method efectoDeChoque(){
		autoJugador.image(efectoQueDoy.image())
		autoJugador.powerUpActual(efectoQueDoy)
		game.schedule(efectoQueDoy.duracion(),{powerUpDefault.default()})
	}
}
class PowerUp {
	var property duracion
	var property image = "autoJugador.png"
	method moverIzquierda() {
		if(autoJugador.position().x()>2){
			autoJugador.position(autoJugador.position().left(1))
		}	
	}
	method moverDerecha() {
		if(autoJugador.position().x()<5 || game.hasVisual(hospital)){
			autoJugador.position(autoJugador.position().right(1))
		}
	}
	method estasBlindado()= false
}

object powerUpDefault inherits PowerUp(duracion = 0){
	method default(){
		autoJugador.powerUpActual(self)
		autoJugador.image(self.image())
		}
	}


object invertirControles inherits PowerUp(duracion=4000){
	override method moverDerecha() {
		if(autoJugador.position().x()>2){
			autoJugador.position(autoJugador.position().left(1))
		}	
	}
	override method moverIzquierda() {
		if(autoJugador.position().x()<5 || game.hasVisual(hospital)){
			autoJugador.position(autoJugador.position().right(1))
		}
	}
}

object blindaje inherits PowerUp(duracion = 5000){
	override method estasBlindado()= true
	override method image()= "autoBlindado.png"
}

object congelar inherits PowerUp(duracion = 1000){
	override method image()="autoCongelado.png"
	override method moverIzquierda(){}
	override method moverDerecha(){}
}

