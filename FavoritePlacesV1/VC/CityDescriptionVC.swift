//
//  CityDescriptionVC.swift
//  FavoritePlacesV1
//
//  Created by Katerina on 24.03.17.
//  Copyright © 2017 Katerina. All rights reserved.
//

import UIKit
import Kingfisher

class CityDescriptionVC: UIViewController {
    
    @IBOutlet var cityPhotos: [UIButton]!
    
    @IBOutlet weak var locationLabel: UILabel!
    
   
    
    @IBOutlet weak var linkText: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var buttonTransform: UIButton!
    @IBOutlet weak var linkView: UIView!
    @IBOutlet weak var linkViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationViewConstraint: NSLayoutConstraint!
    var selectedPlace = Place()
    var isExpanded: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.red
        self.navigationItem.title = selectedPlace.name
        self.isExpanded = true
        
        self.locationLabel.text = "Lat: " + String(selectedPlace.longitude) + ", Lon: " + String(selectedPlace.latitude)
        self.linkText.text = String(describing: selectedPlace.links[0].url)
        self.descriptionLabel.text = selectedPlace.description
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func showPopUp(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cityPoUpID") as! PopUpViewController
        popOverVC.imageCleaningPlace = sender.currentBackgroundImage
        
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
    }
    

    @IBAction func hideViews(_ sender: Any) {
        
        self.isExpanded = !self.isExpanded
        self.locationViewConstraint.constant = self.isExpanded ? 40 : 0
        self.linkViewConstraint.constant = self.isExpanded ? 40 : 0

        self.buttonTransform.backgroundColor = self.isExpanded ? UIColor.gray : UIColor.red
        self.buttonTransform.transform = self.isExpanded ? CGAffineTransform(rotationAngle: 0) : CGAffineTransform(rotationAngle: CGFloat(M_PI))
       
        UIView.animate(withDuration: 0.5) {
           // [weak self] value in
            self.view.layoutIfNeeded()
            self.locationView.alpha = self.isExpanded ? 1.0 : 0.0
            self.linkView.alpha = self.isExpanded ? 1.0 : 0.0
            self.buttonTransform.transform = self.isExpanded ? CGAffineTransform(rotationAngle: CGFloat(M_PI)) : CGAffineTransform(rotationAngle: 0);
            self.buttonTransform.backgroundColor = self.isExpanded ? UIColor.red : UIColor.gray
            
        }
        
    }
    
    
}
