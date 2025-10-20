import Foundation

func agregarContacto(agenda contactos: inout [Contacto]) -> Void{
    let nombre = pedirNombre()
    let telefono = pedirTelefono()
    let email = pedirEmail()

    let id = obtenerUltimoId(agenda: contactos)

    let nuevoContacto = Contacto(nombre:nombre, telefono:telefono, email:email, id:id+1)
    contactos.append(nuevoContacto)
}

func actualizarContacto(agenda contactos: inout [Contacto]) -> Void{
    listadoOpcional(agenda:contactos)
    let tipoDato = ["nombre", "telefono", "email"]

    let id = pedirIdentificador(agenda:contactos, "actualizar")

    for tipo in tipoDato {
        if(preguntarModificarDato(tipo)) {
            switch tipo {
            case "nombre":
                let nombre = pedirNombre()
                contactos[id-1].nombre = nombre

            case "telefono":
                let telefono = pedirTelefono()
                contactos[id-1].telefono = telefono

            case "email":
                let email = pedirEmail()
                contactos[id-1].email = email
                
            default: 
                print("Ese parámetro de contacto no existe.")
            }
        }
    }
}

func listarAgenda(agenda contactos: [Contacto]) -> Void{
    for contacto in contactos {
        print(contacto.nombre)

        if let emailTemp = contacto.email{
            print("\tTeléfono \(contacto.telefono)", "Email: \(emailTemp)", "id: \(contacto.id)", separator:" - ")
        } else {
            print("\tTeléfono: \(contacto.telefono)", "id: \(contacto.id)", separator:" - ")
        }
    }
}

func eliminarContacto(agenda contactos: inout [Contacto]) -> Void {
    listadoOpcional(agenda:contactos)

    let id = pedirIdentificador(agenda: contactos, "eliminar")

    let arrayContactoSolo: [Contacto] = [contactos[id-1]]
    print("¿Seguro que quieres eliminar el siguiente contacto?: ")
    listarAgenda(agenda: arrayContactoSolo)
    print("(S/N): ", terminator:"")
    let respuesta = leerEntrada().lowercased()

    if(respuesta == "s"){
        contactos.remove(at:id - 1)
        actualizarIndicesEliminar(agenda: &contactos, id - 1)
    }
}

func ayuda(){
    print("""
        Bienvenido al panel de ayuda de tus Contactos-CLI, a continuación se listarán los posibles comandos: 
        \t-add: agrega un nuevo contacto, el nombre y el teléfono son OBLIGATORIOS.
        \t-update [id]: actualiza el contacto asignado al id.
        \t-list | l: lista todos los contactos guardados en la agenda.
        \t-remove [id] | rm [id]: elimina el contacto asignado al id.
        \t-help | h: para obtener ayuda.
        \t-quit | q: para salir del programa (no pasa nada, tus datos quedarán guardados).
    """)
}