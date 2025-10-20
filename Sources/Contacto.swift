struct Contacto: Codable {
    var nombre: String
    var telefono: String
    var email: String?
    var id : Int

    mutating func actualizarNombre(_ nombre: String){
        self.nombre = nombre
    }

    mutating func actualizarTelefono(_ telefono: String){
        self.telefono = telefono
    }

    mutating func actualizarEmail(_ email: String){
        self.email = email
    }
}