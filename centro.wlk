object centroDeKinesiologia {
    const pacientes = []
    const aparatos = []

    method agregarPacientes(unaLista) {
      pacientes.addAll(unaLista)
    }
    method agregarAparatos(unaLista) {
      aparatos.addAll(unaLista)
    }

    method colorAparatos() = aparatos.map({a=>a.color()}).asSet()

    method pacientesMenoresA(unValor) = pacientes.filter({p=>p.edad()<unValor})

    method cantNoPuedenCumplirRutina() = pacientes.count({p=>not p.puedeHacerRutina()})

    method estaEnOptimasCondiciones() = aparatos.all{a=>not a.necesitaMantenimiento()}

    method cantNecesitanMantenimiento() = self.aparatosQueNecesitanMantenimiento().size()

    method esComplicado() = self.cantNecesitanMantenimiento() >= aparatos.size().div(2)

    method aparatosQueNecesitanMantenimiento() = aparatos.filter({a=>a.necesitaMantenimiento()})

    method visitaDeTecnico() {
      self.aparatosQueNecesitanMantenimiento().forEach({a=>a.recibirMantenimiento()})
    }
}