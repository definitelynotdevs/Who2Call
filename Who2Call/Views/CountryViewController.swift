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
    @IBOutlet weak var countryNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryNameLbl.text = passedCountry
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
