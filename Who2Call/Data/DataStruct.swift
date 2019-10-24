//
//  DataStruct.swift
//  Who2Call
//
//  Created by Tomasz Kielar on 20/10/2019.
//  Copyright © 2019 Definitely Not Devs. All rights reserved.
//

import Foundation
import UIKit


struct Country {
    var kraj : String
    var krajAng : String
    var kierunkowy : String
    var policja : String
    var karetka : String
    var straz : String
    var przemoc : String
    var suicide : String
    var konflikty : String
    var ambasady : [String:String]
}


// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let kraj, krajAng, flaga , kierunkowy, policja: String
    let karetka, straz, przemoc, suicide: String
    let konflikty: String
    let ambasady: Ambasady
}

// MARK: - Ambasady
struct Ambasady: Codable {
    let stolica: String
    let szerokosc: String
    let dlugosc: String
}
