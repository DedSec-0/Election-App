//
//  ViewController.swift
//  Election App
//
//  Created by Administrator on 26/06/2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    var Ref : DatabaseReference?
    let NA_File = Bundle.main.path(forResource: "PS", ofType: "txt")
    let NA_Address_File = Bundle.main.path(forResource: "NA - Addresses", ofType: "txt")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Ref = Database.database().reference().child("Provincial Assembly - Sindh")
        ReadFile()
    }
    
    func ReadFile(){
        
        do{
            let Data1 = try String(contentsOfFile: NA_File!, encoding: String.Encoding.utf8)
            let Data2 = try String(contentsOfFile: NA_Address_File!, encoding: String.Encoding.utf8)
            let RawData1 = Data1.components(separatedBy: "\r\n")
            let RawData2 = Data2.components(separatedBy: "\r\n")
            
            AddData(Data1: RawData1, Data2: RawData2)
        }
        catch let error as NSError {
            print(error)
        }
    }

    func AddData(Data1 : [String], Data2 : [String]) {
        var i : Int = 0
        var j : Int = 0
        
        while i < Data1.count - 1 {
            let key = Ref?.child(String(j + 1)).key
            let Data = ["Polling Station" : Data1[i],
                        "Candidate" : Data1[i + 1],
                        "Party Name" : Data1[i + 2],
                        "Votes" : Data1[i + 3],
                        "Coordinates" : Data2[j]]
            
            Ref?.child(key!).setValue(Data)
            print(i)
            i += 4
            j += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

