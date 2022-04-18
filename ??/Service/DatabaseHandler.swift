//
//  DatabaseHandler.swift
//  
//
//  Created by Роман on 16.04.2022.
//

import Foundation
import UIKit
import CoreData

class DatabaseHandler {
    
    static let shared = DatabaseHandler()
    
    func saveImage(img: UIImage?) {
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let photoObject = NSEntityDescription.insertNewObject(forEntityName: "ShooterdImages", into: context) as! ShooterdImages
        photoObject.img = img?.jpegData(compressionQuality: 1) as? Data
        
        do {
            try context.save()
            print("Data has been saved")
        } catch {
            print("Error occured while saving data")
        }
    }
    
    func retrieveData() -> [ShooterdImages] {
        var photos = [ShooterdImages]()
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            photos = try (context.fetch(ShooterdImages.fetchRequest()))
            print("photos have been fetched")
        } catch {
            print("Error while fetching data")
        }
        
        return photos
    }
    
}
