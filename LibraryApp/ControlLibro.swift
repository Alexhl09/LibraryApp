//
//  ControlLibro.swift
//  LibraryApp
//
//  Created by Alejandro on 20/12/17.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit
import CoreData
/*
 ISBN:
 9788498382549
 9788439703853
 9782277228943
 */


class ControlLibro: UIViewController {
//    var contexto : NSManagedObjectContext? = nil
    var libro: Libros? = nil
    @IBOutlet weak var imag: UIImageView!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var isbn: UILabel!
    @IBOutlet weak var nombreDeLibro: UILabel!
    var codigo = ""
    var nombreLibro = String()
    var autorLibro = String()
    var imagenLibro = UIImage()
    
    func busquedaLibro(termino : String) -> UIImage
    {
        var img = UIImage()
        let urls = "http://covers.openlibrary.org/b/isbn/" + termino + "-L.jpg"
        let url = NSURL(string: urls)
        let datos = NSData(contentsOf: url! as URL)
        if (datos != nil)
        {
            if let imagen = UIImage(data: datos! as Data)
            {
               img = imagen
            }
        }
        return img
    }
   
     
    override func viewDidLoad() {
        super.viewDidLoad()
        libro = CoreDataHandler.fetchObject(isbn: codigo)!
       
        isbn.text = libro?.isbn!
        nombreDeLibro.text = libro?.nombre!
        imag.image = UIImage(data: (libro?.portada)!)!
        autor.text = libro?.autor!
        
        
//        contexto = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext

//        let seccionEntidad = NSEntityDescription.entity(forEntityName: "Libros", in: self.contexto!)
//        let peticion = seccionEntidad?.managedObjectModel.fetchRequestTemplate(forName: "petIsbns")
//        do
//        {
//            let seccion = try self.contexto?.execute(peticion!)
//            print("\(peticion!)")
//        }
//        catch
//        {
//
//        }

//        let nuevaSeccionEntidad = NSEntityDescription.insertNewObject(forEntityName: "Libros", into: self.contexto!)
//        nuevaSeccionEntidad.setValue(codigo, forKey: "isbn")
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urls + codigo)
        let datos = NSData(contentsOf: url! as URL)
        
            if(datos == nil)
            {
                showAlertMessage(title: "Aviso", message: "No se ha podido conectar al servicio. Favor de reintentar más tarde")
                return
            }
        else
            {
            do
            {
                let json = try JSONSerialization.jsonObject(with: datos as! Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                let jsonResponse = try JSONSerialization.jsonObject(with: datos! as Data, options: []) as! NSDictionary
                if(jsonResponse.count == 0 )
                {
                    showAlertMessage(title: "Aviso", message: "No se ha encontrado un libro con el ISBN proporcionado.")
                    return
                }
                let dico1 = json as! NSDictionary
                let dico2 = dico1["ISBN:\(codigo)"] as! NSDictionary
                nombreLibro = dico2["title"] as! NSString as String
                let dico3 = dico2["authors"] as! NSArray
                let dico4 = dico3[0] as! NSDictionary
                autorLibro = dico4["name"] as! NSString as String

                imagenLibro = busquedaLibro(termino: codigo)
            }
            catch _ {
                
            }
            isbn.text = codigo
            nombreDeLibro.text = nombreLibro
            imag.image = imagenLibro
            autor.text = autorLibro
        
//                do
//                {
//                    try self.contexto?.save()
//                    print(nuevaSeccionEntidad.value(forKey: "isbn")!)
//                }
//                catch
//                {
//
//                }
//
        }
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
func showAlertMessage(title: String, message:String)
{
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
}
//    func crearImagesEntidades(imagen : UIImage)
//    {
//    
//        let imagenEntidad = NSEntityDescription.insertNewObject(forEntityName: "imagen", into: self.contexto!)
//        imagenEntidad.setValue( UIImagePNGRepresentation(imagen), forKey: "portada")
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
