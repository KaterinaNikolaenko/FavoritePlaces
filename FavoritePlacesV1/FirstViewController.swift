//
//  FirstViewController.swift
//  FavoritePlacesV1
//
//  Created by Katerina on 22.03.17.
//  Copyright © 2017 Katerina. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //let url = URL(string:"https://destinations.christiaanderidder.nl/destinations")!
    var places = [Place]()
    var imagesPhoto = [UIImage(named: "Amsterdam"), UIImage(named: "Kiev"), UIImage(named: "Paris"), UIImage(named: "Rome"), UIImage(named: "London"), UIImage(named: "Berlin"), UIImage(named: "Copenhagen"), UIImage(named: "Oslo"), UIImage(named: "Vien")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // getPlaces()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getPlaces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellFirstVC
        
        cell.photo.image = imagesPhoto[indexPath.row]
       
        cell.name.text = places[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "onePlace2", sender: places[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectPlace = segue.destination as! MenuVC
        selectPlace.selectedPlace = sender as! Place
        
    }

    func getPlaces() {
        
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
//                for placeItem in self.places {
//                    print("ID: \(placeItem.id)")
//                    print("Name: \(placeItem.name)")
//                    print("Longitude: \(placeItem.longitude)")
//                    print("Latitude: \(placeItem.latitude)")
//                }
        
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
                myPlace.description = jsonResult["description"] as! String
                
                let jsonResultLinks = jsonResult["useful_links"] as! [[String:AnyObject]]
                var usefulLinks = [UsefulLink]()
                for jsonResultLink in jsonResultLinks {
                    let myLink = UsefulLink()
                    myLink.id = jsonResultLink["id"] as! Int
                    myLink.discription = jsonResultLink["discription"] as! String
                    myLink.url = jsonResultLink["url"] as! String
                    //myLink.url = URL(string: jsonResultLink["url"] as! String)! as URL
                    
                    usefulLinks.append(myLink)
                }
                myPlace.links = usefulLinks
                places.append(myPlace)
            }
            
        } catch {
            print("JSON Processing Failed")
        }
        return places
    }

}

