import personajes.*
import wollok.game.*
import config.*
object evento{
	method inicio(){
			nivel1.nivel()
			game.onTick(1000,"puntaje", {score.aumentarPuntaje(1)})
			game.addVisual(score)
			score.puntaje(0)
			game.removeVisual(inicioDeJuego)
		
	}
	method gameOver(){
		game.clear()
		game.addVisual(cartel)
		game.schedule(4000,{=> 
			config.restart()
		})
	}
	
}

class Nivel{
	var duracion
	var tick
	var genNivel
	method nivel(){
		game.onTick(tick,"generarAuto",{=>generador.generarObstaculos()})
		game.onTick(tick,"generarArbol",{=> generador.generarArbol()})
		generador.nivel(genNivel)
		game.schedule(duracion,{self.pasarDeNivel()})
	}
	method pasarDeNivel(){
		game.removeTickEvent("generarAuto")
		game.removeTickEvent("generarArbol")
		self.siguiente().nivel()
	}
	method siguiente()
}

object nivel1 inherits Nivel(tick = 2000,duracion=10000,genNivel=0){
	override method siguiente() = nivel2
}

object nivel2 inherits Nivel(tick = 1500,duracion=20000,genNivel=1){
	override method siguiente() = nivel3
}

object nivel3 inherits Nivel(tick = 1500,duracion=20000,genNivel=2){
	override method siguiente() = nivel4
}

object nivel4 inherits Nivel(tick = 1300,duracion=20000,genNivel=2){
	override method siguiente() = nivel5
}

object nivel5 inherits Nivel(tick = 1000,duracion=20000,genNivel=2){
	override method pasarDeNivel(){}
	override method siguiente(){}
}


object generador{
	var property nivel = 0  
	var rangoCaja = new Range(start=1,end=10)
	method generarAutoRojo(){
		var auto = new Auto(position=carril.aleatorio(),image="auto.png")
		game.addVisual(auto)
		auto.movimiento()	
	}
	
	method generarObstaculos(){     
		nivel.times{n=>self.generarAutoRojo()}
		if(rangoCaja.anyOne() >=8) self.generarCajaMisteriosa() /* 1/10 probabilidades de que sea una caja */
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
