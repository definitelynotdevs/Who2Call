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
    var currCountry : WelcomeElement = WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!", kierunkowy: "1", policja: "!", karetka: "!", straz: "!", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!"))
    var wybor = 0 // 1-4 wybory
    
    
    
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var policeLbl: UILabel!
    @IBOutlet weak var fireLbl: UILabel!
    @IBOutlet weak var ambulanceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonCountries = getPath()
        currCountry = getCountry()
        countryNameLbl.text = passedCountry.uppercased()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        getNumbers()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
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
        }
    }
  
    //json
    func getPath()->[WelcomeElement] {
           let errorMsg = [WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!", kierunkowy: "1", policja: "!", karetka: "!", straz: "!", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!"))]
           
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
        let errCountry = WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!", kierunkowy: "!", policja: "Try", karetka: "!", straz: "again", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!"))
        var xd : WelcomeElement
        for every in 0...jsonCountries.count-1 {
            if jsonCountries[every].kraj == passedCountry {
                xd = jsonCountries[every]
                return xd
            }
        }
       return errCountry
    }
    
    //actions
    @IBAction func ambasadyAction(_ sender: UIButton) {
        wybor = 1
    }
    @IBAction func armsConflictAction(_ sender: UIButton) {
        wybor = 2
    }
    @IBAction func homeAbuseAction(_ sender: UIButton) {
        wybor = 3
    }
    @IBAction func suicidePreventionAction(_ sender: UIButton) {
        wybor = 4
    }
    @IBAction func policeCall(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + currCountry.policja) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler:nil)
    }
    @IBAction func fireCall(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + currCountry.straz) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler:nil)    }
    @IBAction func ambulanceCall(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + currCountry.karetka) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler:nil)    }
}
