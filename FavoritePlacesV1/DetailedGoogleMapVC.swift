//
//  DetailedGoogleMapVC.swift
//  FavoritePlacesV1
//
//  Created by Katerina on 23.03.17.
//  Copyright © 2017 Katerina. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailedGoogleMapVC: UIViewController {

    @IBOutlet weak var googleMapsContainer: UIView!
    var selectedPlace = Place()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.red
        self.navigationItem.title = selectedPlace.name
        
        GMSServices.provideAPIKey("AIzaSyBeYMUOLgbdwGtufxy4WUApaHgonMBeZ2Y")
        let camera = GMSCameraPosition.camera(withLatitude: selectedPlace.latitude, longitude: selectedPlace.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: selectedPlace.latitude, longitude: selectedPlace.longitude)
        marker.title = selectedPlace.name
        marker.snippet = selectedPlace.name
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
