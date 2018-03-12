//
//  CoreDataHandler.swift
//  LibraryApp
//
//  Created by Alejandro on 11/03/18.
//  Copyright © 2018 Alejandro. All rights reserved.
//

import UIKit
import CoreData
class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        }
    class func saveObject(nombre :String, autor : String, isbn : String, portada : NSData ) -> Bool
    {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Libros", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(nombre, forKey: "nombre")
        manageObject.setValue(autor, forKey: "autor")
        manageObject.setValue(isbn, forKey: "isbn")
        manageObject.setValue(portada, forKey: "portada")
        
        do
        {
            try context.save()
            return true
        }
        catch
        {
            return false
        }
        
    }
    
    class func fetchObject(isbn : String)-> Libros?
    {

        let context = getContext()
        var libro : [Libros]? = nil
        var li : Libros? = nil
        do
        {
            libro = try context.fetch(Libros.fetchRequest())
            for i in libro!
            {
                if i.isbn == isbn
                {
                    return i
                }
            }
            return li
        }
        catch
        {
            return li
        }
    }
    
}

