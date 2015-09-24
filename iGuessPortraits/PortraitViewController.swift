//
//  PortraitViewController.swift
//  iGuessPortraits
//
//  Created by Brad on 27/02/2015.
//  Copyright (c) 2015 iOSDevCamp. All rights reserved.
//

import UIKit

class PortraitViewController: UIViewController {
    
    var client: MSClient?
    var score: Score?
    var portraits: [Portrait]!
    var numberOfQuestions: Int = 1
    var randomTitles: [String] = []
    var correctButton: Int = 1
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func button1Action(sender: UIButton) {
        updateScore(correctButton == 1)
    }
    
    @IBAction func button2Action(sender: UIButton) {
        updateScore(correctButton == 2)
    }
    
    func updateScore(correct: Bool) {
        if (correct) {
            self.score?.BestScore += 1
        } else {
            self.score?.BestScore -= 1
        }
        
        numberOfQuestions += 1
        
        if let scorelbl = self.scoreLabel {
            let s = score?.BestScore.description ?? "0"
            scorelbl.text = "Score: " + s
        }
        
        if (numberOfQuestions == 10){
            saveScore()
            navigationController?.popViewControllerAnimated(true)
        } else {
            pickPortrait()
        }
    }
    
    func saveScore() {
        let scoreTable = MSTable(name: "Score", client: client)
        let itemDict = [
            "Name": self.score?.Name ?? "Jake",
            "BestScore": self.score?.BestScore ?? 9999
        ]
        scoreTable.insert(itemDict as [NSObject : AnyObject], completion: nil)
    }
    
    func randomIndex(count: Int) -> Int {
        return Int(arc4random_uniform(UInt32(count)))
    }
    
    func pickRandomPortrait() -> Portrait {
        return portraits[randomIndex(portraits.count)]
    }
    
    func pickRandomTitle() -> String {
        return randomTitles[randomIndex(randomTitles.count)]
    }
    
    func pickPortrait() {
        
        let portrait = pickRandomPortrait()
        var title = pickRandomTitle()
        while (portrait.title == title) {
            title = pickRandomTitle()
        }
        
        let b1 = NSAttributedString(string: portrait.title)
        let b2 = NSAttributedString(string: title)
        let i = randomIndex(2)
        if (i == 1) {
            button1.setAttributedTitle(b1, forState: UIControlState.Normal)
            button2.setAttributedTitle(b2, forState: UIControlState.Normal)
            correctButton = 1
        } else {
            button1.setAttributedTitle(b2, forState: UIControlState.Normal)
            button2.setAttributedTitle(b1, forState: UIControlState.Normal)
            correctButton = 2
        }
        loadImage(portrait)
    }
    
    func loadImage(portrait: Portrait)
    {
        if let imgurl = portrait.imageUrl {
            if let url = NSURL(string: imgurl) {
                if let data = NSData(contentsOfURL: url) {
                    image.image = UIImage(data: data)
                }
            }
        }
    }
    
    func loadRandomTitles() {
        if let allPortraits = portraits {
            for p in allPortraits {
                randomTitles.append(p.title)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        numberOfQuestions = 1;
        
        loadRandomTitles()
        
        pickPortrait()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
