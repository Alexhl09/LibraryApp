//
//  TVC.swift
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

class TVC: UITableViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var libroABuscar: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var nombre = [ControlLibro]()
    var libro: [Libros]? = nil
    var codigo = ""
//    var contexto  : NSManagedObjectContext? = nil

 var libros : Array<Array<String>> = Array<Array<String>>()
  
    override func viewWillAppear(_ animated: Bool) {
//        for libro in libros
//        {
////            print(libro)
//        }
        
        for li in libros
        {
            for i in li
            {
                libro?.append(CoreDataHandler.fetchObject(isbn: i)!)
            }
        }
        activity.isHidden = true
        activity.stopAnimating()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.isHidden = true
        self.title = "Libros Buscados"
//        self.contexto = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
      
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
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activity.startAnimating()
        activity.isHidden = false
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
        if(segue.identifier! == "resultado")
        {
        let destination = segue.destination as! Resultados
        destination.anterior = self
        }
        else
        {
            activity.isHidden = false
            activity.startAnimating()
            let cc = segue.destination as! ControlLibro
            let ip = self.tableView.indexPathForSelectedRow
            cc.codigo = self.libros[(ip?.row)!][1]
        }
//

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
   

    
}

