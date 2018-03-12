//
//  Resultados.swift
//  LibraryApp
//
//  Created by Alejandro on 04/02/18.
//  Copyright © 2018 Alejandro. All rights reserved.
//

import UIKit
import CoreData
class Resultados: UIViewController {

//    var contexto : NSManagedObjectContext? = nil
    var libro:[Libros]? = nil
    @IBOutlet weak var codigoIsbn: UITextField!
    @IBOutlet weak var imag: UIImageView!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var isbn: UILabel!
    @IBOutlet weak var nombreDeLibro: UILabel!
    var codigo = String()
    var nombreLibro = String()
    var autorLibro = String()
    var imagenLibro = UIImage()
    var anterior : TVC!
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
    

    @IBAction func buscar(_ sender: Any)
    {
        codigo = codigoIsbn.text!
//        self.contexto = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
//        let nuevaSeccionEntidad = NSEntityDescription.insertNewObject(forEntityName: "Libros", into: self.contexto!)
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
                let json = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
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
           
            isbn.text = codigoIsbn.text!
//            nuevaSeccionEntidad.setValue(codigoIsbn.text!, forKey: "isbn")
//            nuevaSeccionEntidad.setValue(autorLibro, forKey: "autor")
              nombreDeLibro.text = nombreLibro
//            nuevaSeccionEntidad.setValue(nombreLibro, forKey: "nombre")
              imag.image = imagenLibro
//            nuevaSeccionEntidad.setValue(UIImagePNGRepresentation(imagenLibro), forKey: "portada")
            CoreDataHandler.saveObject(nombre: nombreLibro, autor: autorLibro, isbn: isbn.text!, portada: UIImagePNGRepresentation(imagenLibro) as! NSData)
            autor.text = autorLibro
           
            
          }
//        do
//        {
//            try self.contexto?.save()
//        }
//        catch
//        {
//
//        }
        
        let newIndexPath = IndexPath(row: anterior.libros.count, section: 0)
        anterior.libros.append([nombreLibro,isbn.text!])
        anterior.tableView.insertRows(at: [newIndexPath], with: .automatic)
       
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
//        let newIndexPath = IndexPath(row: cc.libros.count, section: 0)
//        cc.libros.append([nombreLibro,isbn.text!])
//        cc.tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

