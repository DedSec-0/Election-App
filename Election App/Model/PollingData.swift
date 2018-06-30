//
//  PollingData.swift
//  Election App
//
//  Created by Administrator on 01/07/2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import GoogleMaps

struct PollingData {
    var StNo : String
    var Candidate : String
    var Votes : String
    var PartyName : String
    var Coordinates : CLLocationCoordinate2D
    
    init() {
        StNo = ""
        Candidate = ""
        Votes = ""
        PartyName = ""
        Coordinates = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    init(StNo: String, Candidate: String, Votes: String, PartyName: String, Coordinates: CLLocationCoordinate2D) {
        self.StNo = StNo
        self.Candidate = Candidate
        self.Votes = Votes
        self.PartyName = PartyName
        self.Coordinates = Coordinates
    }
}
