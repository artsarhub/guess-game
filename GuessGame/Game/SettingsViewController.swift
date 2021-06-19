//
//  SettingsViewController.swift
//  GuessGame
//
//  Created by Артём on 19.06.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var questionOrderSegmentedControl: UISegmentedControl!
    
    @IBAction func onQuestionOrderChanged(_ sender: UISegmentedControl) {
        Game.shared.saveSettings(Settings(questionOrder: sender.selectedSegmentIndex))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionOrderSegmentedControl.selectedSegmentIndex = Game.shared.settings.questionOrder
    }
    
}
