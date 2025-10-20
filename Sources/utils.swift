import Foundation

func leerEntrada() -> String {
    var entrada: String? = nil
    var leidoCorrectamente = false
    repeat {
        if let linea = readLine() {
            leidoCorrectamente = true
            entrada = linea
        }
    } while(!leidoCorrectamente)

    return entrada!
}

func solicitarDato(_ dato: String){
    print("\t\(dato): ", terminator:"")
}

func leerDatos() throws -> [Contacto] {
    let url = URL(fileURLWithPath: "agenda.json")
    let data = try Data(contentsOf: url)
    
    var contactos: [Contacto] = []
    if data.count != 0 {
        contactos = try JSONDecoder().decode([Contacto].self, from: data)
    }

    return contactos
}

func guardarDatos(_ contactos : [Contacto]) throws -> Void {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

    let data = try encoder.encode(contactos)
    let url = URL(fileURLWithPath: "agenda.json")
    try data.write(to: url)
}

func existeFichero(fichero ruta: String) -> Bool{
    FileManager.default.fileExists(atPath: ruta)
}

func obtenerUltimoId(agenda contactos: [Contacto]) -> Int{
    if contactos.isEmpty {
        return 0
    } else {
        return contactos[contactos.count - 1].id
    }
}


func validarNombre(_ nombre: String) -> Bool{
    nombre.count <= 16 && !nombre.isEmpty
}

func pedirNombre() -> String {
    var nombre: String? = nil
    repeat{
        solicitarDato("Nombre")
        nombre = leerEntrada()
    } while(!validarNombre(nombre!))
    
    return nombre!
}

func validarTelefono(_ telefono: String) -> Bool{
    telefono.count == 9 && !telefono.isEmpty
}

func pedirTelefono() -> String {
    var telefono: String? = nil
    repeat{
        solicitarDato("Teléfono")
        telefono = leerEntrada()
    } while(!validarTelefono(telefono!))
    
    return telefono!
}

func validarEmail(_ email: String) -> Bool{
    email.contains("@gmail.com") || email.isEmpty
}

func pedirEmail() -> String? {
    var email: String? = nil
    repeat{
        solicitarDato("Email")
        email = leerEntrada()
    } while(!validarEmail(email!))
    
    if email!.isEmpty {
        return nil
    } else {
        return email!
    }
}

func listadoOpcional(agenda contactos: [Contacto]) -> Void{
    var listar: String? = nil
    repeat {
        print("¿Quiere listar primero todos los contactos?(S/N): ", terminator:"")
        listar = leerEntrada().lowercased()

        if listar == "s" { listarAgenda(agenda:contactos) }
    } while(listar! != "n" && listar! != "s")
}

func actualizarIndicesEliminar(agenda contactos: inout [Contacto], _ index: Int) -> Void{
    for i in index..<contactos.count{
        contactos[i].id = contactos[i].id - 1
    }
}

func pedirIdentificador(agenda contactos: [Contacto], _ tipoOp: String) -> Int {
    var id: Int? = nil
    repeat {
        print("Escribe el identificador (id) del contacto que quieras \(tipoOp): ", terminator:"")
        id = Int(leerEntrada())
    } while(id != nil && id! > obtenerUltimoId(agenda: contactos))

    return id!
}

func preguntarModificarDato(_ tipo: String) -> Bool{
    var modificar: String? = nil
    repeat {
        print("¿Quieres modificar el dato \(tipo)?(S/N): ", terminator:"")
        modificar = leerEntrada().lowercased()
    } while(modificar! != "n" && modificar! != "s")

    if modificar == "s" {return true}

    return false
}