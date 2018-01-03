//
//  TVC.swift
//  LibraryApp
//
//  Created by Alejandro on 20/12/17.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit
/*
 ISBN:
 9788498382549
 9788439703853
 9782277228943
 */

class TVC: UITableViewController {
    @IBOutlet weak var libroABuscar: UITextField!
     var nombre = [ControlLibro]()
    
    
    
    @IBAction func Add(_ sender: Any) {
        var nombreee = String()
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urls + libroABuscar.text!)
        let datos = NSData(contentsOf: url! as URL)
        
        if (datos == nil || libroABuscar.text! == "" )
             {
                showAlertMessage(title: "Aviso", message: "No se ha podido conectar al servicio. Favor de reintentar más tarde")
                return
            }
        
            do
            {
                /*
                 do{
                 let jsonResponse = try JSONSerialization.jsonObject(with: contentData! as Data, options: []) as! NSDictionary
                */
                let json = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                  let jsonResponse = try JSONSerialization.jsonObject(with: datos! as Data, options: []) as! NSDictionary
                if(jsonResponse.count == 0 )
                {
                    showAlertMessage(title: "Aviso", message: "No se ha encontrado un libro con el ISBN proporcionado.")
                    return
                }
                let dico1 = json as! NSDictionary
                let dico2 = dico1["ISBN:\(libroABuscar.text!)"] as! NSDictionary
                nombreee = dico2["title"] as! NSString as String
                
            }
            catch _ {
                
            }
        let newIndexPath = IndexPath(row: libros.count, section: 0)
        self.libros.append([nombreee,libroABuscar.text!])
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
      
    }
    private var libros : Array<Array<String>> = Array<Array<String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Libros Buscados"
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.libros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       
        
        cell.textLabel?.text = self.libros[indexPath.row][0]
        // Configure the cell...

        return cell
    }
    func showAlertMessage(title: String, message:String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let cc = segue.destination as! ControlLibro
        let ip = self.tableView.indexPathForSelectedRow
        cc.codigo = self.libros[(ip?.row)!][1]
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
