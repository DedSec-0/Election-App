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
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let NA_File = "National Assembly.txt"
        let NA_Address_File = "NA - Addresses.txt"
        let PB_File = "PB.txt"
        let PP_File = "PP.txt"
        let PK_File = "PK.txt"
        if let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            let fileUrl = dirPath.appendingPathComponent(fileName)
            //            do
            //            {
            //                try fileData.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
            //            }
            //            catch{
            //
            //            }
            do
            {
                let data = try String.init(contentsOf: fileUrl, encoding: .utf8)
                print("the data is: ", data)
                
//                Ref = Database.database().reference()
//                Ref?.child("National Assembly").observe(.value, with: {(snapshot) in
//
//                    if snapshot.childrenCount > 0 {
//                        S.removeAll()
//                        for St in snapshot.children.allObjects as! [DataSnapshot] {
//                            let StObj = St.value as? [String : AnyObject]
//                            let StName = StObj?["Name"]
//                            let StRollNo = StObj?["RollNo"]
//                            let StAge = StObj?["Age"]
//                            let StPhone = StObj?["Phone"]
//                            let StAddress = StObj?["Address"]
//                            let StId = StObj?["Id"]
//                            let myStObj = StudentsModel(Names: StName as! String, RollNo: StRollNo as! String, Age: StAge as! String, Phone: StPhone as! String, Address: StAddress as! String, Id: StId as! String)
//
//                            S.append(myStObj)
//                        }
//                        self.myTableView.reloadData()
//                    }
//                })
            }
            catch{
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

