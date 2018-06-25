//
//  ViewController.swift
//  Election App
//
//  Created by Administrator on 26/06/2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let fileName = "myFile.txt"
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

