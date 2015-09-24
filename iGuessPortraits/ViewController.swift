//
//  ViewController.swift
//  iGuessPortraits
//
//  Created by Brad on 27/02/2015.
//  Copyright (c) 2015 iOSDevCamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var client: MSClient?
    var portraits: [Portrait] = []

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var startGuessingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startGuessingButton.hidden = true
        self.activityIndicatorView.startAnimating()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.client = MSClient(
            applicationURLString: "https://bwhitecross-portraits.azure-mobile.net/", applicationKey:"enRwCbUMLhTUOzebYikSNtlRqoKqzV64")

        let portraitTable = MSTable(name: "portrait", client: client)
        
        portraitTable.readWithCompletion({( items, totalCount, error) in
        
        for item in items {
            let title = item["title"] as! String
            let imageUrl = item["imageURL"] as! String
            let portrait = Portrait(title: title, imageUrl: imageUrl)
            self.portraits.append(portrait)
            }
            
            self.activityIndicatorView.stopAnimating()
            self.startGuessingButton.hidden = false
        })
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = (segue.destinationViewController as? PortraitViewController) {
            controller.score = Score(name: userName.text!)
            controller.portraits = self.portraits
            controller.client = self.client
        }
    }
}

