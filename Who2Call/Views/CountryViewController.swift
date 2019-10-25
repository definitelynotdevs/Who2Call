//
//  CountryViewController.swift
//  Who2Call
//
//  Created by Tomasz Kielar on 20/10/2019.
//  Copyright © 2019 Definitely Not Devs. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    
    
    var passedCountry : String = ""
    var jsonCountries = [WelcomeElement]()
    var currCountry : WelcomeElement = WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!",flaga : "!", kierunkowy: "1", policja: "!", karetka: "!", straz: "!", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!",szerokosc: "null",dlugosc: "null"))
    var wybor = 0 // 1-4 wybory
    
    
    
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var flagueLbl: UILabel!
    @IBOutlet weak var policeNameLbl: UILabel!
    @IBOutlet weak var policeLbl: UILabel!
    @IBOutlet weak var policeCall: UIButton!
    @IBOutlet weak var fireNameLbl: UILabel!
    @IBOutlet weak var fireLbl: UILabel!
    @IBOutlet weak var fireCall: UIButton!
    @IBOutlet weak var ambulanceNameLbl: UILabel!
    @IBOutlet weak var ambulanceLbl: UILabel!
    @IBOutlet weak var ambulanceCall: UIButton!
    
    @IBOutlet weak var embassyButton: UIButton!
    @IBOutlet weak var armsConflictButton: UIButton!
    @IBOutlet weak var homeAbuseButton: UIButton!
    @IBOutlet weak var suicideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        turnWhite()
        setVisuals()
        jsonCountries = getPath()
        currCountry = getCountry()
        countryNameLbl.text = passedCountry.uppercased()
        flagueLbl.text = currCountry.flaga
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        getNumbers()
    
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    override func viewWillAppear(_ animated: Bool) {
                self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    //func
    func getNumbers() {
        policeLbl.text = currCountry.policja
        fireLbl.text = currCountry.straz
        ambulanceLbl.text = currCountry.karetka
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            let vc = segue.destination as! DetailViewController
            vc.passedCountry = currCountry
            vc.passedWybor = wybor
            wybor = 0
        }
    }
  
    //json
    func getPath()->[WelcomeElement] {
           let errorMsg = [WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!",flaga : "!", kierunkowy: "1", policja: "!", karetka: "!", straz: "!", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!",szerokosc: "null",dlugosc: "null"))]
           
           do {
               if let urlPath = Bundle.main.path(forResource: "Countries", ofType: "json") {
                   let url = URL(fileURLWithPath: urlPath)
                   let jsonData = try Data(contentsOf: url)
                   let decoder = JSONDecoder()
                   let product = try decoder.decode([WelcomeElement].self, from: jsonData)
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
    func getCountry()->WelcomeElement {
        let errCountry = WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!",flaga : "!", kierunkowy: "!", policja: "Try", karetka: "!", straz: "again", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!",szerokosc: "null",dlugosc: "null"))
        var xd : WelcomeElement
        for every in 0...jsonCountries.count-1 {
            if jsonCountries[every].kraj == passedCountry {
                xd = jsonCountries[every]
                return xd
            }
        }
       return errCountry
    }
    
    func createGradientLayer() {
      var  gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
     
        gradientLayer.colors = [UIColor(red: 104/255, green: 65/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(red: 66/255, green: 32/255, blue: 207/255, alpha: 1.0).cgColor]
     
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func turnWhite() {
        buttonText(xd: embassyButton)
        buttonText(xd: armsConflictButton)
        buttonText(xd: suicideButton)
        buttonText(xd: homeAbuseButton)
        
        countryNameLbl.textColor = .white
        
        policeNameLbl.textColor = .white
        fireNameLbl.textColor = .white
        ambulanceNameLbl.textColor = .white
        countryNameLbl.textColor = .white

        policeLbl.textColor = .white
        fireLbl.textColor = .white
        ambulanceLbl.textColor = .white
        
        
        }
    func buttonText(xd: UIButton) {
        xd.setTitleColor(.white, for: .normal)
    }
    
    func setVisuals() {
        
        roundIt(przycisk: embassyButton)
        roundIt(przycisk: armsConflictButton)
        roundIt(przycisk: homeAbuseButton)
        roundIt(przycisk: suicideButton)
        roundIt(przycisk: policeCall)
        roundIt(przycisk: fireCall)
        roundIt(przycisk: ambulanceCall)
         
        
        
        
        createGradientButton()
        
    }
    func roundIt (przycisk: UIButton) {
        przycisk.layer.cornerRadius = 8
        przycisk.clipsToBounds = true
    }
    
    func createGradientButton() {
        addColorTo(button: policeCall)
        addColorTo(button: fireCall)
        addColorTo(button: ambulanceCall)
        addColorTo(button: embassyButton)
        addColorTo(button: armsConflictButton)
        addColorTo(button: homeAbuseButton)
        addColorTo(button: suicideButton)

    }
    
    func addColorTo(button:UIButton) {
        var  gradientLayerOne = CAGradientLayer()
        gradientLayerOne.frame = self.view.bounds
        gradientLayerOne.colors = [
            UIColor(red: 60/255, green: 130/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(red: 65/255, green: 135/255, blue: 206/255, alpha: 1.0).cgColor
        ]
        button.layer.insertSublayer(gradientLayerOne, at: 0)
        
    }
    
    //actions
    @IBAction func ambasadyAction(_ sender: UIButton) {
        wybor = 1
        performSegue(withIdentifier: "testowo", sender: nil)
    }
    @IBAction func armsConflictAction(_ sender: UIButton) {
        wybor = 2
        performSegue(withIdentifier: "testowo", sender: nil)
    }
    @IBAction func homeAbuseAction(_ sender: UIButton) {
        wybor = 3
        performSegue(withIdentifier: "testowo", sender: nil)
    }
    @IBAction func suicidePreventionAction(_ sender: UIButton) {
        wybor = 4
        performSegue(withIdentifier: "testowo", sender: nil)
    }
    @IBAction func policeCall(_ sender: UIButton) {
        guard let number = URL(string: "tel://+" + currCountry.kierunkowy + currCountry.policja.filter { !" ".contains($0) }) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler:nil)    }
    @IBAction func fireCall(_ sender: UIButton) {
        guard let number = URL(string: "tel://+" + currCountry.kierunkowy  + currCountry.straz.filter { !" ".contains($0) }) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler:nil)    }
    @IBAction func ambulanceCall(_ sender: UIButton) {
        guard let number = URL(string: "tel://+" + currCountry.kierunkowy  + currCountry.karetka.filter { !" ".contains($0) }) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler:nil)    }
}

