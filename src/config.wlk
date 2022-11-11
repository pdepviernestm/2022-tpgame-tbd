import wollok.game.*
import personajes.*
import eventos.*
import config.*
object config {
	method configurar(){
		//Config
	game.height(7)
	game.width(8)
	game.boardGround("Autopista2.png")
	game.cellSize(130)
	game.addVisual(inicioDeJuego)
	
	//jugador
	game.addVisual(autoJugador)
	keyboard.left().onPressDo { autoJugador.powerUpActual().moverIzquierda() }
	keyboard.right().onPressDo { autoJugador.powerUpActual().moverDerecha() }

	//Eventos
	keyboard.enter().onPressDo{ evento.inicio()}
	game.onCollideDo(autoJugador,{obstaculo=>obstaculo.efectoDeChoque()})

	//Start
	game.start()
	}
	
	method restart(){
		game.clear()
		game.addVisual(inicioDeJuego)
		game.addVisual(autoJugador)
		keyboard.left().onPressDo { autoJugador.powerUpActual().moverIzquierda() }
		keyboard.right().onPressDo { autoJugador.powerUpActual().moverDerecha() }
		keyboard.enter().onPressDo{ evento.inicio()}
		game.onCollideDo(autoJugador,{obstaculo=>obstaculo.efectoDeChoque()})
	}
	
}
