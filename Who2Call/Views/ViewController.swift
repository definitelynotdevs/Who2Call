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
        Country(name: "Azerbejdzan",engName: "XD", available: true, ambulance: "1", police: "2", fire: "3", suicidePrev: "4", violence: "5", conflict: "6"),
        Country(name: "Stany Zjednoczone", engName: "United States", available: true, ambulance: "1", police: "2", fire: "3", suicidePrev: "4", violence: "5", conflict: "6"),
        Country(name: "Wielka Brytania", engName: "United Kingdom", available: true, ambulance: "1", police: "2", fire: "3", suicidePrev: "4", violence: "5", conflict: "6"),
    ]
    let locationManager = CLLocationManager()
    var currCountry = ""
    var currCity = ""
    var pierwszyOpened = false
//MAIN LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.countryPicker.delegate = self
        self.countryPicker.dataSource = self
        locationManager.requestWhenInUseAuthorization()
        
        setVisuals()
        
        countryPicker.isHidden = true
    
        
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
                self.pokazButton.titleLabel!.text = "Pokaż📍"
                
            })
            pierwszyOpened = !pierwszyOpened
        }
        else {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.countryPicker.isHidden = false
                self.pokazButton.titleLabel!.text = "Schowaj ❌"
                self.countryPicker.alpha = 1

            })
            pierwszyOpened = !pierwszyOpened
        }
        
    }
    
    
    
    //FUNCTIONS
    func fetchCountryPicker() {
        
    }
    
    func setVisuals() {
        checkLocButton.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1.0)
        submitButton.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1.0)
        checkLocButton.layer.cornerRadius = 8
        checkLocButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 8
        submitButton.clipsToBounds = true
        stackFirst.addRoundedBackground(color: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 0.9))
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    }
    
    
    func changeCountry() {
        wybraneLbl.text = "Wybrano kraj: " + currCountry
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
            vc.passedCountry = currCountry
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
        }
        if currCountry != "" {
            locationManager.stopUpdatingLocation()
            print(currCity+" "+currCountry)
            self.activityCircle.stopAnimating()
           }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currCountry = testoweObiekty[row].name
        changeCountry()
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
 
    
    
    
//EDYCJA COUNTRY PICKER
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.testoweObiekty.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.testoweObiekty[row].name
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
