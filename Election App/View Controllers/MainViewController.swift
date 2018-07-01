//
//  MainViewController.swift
//  Election App
//
//  Created by Administrator on 01/07/2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleMaps

var AssembliesData = [[PollingData]]()

class MainViewController: UIViewController {

    var Ref : DatabaseReference?
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var textToSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Ref = Database.database().reference()
        ReadDatabase()
        mapBtn.isEnabled = false
        searchBtn.isEnabled = false
        mapBtn.setTitle("Loading", for: .disabled)
        mapBtn.setTitle("Show Map", for: .normal)
        searchBtn.setTitle("Loading", for: .disabled)
        searchBtn.setTitle("Search", for: .normal)
        
        //ReadFile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchedDetails" {
            var index : Int = 0
            let Target = segue.destination as! DetailViewController2
            
            if self.textToSearch.text != "" {
                let values = textToSearch.text?.components(separatedBy: "-")
                if values?.count == 1 {
                    index = (NumberFormatter().number(from: values![0])?.intValue)! - 1
                }
                else {
                    index = (NumberFormatter().number(from: values![1])?.intValue)! - 1
                }
            }
            
            Target.Index = index
        }
    }

    func ReadDatabase(){
        let Assemblies = [ "Provincial Assembly - Balouchistan",
                           "National Assembly", "Provincial Assembly - KPK",
                           "Provincial Assembly - Punjab",
                           "Provincial Assembly - Sindh"]
        
        for i in 0..<Assemblies.count {
            var TempData = [PollingData]()
            Ref?.child(Assemblies[i]).observe(.value, with: {(snapshot) in
                if snapshot.childrenCount > 0 {
                    for St in snapshot.children.allObjects as! [DataSnapshot] {
                        let Obj = St.value as? [String : AnyObject]
                        let StNo = Obj?["Polling Station"] as! String
                        let Candidate = Obj?["Candidate"] as! String
                        let Votes = Obj?["Votes"] as! String
                        let PartyName = Obj?["Party Name"] as! String
                        let Cr = Obj?["Coordinates"] as! String
                        
                        let Coordi = Cr.components(separatedBy: ",")
                        let latitude = NumberFormatter().number(from: Coordi[0])?.doubleValue
                        let longitude = NumberFormatter().number(from: Coordi[1])?.doubleValue
                        let Coordinates = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                        let myObj = PollingData(StNo: StNo, Candidate: Candidate, Votes: Votes, PartyName: PartyName, Coordinates: Coordinates)
                        
                        TempData.append(myObj)
                    }
                }
                
                AssembliesData.append(TempData)
                if AssembliesData.count >= 5 {
                    self.mapBtn.isEnabled = true
                    self.searchBtn.isEnabled = true
                }
            })
        }
    }
    
    func ReadFile(){
        let NA_File = Bundle.main.path(forResource: "National Assembly", ofType: "txt")
        let NA_Address_File = Bundle.main.path(forResource: "NA - Addresses", ofType: "txt")
        
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
            let key = Ref?.child("National Assembly").child(String(j + 1)).key
            let Data = ["Polling Station" : Data1[i],
                        "Candidate" : Data1[i + 1],
                        "Party Name" : Data1[i + 2],
                        "Votes" : Data1[i + 3],
                        "Coordinates" : Data2[j]]
            
            Ref?.child("National Assembly").child(key!).setValue(Data)
            print(i)
            i += 4
            j += 1
        }
    }

}
