import personajes.*
import wollok.game.*
object evento{

	method gameOver(){
		game.clear()
		game.addVisual(cartel)
		game.schedule(4000,{=> game.stop()})
	}
	
	
}
object generador{
	method generarAutoRojo(){
		var auto = new Auto(position=carril.aleatorio(),image="auto.png")
		game.addVisual(auto)
		auto.movimiento()	
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
	}
	
	method generarAccidente(){
		const accidente = new Accidente(position=carril.aleatorio(),
						image="accidente.png",
						personas= new Range(start=1,end=5).anyOne())
		game.addVisual(accidente)
		accidente.movimiento()
	}

}
object carril{
	var rango = new Range(start =2, end=5)
	method aleatorio()=game.at(rango.anyOne(),6)
		
	
}
