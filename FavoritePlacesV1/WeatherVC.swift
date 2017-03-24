//
//  WeatherVC.swift
//  FavoritePlacesV1
//
//  Created by Katerina on 23.03.17.
//  Copyright © 2017 Katerina. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var nameCity: UILabel!
    @IBOutlet weak var resultWeather: UILabel!
    var selectedPlace = Place()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.red
        self.navigationItem.title = selectedPlace.name
        //self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        
       // if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + selectedPlace.name + "/forecasts/latest") {
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                var message = ""
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let unwrappedData = data {
                        
                        
                        
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            
                            if contentArray.count > 1 {
                                
                                stringSeparator = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                
                                if newContentArray.count > 1 {
                                    
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    
                                   // print(message)
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    
                }
                
                if message == "" {
                    
                    message = "The weather there couldn't be found. Please try again."
                    
                }
                
                DispatchQueue.main.sync(execute: {
                    
                    self.resultWeather.text = message
                    self.nameCity.text = self.nameCity.text! + " " + self.selectedPlace.name
                    
                })
                
            }
            
            task.resume()
            
        } else {
            
            resultWeather.text = "The weather there couldn't be found. Please try again."
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
