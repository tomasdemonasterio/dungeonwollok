import wollok.game.*

const espadaOxidada = new Item(poder = 10, nombre = "Espada Oxidada")
const espadaAfilada = new Item(poder = 15, nombre = "Espada Afilada")
const escudo = new Item(poder = 10, nombre = "Escudo")
const yelmo = new Item(poder = 30, nombre = "Yelmo")
const anilloDePoder = new Item(poder = 1000, nombre = "Anillo de Poder")
const hacha = new Item(poder = 20, nombre = "Hacha")

const muro1 = new Elemento(position = game.at(6,4), image = "wall.png")
const muro2 = new Elemento(position = game.at(6,3), image = "wall.png")
const muro3 = new Elemento(position = game.at(6,2), image = "wall.png")
const muro4 = new Elemento(position = game.at(5,2), image = "wall.png")
const muro5 = new Elemento(position = game.at(4,2), image = "wall.png")
const muro6 = new Elemento(position = game.at(3,2), image = "wall.png")
const muro7 = new Elemento(position = game.at(3,3), image = "wall.png")
const muro8 = new Elemento(position = game.at(3,4), image = "wall.png")
const muro9 = new Elemento(position = game.at(3,5), image = "wall.png")
const muro10 = new Elemento(position = game.at(2,5), image = "wall.png")
const muro11 = new Elemento(position = game.at(1,5), image = "wall.png")
const muro12 = new Elemento(position = game.at(7,8), image = "wall.png")
const muro13 = new Elemento(position = game.at(9,6), image = "wall.png")
const muro14 = new Elemento(position = game.at(8,6), image = "wall.png")
const muro15 = new Elemento(position = game.at(7,6), image = "wall.png")
const muro16 = new Elemento(position = game.at(7,7), image = "wall.png")
const muro17 = new Elemento(position = game.at(3,6), image = "wall.png")
const muro18 = new Elemento(position = game.at(3,8), image = "wall.png")
const muro19 = new Elemento(position = game.at(3,9), image = "wall.png")

const victoria = new Visual(position = game.at(2,5), image = "victory.png")
const gameOver = new Visual(position = game.at(2,5), image = "gameover.png")


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
		game.whenCollideDo(boss, {unObjeto => if(unObjeto.esJugador()) unObjeto.lucharContra(boss)})
		game.whenCollideDo(fire1, {unObjeto => if(unObjeto.esJugador()) self.gameOver()})
		game.whenCollideDo(fire2, {unObjeto => if(unObjeto.esJugador()) self.gameOver()})
		game.whenCollideDo(fire3, {unObjeto => if(unObjeto.esJugador()) self.gameOver()})
		game.whenCollideDo(fire4, {unObjeto => if(unObjeto.esJugador()) self.gameOver()})
		game.onTick(90, "animar", {fire1.animar()})
		game.onTick(90, "animar", {fire2.animar()})
		game.onTick(90, "animar", {fire3.animar()})
		game.onTick(90, "animar", {fire4.animar()})
		game.onTick(500, "movimiento", {fire1.move()})
		game.onTick(300, "movimiento", {fire2.move()})
		game.onTick(700, "movimiento", {fire3.move()})
		game.onTick(500, "movimiento", {fire4.move()})
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
		game.addVisual(fire1)
		game.addVisual(fire2)
		game.addVisual(fire3)
		game.addVisual(fire4)
		game.addVisual(cofre1)
		game.addVisual(cofre2)
		game.addVisual(cofre3)
		game.addVisual(cofre4)
	}
	
	method generarMuros() {
		game.addVisual(muro1)
		game.addVisual(muro2)
		game.addVisual(muro3)
		game.addVisual(muro4)
		game.addVisual(muro5)
		game.addVisual(muro6)
		game.addVisual(muro7)
		game.addVisual(muro8)
		game.addVisual(muro9)
		game.addVisual(muro10)
		game.addVisual(muro11)
		game.addVisual(muro12)
		game.addVisual(muro13)
		game.addVisual(muro14)
		game.addVisual(muro15)
		game.addVisual(muro16)
		game.addVisual(muro17)
		game.addVisual(muro18)
		game.addVisual(muro19)
	}
	
	method generarLimites() {
  		const ancho = game.width() - 1
   		const alto = game.height() - 1
   		const paredes = []
		
   		(0 .. ancho).forEach{num => paredes.add(new Elemento(position = game.at(num, alto), image = "border.png"))}
   		(0 .. ancho).forEach{num => paredes.add(new Elemento(position = game.at(num, 0), image = "border.png"))}
   		(0 .. alto).forEach{ num => paredes.add(new Elemento(position = game.at(ancho, num), image = "border.png"))}
   		(0 .. alto).forEach{ num => paredes.add(new Elemento(position = game.at(0, num), image = "border.png"))}
    
   		paredes.forEach {pared => game.addVisual(pared)}
}
}



