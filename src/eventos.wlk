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
	var nivel = 1  
	var rangoCaja = new Range(start=1,end=10)
	method generarAutoRojo(){
		var auto = new Auto(position=carril.aleatorio(),image="auto.png")
		game.addVisual(auto)
		auto.movimiento()	
	}
	
	method generarAutos(){       // hay que hacer que empiece poniendo uno y vaya aumentando hasta 3
		self.generarAutoRojo()
		self.generarAutoRojo()
		if(rangoCaja.anyOne()==9) self.generarCajaMisteriosa() /* 1/10 probabilidades de que sea una caja */
		else self.generarAutoRojo()
	}
	
	method generarArbol(){
		var arbol = new Arbol(position=game.at(0,6))
		game.addVisual(arbol)
		arbol.movimiento()
	}
	method generarCajaMisteriosa(){
		var caja = new CajaMisteriosa(position=carril.aleatorio())
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
	var carril
	method aleatorio(){
		carril = game.at(rango.anyOne(),6)
		if(!game.getObjectsIn(carril).isEmpty()){
			carril = self.aleatorio()
		}
		return carril
	} 
	
	
		
	
}
