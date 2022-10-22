import personajes.*
import wollok.game.*
object eventos{
	
	// generadores
	
	method generarJugador(){
		game.addVisual(autoJugador)
		keyboard.left().onPressDo { autoJugador.moverIzquierda() }
		keyboard.right().onPressDo { autoJugador.moverDerecha() }
	}
	
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