class Visual {
	var property position = game.at(0,0)
	var property image = ""
	var property imageGIF = ""
	var property posicionAnimacion = 1
	var property cantidadFrames = 1
	
	method animar() {
		if(posicionAnimacion != cantidadFrames){
			image = imageGIF+posicionAnimacion+".png"
			posicionAnimacion += 1
		}
		else{
			image = imageGIF+posicionAnimacion+".png"
			posicionAnimacion = 1
		}
	}
}

class Elemento inherits Visual {
	method esAtravesable() = false
	method esJugador() = false
	method esCofre() = false
}

object jugador inherits Elemento(position = game.at(1,9), image = "character.png"){
	var property equipamiento = []
	
	override method esJugador() = true
	method poderDeCombate() = equipamiento.sum{unObjeto => unObjeto.poder()}
	method abrirCofre() {
		if(game.colliders(self).any{unObjeto => unObjeto.esCofre()})
			self.buscarCofre(game.colliders(self)).serAbiertoPor(self)
	}
	
	method buscarCofre(objetos) = objetos.find{unObjeto => unObjeto.esCofre()}
	
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

class Enemigo inherits Elemento{
	var property retornar = false
	
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
	override method esAtravesable() = true
}

object fire1 inherits Fire(position = game.at(1,7), cantidadFrames = 10, imageGIF = "fire/fire") {
	method move() {
		self.patrullarADerecha(game.at(1,7), game.at(6,7))
	}
}

object fire2 inherits Fire(position = game.at(9,5), cantidadFrames = 10, imageGIF = "fire/fire") {
	method move() {
		self.patrullarAIzquierda(game.at(9,5), game.at(4,5))
	}
}

object fire3 inherits Fire(position = game.at(1,1), cantidadFrames = 10, imageGIF = "fire/fire") {
	method move() {
		self.patrullarADerecha(game.at(1,1), game.at(6,1))
	}
}

object fire4 inherits Fire(position = game.at(9,7), cantidadFrames = 10, imageGIF = "fire/fire") {
	method move() {
		self.ciclo(game.at(9,7), game.at(8,8), game.at(9,8))
	}
}

object boss inherits Enemigo(position = game.at(5,9), image = "boss.png") {
	var property poderDeCombate = 40
	
	override method esAtravesable() = true
	method morir() {
		juego.victoria()
	}
	method move() {
	}
}

class Cofre inherits Elemento {
	var property abierto = false
	var property items = [espadaOxidada, espadaAfilada, escudo, yelmo, anilloDePoder, hacha]
	
	override method esCofre() = true
	override method esAtravesable() = true
	
	method serAbiertoPor(alguien) {
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

object cofre1 inherits Cofre(position = game.at(5,3), image = "chest-closed.png"){
}
object cofre2 inherits Cofre(position = game.at(2,6), image = "chest-closed.png"){
}
object cofre3 inherits Cofre(position = game.at(8,7), image = "chest-closed.png"){
}
object cofre4 inherits Cofre(position = game.at(1,3), image = "chest-closed.png"){
}

class Item {
	var property poder
	var property nombre
}