//
//  ViewController.swift
//  Who2Call
//
//  Created by Tomasz Kielar on 19/10/2019.
//  Copyright © 2019 Definitely Not Devs. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
 // OUTLETS
    @IBOutlet weak var formBg: UIView!
    @IBOutlet weak var CountryLbl: UILabel!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var checkLocButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var wybraneLbl: UILabel!
    @IBOutlet weak var activityCircle: UIActivityIndicatorView!
    @IBOutlet weak var stackFirst: UIStackView!
    @IBOutlet weak var pokazButton: UIButton!
    //VARIABLES
    var testoweObiekty : [Country] = [
       
    ]
    let locationManager = CLLocationManager()
    var currCountry = ""
    var currCity = ""
    var pierwszyOpened = false
    var tempCountry = ""
    var krajeJson = [WelcomeElement]()

//MAIN LOAD
    override func viewDidLoad() {
        krajeJson = getPath()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.countryPicker.delegate = self
        self.countryPicker.dataSource = self
        self.countryPicker.setValue(UIColor.white, forKey: "textColor")
        self.countryPicker.reloadAllComponents()
        locationManager.requestWhenInUseAuthorization()
        
        setVisuals()
        
        countryPicker.isHidden = true
        
        onOffSubmit()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.countryPicker.isHidden = true
        pierwszyOpened = false
        self.pokazButton.setTitle("Pokaż📍", for: .normal)

    }
    override func viewDidAppear(_ animated: Bool) {

    }
//ACTIONS
    @IBAction func locateAction(_ sender: UIButton) {
        locate()
        activityCircle.isHidden = false
        activityCircle.startAnimating()
    }
    @IBAction func pokazAction(_ sender: UIButton) {
        if pierwszyOpened {
            UIView.animate(withDuration: 0.0001, animations: {
                self.countryPicker.alpha = 0
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.countryPicker.isHidden = true
                self.pokazButton.setTitle("Pokaż📍", for: .normal)
                
            })
            pierwszyOpened = !pierwszyOpened
        }
        else {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.countryPicker.isHidden = false
                self.pokazButton.setTitle("Schowaj ❌", for: .normal)
                self.countryPicker.alpha = 1

            })
            pierwszyOpened = !pierwszyOpened
        }
        
    }
    
    
    
    //FUNCTIONS
    func setVisuals() {
      //  checkLocButton.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1.0)
      //  submitButton.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1.0)
        
        checkLocButton.layer.cornerRadius = 8
        checkLocButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 8
        submitButton.clipsToBounds = true
        stackFirst.addRoundedBackground(color: .clear)
       // view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        formBg.layer.cornerRadius = 8
        formBg.clipsToBounds = true
        formBg.backgroundColor = .clear
        createGradientLayer()
        createGradientButton()
        wybraneLbl.textColor = .white
        pokazButton.titleLabel?.adjustsFontSizeToFitWidth = true

    }
    
    func createGradientLayer() {
      var  gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
     
        gradientLayer.colors = [UIColor(red: 104/255, green: 65/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(red: 66/255, green: 32/255, blue: 207/255, alpha: 1.0).cgColor]
     
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    func createGradientButton() {
        var  gradientLayerOne = CAGradientLayer()
        gradientLayerOne.frame = self.view.bounds
        gradientLayerOne.colors = [
            UIColor(red: 60/255, green: 130/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(red: 65/255, green: 135/255, blue: 206/255, alpha: 1.0).cgColor
        ]
        var  gradientLayerTwo = CAGradientLayer()
        gradientLayerTwo.frame = self.view.bounds
        gradientLayerTwo.colors = [
            UIColor(red: 60/255, green: 130/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(red: 65/255, green: 135/255, blue: 206/255, alpha: 1.0).cgColor
        ]
        checkLocButton.layer.insertSublayer(gradientLayerOne, at: 0)
        submitButton.layer.insertSublayer(gradientLayerTwo, at: 0)
        
        submitButton.setTitleColor(.white, for: .normal)
        checkLocButton.setTitleColor(.white, for: .normal)
    }
    func createGradientLayerForStack() {
      var  gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = stackFirst.layer.bounds
     
        gradientLayer.colors = [UIColor(red: 104/255, green: 65/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(red: 66/255, green: 32/255, blue: 207/255, alpha: 1.0).cgColor]
     
        stackFirst.layer.insertSublayer(gradientLayer, at: 0)
    }
    func changeCountry() {
        var country = currCountry
        let firstLetter = country.prefix(1).uppercased()
        let otherLetters = country.dropFirst()
        country = firstLetter + otherLetters
        wybraneLbl.text = "Wybrano kraj: " + country
    }
    
    func locate() {
      
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CountryViewController {
            let vc = segue.destination as! CountryViewController
            vc.passedCountry = currCountry.lowercased()
            currCountry = ""
            changeCountry()
            onOffSubmit()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
            self.currCity = city
            self.currCountry = country
            self.changeCountry()
            self.tempCountry = country
        }
        if currCountry == tempCountry && currCountry != "" {
         locationManager.stopUpdatingLocation()
         print(currCity+" "+currCountry)
         self.activityCircle.stopAnimating()
         performSegue(withIdentifier: "gps", sender: nil)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currCountry = krajeJson[row].kraj
        changeCountry()
        onOffSubmit()
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
 
    func onOffSubmit() {
        if currCountry == "" {
            submitButton.isEnabled = false
            submitButton.alpha = 0.7
        } else {
            submitButton.isEnabled = true
            submitButton.alpha = 1
        }
    }
    
    
    
//EDYCJA COUNTRY PICKER
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.krajeJson.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        krajeJson.sort(by: {$0.kraj < $1.kraj})
        return self.krajeJson[row].kraj.uppercased()
    }
    
//jsons
    
    func getPath()->[WelcomeElement] {
        let errorMsg = [WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!",flaga : "!", kierunkowy: "1", policja: "!", karetka: "!", straz: "!", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!",szerokosc: "null",dlugosc: "null"))]
        
        do {
            if let urlPath = Bundle.main.path(forResource: "Countries", ofType: "json") {
                let url = URL(fileURLWithPath: urlPath)
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let product = try decoder.decode([WelcomeElement].self, from: jsonData)
                countryPicker.reloadAllComponents()
                return product
                
            }
            else {
                return errorMsg
            }
        }
        catch let error {
            print(error.localizedDescription)
            return errorMsg
        }
    }
    
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    func addRoundedBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 8
        subView.clipsToBounds = true
        subView.layer.shadowOffset = CGSize(width:5.0, height:5.0);
        subView.layer.shadowRadius = 5;
        subView.layer.shadowOpacity = 0.5;
        insertSubview(subView, at: 0)
    }
}
