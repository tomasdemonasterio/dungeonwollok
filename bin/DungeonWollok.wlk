import wollok.game.*

const espadaOxidada = new Item(poder = 10, nombre = "Espada Oxidada")
const espadaAfilada = new Item(poder = 15, nombre = "Espada Afilada")
const escudo = new Item(poder = 10, nombre = "Escudo")
const yelmo = new Item(poder = 30, nombre = "Yelmo")
const anilloDePoder = new Item(poder = 1000, nombre = "Anillo de Poder")
const hacha = new Item(poder = 20, nombre = "Hacha")

const muros = [muro1, muro2, muro3, muro4, muro5, muro6, muro7, muro8, muro9, muro10, muro11, muro12, muro13, muro14, muro15, muro16, muro17, muro18, muro19]
const muro1 = new Visual(position = game.at(6,4), image = "wall.png")
const muro2 = new Visual(position = game.at(6,3), image = "wall.png")
const muro3 = new Visual(position = game.at(6,2), image = "wall.png")
const muro4 = new Visual(position = game.at(5,2), image = "wall.png")
const muro5 = new Visual(position = game.at(4,2), image = "wall.png")
const muro6 = new Visual(position = game.at(3,2), image = "wall.png")
const muro7 = new Visual(position = game.at(3,3), image = "wall.png")
const muro8 = new Visual(position = game.at(3,4), image = "wall.png")
const muro9 = new Visual(position = game.at(3,5), image = "wall.png")
const muro10 = new Visual(position = game.at(2,5), image = "wall.png")
const muro11 = new Visual(position = game.at(1,5), image = "wall.png")
const muro12 = new Visual(position = game.at(7,8), image = "wall.png")
const muro13 = new Visual(position = game.at(9,6), image = "wall.png")
const muro14 = new Visual(position = game.at(8,6), image = "wall.png")
const muro15 = new Visual(position = game.at(7,6), image = "wall.png")
const muro16 = new Visual(position = game.at(7,7), image = "wall.png")
const muro17 = new Visual(position = game.at(3,6), image = "wall.png")
const muro18 = new Visual(position = game.at(3,8), image = "wall.png")
const muro19 = new Visual(position = game.at(3,9), image = "wall.png")

const victoria = new Visual(position = game.at(2,5), image = "victory.png")
const gameOver = new Visual(position = game.at(2,5), image = "gameover.png")

const fires = [fire1, fire2, fire3, fire4]
const fire1 = new Fire(position = game.at(1,7), positionInicio = game.at(1,7), positionDestino = game.at(6,7), cantidadFrames = 10, image = "fire/fire", velocidad = 300) 
const fire3 = new Fire(position = game.at(1,1), positionInicio = game.at(1,1), positionDestino = game.at(6,1), cantidadFrames = 10, image = "fire/fire",velocidad = 500) 
const fire2 = new FireIzq(position = game.at(9,5), positionInicio = game.at(9,5), positionDestino = game.at(4,5), cantidadFrames = 10, image = "fire/fire",velocidad = 700) 
const fire4 = new FireCiclo(position = game.at(9,7), positionInicio = game.at(9,7), tercerPos = game.at(8,8), positionDestino = game.at(9,8), cantidadFrames = 10, image = "fire/fire", velocidad = 500)

const cofres = [cofre1, cofre2, cofre3, cofre4]
const cofre1 = new Cofre(position = game.at(5,3), image = "chest-closed.png")
const cofre2 = new Cofre(position = game.at(2,6), image = "chest-closed.png")
const cofre3 = new Cofre(position = game.at(8,7), image = "chest-closed.png")
const cofre4 = new Cofre(position = game.at(1,3), image = "chest-closed.png")

object juego {
	var property width = 11
	var property height = 11
	var property title = "Dungeon Wollok"
	var property background = "background.png"
	
	method iniciar() {
		self.estructura()
		mapa.generarVisual()
		self.controles()
		self.eventos()
		game.start()
	}
	
	method gameOver(){
	game.clear()
		game.addVisual(gameOver)
	}
	
	method victoria() {
		game.clear()
		game.addVisual(victoria)
	}
	
	method controles() {
		keyboard.e().onPressDo{jugador.abrirCofre()}
		keyboard.enter().onPressDo{game.stop()}
		keyboard.up().onPressDo {jugador.mover(jugador.position().up(1)) }
  		keyboard.down().onPressDo {jugador.mover(jugador.position().down(1)) }
  		keyboard.left().onPressDo {jugador.mover(jugador.position().left(1)) }
  		keyboard.right().onPressDo {jugador.mover(jugador.position().right(1)) }
	}
	
	method eventos() {
		game.whenCollideDo(boss, {unObjeto => unObjeto.lucharContra(boss)})
		fires.forEach{fire => 
			game.whenCollideDo(fire, {unObjeto => if(unObjeto.esJugador()) self.gameOver()})
			game.onTick(90, "animar", {fire.animar()})
			game.onTick(fire.velocidad(), "movimiento", {fire.move()})
			
			}
		game.say(jugador, "Estoy listo!")
	}
	
	method estructura() {
		game.width(width)
		game.height(height)
		game.title(title)
		game.boardGround(background)
	}
}

object mapa {
	method generarVisual() {
		self.generarElementos()
		self.generarMuros()
		self.generarLimites()
	}
	
