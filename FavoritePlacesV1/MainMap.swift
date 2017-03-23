//
//  MainMap.swift
//  FavoritePlacesV1
//
//  Created by Katerina on 22.03.17.
//  Copyright © 2017 Katerina. All rights reserved.
//

import UIKit
import MapKit

class MainMap: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    let url = URL(string:"https://destinations.christiaanderidder.nl/destinations")!
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaces()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPlaces() {
//        let task  = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            if error != nil {
//                print(error!)
//                
//            } else {
//                
//                if let urlContent = data {
//                    self.places = self.parseJsonData(urlContent: urlContent as NSData)
//                    //                            for placeItem in self.places {
//                    //                                print("ID: \(placeItem.id)")
//                    //                                print("Name: \(placeItem.name)")
//                    //                                print("Longitude: \(placeItem.longitude)")
//                    //                                print("Latitude: \(placeItem.latitude)")
//                    //                            }
//                    self.drawMap(listOfPlaces: self.places)
//                    
//                }
//                
//            }
//        }
//        task.resume()
        
     //temporary
     let bundle = Bundle(for: type(of: self))
        if let theURL = bundle.url(forResource: "favoritePlaces", withExtension: "json") {
            do {
                let data = try Data(contentsOf: theURL)
                self.places = self.parseJsonData(urlContent: data as NSData)
            } catch {
                print(error)
            }
        }
//        for placeItem in self.places {
//            print("ID: \(placeItem.id)")
//            print("Name: \(placeItem.name)")
//            print("Longitude: \(placeItem.longitude)")
//            print("Latitude: \(placeItem.latitude)")
//        }
        
     self.drawMap(listOfPlaces: self.places)
        
    }
    
    func parseJsonData(urlContent: NSData) -> [Place] {
        
        do {
            let jsonResults = try JSONSerialization.jsonObject(with: urlContent as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:AnyObject]]
            
            for jsonResult in jsonResults {
                let myPlace = Place()
                myPlace.id = jsonResult["id"] as! Int
                myPlace.name = jsonResult["name"] as! String
                myPlace.latitude = jsonResult["lat"] as! Double
                myPlace.longitude = jsonResult["lon"] as! Double
                
                places.append(myPlace)
            }
            
        } catch {
            print("JSON Processing Failed")
        }
        return places
    }
    
    //    func printArray() {
    //
    //        print("Items: \(self.places.count)")
    //
    //    }
    
    func drawMap(listOfPlaces: [Place]) {
        
        for placeItem in listOfPlaces {
            
            let latitude: CLLocationDegrees = placeItem.latitude
            
            let longitude: CLLocationDegrees = placeItem.longitude
            
            let latDelta: CLLocationDegrees = 50
            
            let lonDelta: CLLocationDegrees = 50
            
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            
            let cordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let region = MKCoordinateRegion(center: cordinates, span: span)
            
            self.map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            
            annotation.title = placeItem.name
            
            annotation.subtitle = placeItem.name + "..."
            
            annotation.coordinate = cordinates
            
            map.addAnnotation(annotation)
            
        }
    }

}
