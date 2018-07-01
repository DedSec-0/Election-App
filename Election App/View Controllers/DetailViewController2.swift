//
//  DetailViewController2.swift
//  Election App
//
//  Created by Administrator on 27/06/2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class DetailViewController2: UIViewController {

    var Index : Int = 0
    
    @IBOutlet weak var NALabel: UILabel!
    @IBOutlet weak var NamelLabel: UILabel!
    @IBOutlet weak var VotesLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var CoordinatesLabel: UILabel!
    @IBOutlet weak var PartyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Winner Candidate"
        refreshView()
    }
    
    @IBAction func btnRight(_ sender: Any) {
        if (Index == 258){
            return
        }
        Index += 1
        refreshView()
        
    }
    @IBAction func btnLeft(_ sender: Any) {
        if (Index == 0){
            return
        }
        Index -= 1
        refreshView()
    }
    
    func refreshView() {
        let myCoordinates = String(describing: AssembliesData[1][Index].Coordinates.latitude) + ", " + String(describing: AssembliesData[1][Index].Coordinates.longitude)
        
        NALabel.text = AssembliesData[1][Index].StNo
        NamelLabel.text = AssembliesData[1][Index].Candidate
        VotesLabel.text = AssembliesData[1][Index].Votes
        PartyNameLabel.text = AssembliesData[1][Index].PartyName
        CoordinatesLabel.text = myCoordinates
        myImageView.image = UIImage(named: AssembliesData[1][Index].PartyName + ".jpg")!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
