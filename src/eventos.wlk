import personajes.*
import wollok.game.*
object evento{
	
	method choque(algo){
		if(algo.esObstaculo()){
			game.removeTickEvent("generarAuto")
			game.removeTickEvent("generarArbol")
			game.removeTickEvent("movimiento del obstaculo") //no se porque no los para a los autos
			self.gameOver()
		}
	}
	method gameOver(){
		game.addVisual(cartel)
		game.schedule(4000,{=> game.stop()})
	}
	
	
}
object generador{	
	method generarAutoRojo(){
		var auto = new Auto(position=carril.aleatorio(),image="autoJugador.png")
		game.addVisual(auto)
		auto.movimiento()		
	}
	
	method generarArbol(){
		var arbol = new Arbol(position=game.at(0,6))
		game.addVisual(arbol)
		arbol.movimiento()
	}
}
object carril{
	
	method aleatorio()=game.at(2.randomUpTo(5.1).truncate(0),6)
		
	
}
