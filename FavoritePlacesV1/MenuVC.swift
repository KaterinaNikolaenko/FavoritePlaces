//
//  MenuVC.swift
//  FavoritePlacesV1
//
//  Created by Katerina on 23.03.17.
//  Copyright © 2017 Katerina. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewMenu: UITableView!
    
    var selectedPlace = Place()
    var menuItems = ["Description", "Map", "Weather", "Currrency", "Sights", "Embassies and Consulates", "Booking hotels"]
    var menuImages = ["info", "world", "newsletter", "euro_currency_sign", "photo_camera", "flag", "home_red"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewMenu.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableViewMenu.dataSource = self
        self.tableViewMenu.rowHeight = 70.0
        self.navigationController?.navigationBar.tintColor = UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell: UITableViewCell = self.tableViewMenu.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        cell.textLabel?.text = self.menuItems[indexPath.row]
        let image : UIImage = UIImage(named: self.menuImages[indexPath.row])!
        cell.imageView?.image = image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0 {
           performSegue(withIdentifier: "showDescription", sender: selectedPlace)
        } else
            if indexPath.row == 1 {
               performSegue(withIdentifier: "showMap", sender: selectedPlace)
        } else
            if indexPath.row == 2 {
               performSegue(withIdentifier: "showWether", sender: selectedPlace)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWether" {
          let selectPlace1 = segue.destination as! WeatherVC
          selectPlace1.selectedPlace = sender as! Place
        }
        
        if segue.identifier == "showMap" {
            let selectPlace2 = segue.destination as! DetailedGoogleMapVC
            selectPlace2.selectedPlace = sender as! Place
        }
        
        if segue.identifier == "showDescription" {
            let selectPlace3 = segue.destination as! CityDescriptionVC
            selectPlace3.selectedPlace = sender as! Place
        }
        
    }


    

}
