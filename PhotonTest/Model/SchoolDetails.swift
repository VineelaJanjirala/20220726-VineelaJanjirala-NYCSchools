//
//  SchoolDetails.swift
//  PhotonTest
//
//  Created by Navyasree Janjirala on 7/26/22.
//

import Foundation

class SchoolDetails {
    var schoolName: String
    var dbn: String
    var phone: String
    var email: String
    var website: String
    
    init (_ schoolName: String ,
          _ dbn: String,
          _ phone: String,
          _ email: String,
          _ website: String) {
        self.schoolName = schoolName
        self.dbn = dbn
        self.phone = phone
        self.email = email
        self.website = website
}
}
