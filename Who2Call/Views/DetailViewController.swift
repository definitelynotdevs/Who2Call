//
//  DetailViewController.swift
//  Who2Call
//
//  Created by Tomasz Kielar on 20/10/2019.
//  Copyright © 2019 Definitely Not Devs. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    var passedCountry = WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!",flaga : "!", kierunkowy: "1", policja: "!", karetka: "!", straz: "!", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!",szerokosc: "null",dlugosc: "null"))
    var passedWybor = 0
    
    
    //outlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var zglosLabel: UILabel!
    @IBOutlet weak var mapka: MKMapView!
    @IBOutlet weak var zadzwonLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    //actions
    @IBAction func callButtonClicked(_ sender: Any) {
        let numberWithoutSpaces = String(phoneNumberLabel.text!.filter { !" ".contains($0) })
        print(numberWithoutSpaces)
        guard let number = URL(string: "tel://+" + passedCountry.kierunkowy  + numberWithoutSpaces) else { print("error");return }
        UIApplication.shared.open(number, options: [:], completionHandler:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGradientLayer()
        turnWhite()
        setAllComponents()
        
        print(passedWybor, " \n", passedCountry.ambasady.stolica)
        
    }
    
    //functions
    
    func createGradientLayer() {
        let  gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor(red: 104/255, green: 65/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(red: 66/255, green: 32/255, blue: 207/255, alpha: 1.0).cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func turnWhite() {
        setButtonGradient(button: callButton)
        roundIt(button: callButton)
        
        topLabel.textColor = .white
        zglosLabel.textColor = .white
        zadzwonLabel.textColor = .white
        phoneNumberLabel.textColor = .white
    }
    
    func setButtonGradient(button: UIButton!) {
        let gradientLayerOne = CAGradientLayer()
        gradientLayerOne.frame = self.view.bounds
        gradientLayerOne.colors = [
            UIColor(red: 60/255, green: 130/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(red: 65/255, green: 135/255, blue: 206/255, alpha: 1.0).cgColor
        ]
        button.layer.insertSublayer(gradientLayerOne, at: 0)
    }
    
    func roundIt (button: UIButton) {
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
    }
    
    func setAllComponents() {
        switch(passedWybor) {
        case 1:
            var country = passedCountry.kraj
            let firstLetter = country.prefix(1).uppercased()
            let otherLetters = country.dropFirst()
            country = firstLetter + otherLetters
            topLabel.text = "Jeżeli chcesz skontaktować się z ambasadą Polski w kraju: \(country)"
            zglosLabel.text = "1. Lokalizacja ambasady w kraju: \(country)"
            zadzwonLabel.text = "2. Skontaktuj się telefonicznie:"
            phoneNumberLabel.text = "\(passedCountry.ambasady.stolica)"
            
            //mapa
            let embassy = MKPointAnnotation()
            embassy.coordinate = CLLocationCoordinate2D(latitude: 49.999726, longitude: 19.412276)
            embassy.title = "Ambasada Polski"
            embassy.subtitle = "\(country)"
            
            mapka.addAnnotation(embassy)
            break
        case 2:
            topLabel.text = "Jeżeli istnieje możliwość zagrożenia konfliktem zbrojmyn:"
            zglosLabel.text = "1. Zgłoś to tutaj (Comming Soon)"
            zadzwonLabel.text = "2. Skontaktuj się telefonicznie:"
            phoneNumberLabel.text = "\(passedCountry.konflikty)"
            
            disableMap()
            break
        case 3:
            topLabel.text = "Jeżeli byłeś świadkiem przemocy domowej"
            zglosLabel.text = "1. Zgłoś to tutaj (Comming Soon)"
            zadzwonLabel.text = "2. Skontaktuj się telefonicznie:"
            phoneNumberLabel.text = "\(passedCountry.przemoc)"
            
            disableMap()
            break
        case 4:
            topLabel.text = "Jeżeli byłeś świadkiem próby samobójczej"
            zglosLabel.text = "1. Zgłoś to tutaj (Comming Soon)"
            zadzwonLabel.text = "2. Skontaktuj się telefonicznie:"
            phoneNumberLabel.text = "\(passedCountry.suicide)"
            
            disableMap()
            break
        default:
            phoneNumberLabel.text = "Something went wrong!"
            break
        }
    }
    
    func disableMap() {
       
        mapka.isZoomEnabled = false
        mapka.isScrollEnabled = false
        mapka.isUserInteractionEnabled = false
        mapka.backgroundColor = .clear
        mapka.alpha = 0.6
    }
    
    
}
