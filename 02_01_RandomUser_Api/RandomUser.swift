//
//  File.swift
//  02_01_RandomUser_Api
//
//  Created by csuftitan on 1/2/24.
//

import Foundation

struct RandomUser{
    var results : [Results]
    var info : Info
}

struct Results{
    var gender : String
    var name : Name
    var location : Location
    var email : String
    var login : Login
}

struct Name{
    var first : String
    var last : String
}

struct Location{
    var street : Street
    var city : String
    var coordinates : Coordinates
}

struct Street{
    var number : Int
}

struct Coordinates{
    var latitude : String
}

struct Login{
    var password : String
}

struct Info{
    var seed : String
}
