import eventos.*
import wollok.game.*


object autoJugador{
	var property position= game.at(5,0) // arranca en 5 porque sale del garaje
	var property powerUpActual = powerUpDefault
	var property pasajeros = 0
	var property image = "autoJugador.png"
	method subirPasajeros(cant){
		if(pasajeros + cant <= capacidad.capacidad() ){
			pasajeros +=cant

		}
		else score.aumentarPuntaje(-cant)
	}
}
object score{
	var property puntaje = 0
	method aumentarPuntaje(cant){
		puntaje += cant
		if(puntaje < 0) evento.gameOver()
	}
	method text() = puntaje.toString()
	method position() = game.at(1, game.height()-1)
}

object capacidad{
	var property capacidad = 10
	method text() = capacidad.toString()
	method position() = game.at(1, game.height()-3)
}

object hospital{
	var property position 
	method image()= "garaje.png"
	method efectoDeChoque(){
		score.aumentarPuntaje(autoJugador.pasajeros()*10)
		autoJugador.pasajeros(0)
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
		game.onTick(velocidad,"movimiento del obstaculo",{position = position.down(1)})
		game.schedule(5000, {self.eliminar()})
	}
	method eliminar(){
		game.removeVisual(self)
		game.removeTickEvent("movimiento del obstaculo")
	}
	method efectoDeChoque(){
		if(autoJugador.powerUpActual().estasBlindado())powerUpDefault.default()
		else if(autoJugador.powerUpActual().estasInmune()){}
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
	const powerUpsDispoibles =[blindaje, invertirControles,congelar,aumentarCapacidad,inmunidad]
	var efectoQueDoy= powerUpsDispoibles.get(new Range(start=0,end=powerUpsDispoibles.size()-1 ).anyOne())
	override method image() = "cajaMisteriosa.png"
	override method efectoDeChoque(){
		autoJugador.powerUpActual(efectoQueDoy)
		efectoQueDoy.efecto()
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
	//!(game.getObjectsIn(game.at(0,6)).isEmpty())
	method moverDerecha() {
		if(autoJugador.position().x()<5 || (game.hasVisual(hospital)&&hospital.position().y()==0) ){
			autoJugador.position(autoJugador.position().right(1))
		}
	}
	method estasBlindado()= false
	method estasInmune()=false

	method efecto(){
		autoJugador.image(self.image())
		game.schedule(duracion,{powerUpDefault.default()})
	}
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
		if(autoJugador.position().x()<5 || (game.hasVisual(hospital)&&hospital.position().y()==0)){
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

object aumentarCapacidad inherits PowerUp(duracion = 1){
	override method efecto(){
		capacidad.capacidad(capacidad.capacidad()+1)
	}
}
object inmunidad inherits PowerUp(duracion = 3000){
	var img=1
	override method image() = "auto.png"
	override method estasInmune ()= true
	override method efecto(){
		autoJugador.image(self.image())
		//game.onTick(100,"titilar",{self.cambiarImagen()})
		//game.schedule(duracion-20,{game.removeTickEvent("titilar")})
		game.schedule(duracion,{powerUpDefault.default()})
	}
}