	method generarElementos() {
		game.addVisual(jugador)
		game.addVisual(boss)
		fires.forEach{unObjeto => game.addVisual(unObjeto)}
		cofres.forEach{unObjeto => game.addVisual(unObjeto)}
	}
	
	method generarMuros() {
		muros.forEach{unObjeto => game.addVisual(unObjeto)}
	}
	
	method generarLimites() {
  		const ancho = game.width() - 1
   		const alto = game.height() - 1
   		const paredes = []
		
   		(0 .. ancho).forEach{num => paredes.add(new Visual(position = game.at(num, alto), image = "border.png"))}
   		(0 .. ancho).forEach{num => paredes.add(new Visual(position = game.at(num, 0), image = "border.png"))}
   		(0 .. alto).forEach{ num => paredes.add(new Visual(position = game.at(ancho, num), image = "border.png"))}
   		(0 .. alto).forEach{ num => paredes.add(new Visual(position = game.at(0, num), image = "border.png"))}
    
   		paredes.forEach {pared => game.addVisual(pared)}
   		}
}



class Visual {
	var property position = game.at(0,0)
	var property image 
	method esAtravesable() = false
	method serAbiertoPor(x) {}	
	method esJugador() = false
}

class VisualAnima inherits Visual{
	var property posicionAnimacion = 1
	var property cantidadFrames = 1
	
	method animar() {
		if(posicionAnimacion != cantidadFrames){
			posicionAnimacion += 1
		}
		else{
			posicionAnimacion = 1
		}
	}
	override method image(){
		return image+posicionAnimacion+".png"
	}
}

object jugador inherits Visual(position = game.at(1,9), image = "character.png"){
	var property equipamiento = []
	
	override method esJugador() = true
	method poderDeCombate() = equipamiento.sum{unObjeto => unObjeto.poder()}
	method abrirCofre() {
		game.colliders(self).forEach{unObjeto => unObjeto.serAbiertoPor(self)}
	}	
	method recibirItem(item) {
		equipamiento.add(item)
		game.say(self, "Obtuve " + item.nombre() + " con " + item.poder() + " de poder!")
	}
	
	method lucharContra(alguien) {
		if(self.poderDeCombate() >= alguien.poderDeCombate()){
			alguien.morir()
		}
		else
			juego.gameOver()
	}
	
	method mover(posicion) { 
    	if(self.puedeMoverA(posicion)) {
    		position = posicion
    	} 
    	else {
        	game.say(self, "No puedo pasar")
        }
  }
  
  method puedeMoverA(posicion) = game.getObjectsIn(posicion).all {unObjeto => unObjeto.esAtravesable()}
  
}

class Enemigo inherits VisualAnima{
	var property retornar = false
	var property velocidad = 0
	
	method patrullarADerecha(inicio, destino) {
		if((position == destino))
			retornar = true
		if(position == inicio)
			retornar = false
			
		if(!retornar){
			position = position.right(1)
		}
		else {
			position = position.left(1)
		}
	}
	
	method patrullarAIzquierda(inicio, destino) {
		if((position == destino))
			retornar = true
		if(position == inicio)
			retornar = false
			
		if(!retornar){
			position = position.left(1)
		}
		else {
			position = position.right(1)
		}
	}
	
	method ciclo(inicio, destino, intermedio) {
		if((position == destino))
			retornar = true
		if(position == inicio)
			retornar = false
		if(!retornar && position == inicio){
			position = position.up(1)
		}
		else
		if(!retornar) {
			position = position.left(1)
		}
		else
			if(position == destino) 
				position = position.right(1)
			else
				position = position.down(1)
	}
	method aleatorio(objeto) {
		const x = 0.randomUpTo(game.width()).truncate(0)
		const y = 0.randomUpTo(game.height()).truncate(0)
		objeto.position(game.at(x,y))
	}
}

class Fire inherits Enemigo {
	var property positionDestino
	var property positionInicio
	
	override method esAtravesable() = true
	method move() {
		self.patrullarADerecha(positionInicio, positionDestino)
	}
}

class FireIzq inherits Fire{
	override method move() {
		self.patrullarAIzquierda(positionInicio, positionDestino)
	}
}

class FireCiclo inherits Fire{
    var tercerPos  
	override method move() {
		self.ciclo(positionInicio, game.at(8,8), tercerPos)
	}
}

object boss inherits Enemigo(position = game.at(5,9), image = "boss.png") {
	var property poderDeCombate = 40
	
	override method image() = image
	override method esAtravesable() = true
	method morir() {
		juego.victoria()
	}
	method move() {
	}
}

class Cofre inherits Visual {
	var property abierto = false
	var property items = [espadaOxidada, espadaAfilada, escudo, yelmo, anilloDePoder, hacha]
	
	override method esAtravesable() = true
	
	override method serAbiertoPor(alguien) {
		if(!abierto){
			abierto = true
			image = "chest-open.png"
			game.sound("chest.wav").play()
			self.entregarItemA(alguien)
		}
		else
			game.say(alguien, "Ya abri el cofre")
	}
	
	method entregarItemA(alguien) {
		alguien.recibirItem(items.anyOne())
	}
}

class Item {
	var property poder
	var property nombre
}