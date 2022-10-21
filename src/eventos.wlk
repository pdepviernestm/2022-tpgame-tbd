import personajes.*
import wollok.game.*
object eventos{
	const listaVisuales = []
	// generadores
	method autoRojo(){
		var auto = new Auto(position=carril.aleatorio(),image="autoJugador.png")
		game.addVisual(auto)
		listaVisuales.add(auto)		
	}
	
	method arbol(){
		var arbol = new Arbol(position=game.at(0,6))
		game.addVisual(arbol)
		listaVisuales.add(arbol)
	}
	
	method moverHaciaAbajo(){
		listaVisuales.forEach { obj => obj.mover() }
	}
}
object carril{
	
	method aleatorio()=game.at(2.randomUpTo(5.1).truncate(0),6)
		
	
}
