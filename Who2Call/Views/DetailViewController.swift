//
//  DetailViewController.swift
//  Who2Call
//
//  Created by Tomasz Kielar on 20/10/2019.
//  Copyright © 2019 Definitely Not Devs. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var passedCountry = WelcomeElement(kraj: "ErrorWhileLoading", krajAng: "!",flaga : "!", kierunkowy: "1", policja: "!", karetka: "!", straz: "!", przemoc: "!", suicide: "!", konflikty: "!", ambasady: Ambasady(stolica: "!",szerokosc: "null",dlugosc: "null"))
    var passedWybor = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
