import personajes.*
import wollok.game.*
object evento{
	var flag = 0
	method inicio(){
		if(flag==0){
			nivel1.nivel()
			flag = 1
			game.onTick(1000,"puntaje", {score.aumentarPuntaje(1)})
			game.addVisual(score)
			game.addVisual(capacidad)
			game.onTick(15000,"apareceHospital",{hospital.aparecer()})
			game.removeVisual(inicioDeJuego)
		}
	}
	method gameOver(){
		game.clear()
		game.addVisual(cartel)
		game.schedule(4000,{=> game.stop()})
	}
	
}
object nivel1{
	method nivel(){
		game.onTick(2000,"generarAuto",{=>generador.generarObstaculos()})
		game.onTick(2000,"generarArbol",{=> generador.generarArbol()})
		generador.nivel(0)
		game.schedule(10000,{self.pasarDeNivel()})
	}
	method pasarDeNivel(){
		game.removeTickEvent("generarAuto")
		game.removeTickEvent("generarArbol")
		nivel2.nivel()
	}
}
object nivel2{
	method nivel(){
		game.onTick(1500,"generarAuto",{=>generador.generarObstaculos()})
		game.onTick(1500,"generarArbol",{=> generador.generarArbol()})
		generador.nivel(1)
		game.schedule(20000,{self.pasarDeNivel()})
	}
	method pasarDeNivel(){
		game.removeTickEvent("generarAuto")
		game.removeTickEvent("generarArbol")
		nivel3.nivel()
	}
}
object nivel3{
	method nivel(){
		game.onTick(1500,"generarAuto",{=>generador.generarObstaculos()})
		game.onTick(1500,"generarArbol",{=> generador.generarArbol()})
		generador.nivel(2)
		game.schedule(20000,{self.pasarDeNivel()})
	}
	method pasarDeNivel(){
		game.removeTickEvent("generarAuto")
		game.removeTickEvent("generarArbol")
		nivel4.nivel()
	}
}
object nivel4{
	method nivel(){
		game.onTick(1300,"generarAuto",{=>generador.generarObstaculos()})
		game.onTick(1300,"generarArbol",{=> generador.generarArbol()})
		game.schedule(20000,{self.pasarDeNivel()})
	}
	method pasarDeNivel(){
		game.removeTickEvent("generarAuto")
		game.removeTickEvent("generarArbol")
		nivel5.nivel()
	}
}
object nivel5{
	method nivel(){
		game.onTick(1000,"generarAuto",{=>generador.generarObstaculos()})
		game.onTick(1000,"generarArbol",{=> generador.generarArbol()})
	}

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
