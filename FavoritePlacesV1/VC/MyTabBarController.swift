//
//  MyTabBarController.swift
//  FavoritePlacesV1
//
//  Created by Katerina on 24.03.17.
//  Copyright © 2017 Katerina. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       // self.tabBar.barTintColor = UIColor(colorLiteralRed: 255.0/255.0, green: 197.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        self.tabBar.tintColor = .red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
