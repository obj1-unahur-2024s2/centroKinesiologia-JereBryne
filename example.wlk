class Paciente {
  var edad
  var fortalezaMuscular
  var nivelDeDolor
  const rutina = []

  method edad() = edad
  method fortalezaMuscular() = fortalezaMuscular  
  method nivelDeDolor() = nivelDeDolor
  method cumplirAnios() {
    edad +=1
  }
  method cargarRutina(unaLista) {
    rutina.clear()
    rutina.addAll(unaLista)
  }

  method disminuirDolor(unValor) {
    nivelDeDolor = 0.max(nivelDeDolor-unValor)
  }
  method aumentarFortaleza(unValor) {
    fortalezaMuscular += unValor
  }
  method puedeUsar(unAparato) = unAparato.puedeSerUsado(self)
  method usarAparato(unAparato) {
    if (self.puedeUsar(unAparato)){
      unAparato.consecuencia(self)
    }
  }
   method puedeHacerRutina() = rutina.all({a=>self.puedeUsar(a)})
  
  method realizarRutina() {
    if (self.puedeHacerRutina()){
      rutina.forEach({a=>self.usarAparato(a)})
    }
  }
}

class Resistente inherits Paciente {
  override method realizarRutina() {
    super()
    self.aumentarFortaleza(
      rutina.count({a=>self.puedeUsar(a)})
    )
  }
}

class Caprichoso inherits Paciente {
  override method puedeHacerRutina() = self.hayAlgunAparatoRojo() and super()

  override method realizarRutina() {
    super()
    super()
  }
  method hayAlgunAparatoRojo() = rutina.any({a=>a.color()=="rojo"})
}

class RapidaRecuperacion inherits Paciente {
  override method realizarRutina() {
    super()
    self.disminuirDolor(disminucionDolor.valor())
  }
}

object disminucionDolor { //Al modificar este se modificara el valor en TODOS 
  var property valor = 3  // los pacientes de recuperacion rapida.
}

class Aparato {
  method consecuencia(unPaciente)
  method puedeSerUsado(unPaciente)
  const property color = "blanco"
  method recibirMantenimiento() {}
  method necesitaMantenimiento() = false 
}

class Magneto inherits Aparato {
  var magneto = 800
  override method consecuencia(unPaciente) {
    unPaciente.disminuirDolor(unPaciente.nivelDeDolor()*0.1)
    magneto = 0.ma(magneto-1)
  }
  override method puedeSerUsado(unPaciente) = true
  override method recibirMantenimiento(){
    magneto = 800.min(magneto+500)
  }
  override method necesitaMantenimiento() = magneto < 100
}

class Bici inherits Aparato {
  var tornillos = 0
  var aceite = 0
  override method consecuencia(unPaciente) {
    self.uso(unPaciente)
    unPaciente.disminuirDolor(4)
    unPaciente.aumentarFortaleza(3)
  }
  method uso(unPaciente) {
    if (unPaciente.nivelDeDolor()>=30){
      tornillos+=1
      if (unPaciente.edad().between(30, 50)){
        aceite+=1
      }
    }
  }
  override method puedeSerUsado(unPaciente) = unPaciente.edad() > 8
  override method recibirMantenimiento(){
    tornillos = 0
    aceite = 0
  }
  override method necesitaMantenimiento() = tornillos>=10 or aceite>=5 
}

class Minitramp inherits Aparato {
  override method consecuencia(unPaciente) {
    unPaciente.aumentarFortaleza(unPaciente.edad()*0.1)
  }
  override method puedeSerUsado(unPaciente) = unPaciente.nivelDeDolor() < 20
}

