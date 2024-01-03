//
//  ViewController.swift
//  02_01_RandomUser_Api
//
//  Created by csuftitan on 1/2/24.
//

import UIKit

class ViewController: UIViewController {

    var randomUser : [RandomUser] = []
    var resultObject: Results?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }
    
    func fetchData(){
        let url = URL(string: "https://randomuser.me/api/#")
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        let urlSession = URLSession(configuration: .default)
        
        var ranDataTask = urlSession.dataTask(with: urlRequest){ ranData, ranResponse, ranError in
            
            let ranResponse = try! JSONSerialization.jsonObject(with: ranData!) as! [String: Any]
            
            let results = ranResponse["results"] as! [[String: Any]]
            
            for eachResultResponse in results{
                var resultDictionary = eachResultResponse as [String:Any]
                var gender = resultDictionary["gender"] as! String
                
                var name = resultDictionary["name"] as! [String:Any]
                var first = name["first"] as! String
                var last = name["last"] as! String
                
                var location = resultDictionary["location"] as! [String:Any]
                var street = location["street"] as! [String:Any]
                var number = street["number"] as! Int
                var city = location["city"] as! String
                var coordinates = location["coordinates"] as! [String:Any]
                var latitude = coordinates["latitude"] as! String
                
                var email = resultDictionary["email"] as! String
                
                var login = resultDictionary["login"] as! [String:Any]
                var password = login["password"] as! String
                
                var nameObject = Name(first: first, last: last)
                var coordinatesObject = Coordinates(latitude: latitude)
                var streetObject = Street(number: number)
                var locationObject = Location(street: streetObject, city: city, coordinates: coordinatesObject)
                var loginObject = Login(password: password)
                
                self.resultObject = Results(gender: gender, name: nameObject, location: locationObject, email: email, login: loginObject)
                
            }
            var info = ranResponse["info"] as! [String:Any]
            var seed = info["seed"] as! String
            
            var infoObject = Info(seed: seed)
            
            var randomObject = RandomUser(results: [self.resultObject!], info: infoObject)
            
            self.randomUser.append(randomObject)
            
            print(randomObject)
            
        }
        ranDataTask.resume()
        
        
    }


}

