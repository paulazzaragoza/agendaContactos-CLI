import Foundation

func iniciarPrograma() throws -> Void{
    print("Bienvenido a tu agenda personal de contactos!")

    if !existeFichero(fichero:"agenda.json") {
        _ = FileManager.default.createFile(atPath: "agenda.json", contents: nil, attributes: nil)
    }

    var contactos = try leerDatos()

    var fin = false
    repeat {
        print("contactos-CLI>> ", terminator:"")
        let comando = leerEntrada()

        switch comando.lowercased() {
        case "add": //hecho
            agregarContacto(agenda: &contactos)
            try guardarDatos(contactos)

        case "update":
            actualizarContacto(agenda: &contactos)
            try guardarDatos(contactos)

        case "list", "l": //hecho
            listarAgenda(agenda: contactos)

        case "remove", "rm": //hecho
            eliminarContacto(agenda: &contactos)
            try guardarDatos(contactos)

        case "help", "h": //hecho
            ayuda()

        case "quit", "q": //hecho
            fin = true
        default:
            print("Usa el comando \"help\" para obtener el listado de los posibles comandos.")
            
        }
    } while(!fin)
}

try iniciarPrograma()