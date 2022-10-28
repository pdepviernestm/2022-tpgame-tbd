import personajes.*
import wollok.game.*
object evento{

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
		game.onCollideDo(auto,{autoJugador => autoJugador.powerUpActual().chocar(auto)} )	
	}
	
	method generarArbol(){
		var arbol = new Arbol(position=game.at(0,6))
		game.addVisual(arbol)
		arbol.movimiento()
	}
	method generarCajaMisteriosa(){
		var caja = new CajaMisteriosa(position=carril.aleatorio().down(1))
		game.addVisual(caja)
		caja.movimiento()
		game.onCollideDo(caja,{autoJugador => autoJugador.powerUpActual().chocar(caja)} )		
	}

}
object carril{
	
	method aleatorio()=game.at(2.randomUpTo(5.1).truncate(0),6)
		
	
}
