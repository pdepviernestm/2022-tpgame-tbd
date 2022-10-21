import example.*
import wollok.game.*
object eventos{
	method autoRojo(){
		var auto = new Auto(position=carril.aleatorio(),image="autoJugador.png")
		game.addVisual(auto)
		
	}
	method moverArboles(){
		generarArbol.arboles().forEach{a=> a.meMovieron()}
	}
}
object carril{
	
	method aleatorio()=game.at(2.randomUpTo(5.1).truncate(0),6)
			
}
object generarArbol{
	const arbolesGenerados =[]
	method arboles()= arbolesGenerados
	method nuevoArbol(){
		const arbol = new Arbol()
		arbolesGenerados.add(arbol)
		game.addVisual(arbol)
	} 
}

