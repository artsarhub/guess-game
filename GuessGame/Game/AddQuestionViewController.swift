//
//  AddQuestionViewController.swift
//  GuessGame
//
//  Created by Артём on 19.06.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextEdit: UITextField!
    @IBOutlet weak var ans1TextEdit: UITextField!
    @IBOutlet weak var ans2TextEdit: UITextField!
    @IBOutlet weak var ans3TextEdit: UITextField!
    @IBOutlet weak var ans4TextEdit: UITextField!
    @IBOutlet weak var correctAnswerSegmentedControl: UISegmentedControl!
    
    @IBAction func onAddButtonClicked(_ sender: Any) {
        guard let questionText = questionTextEdit.text,
              let ans1 = ans1TextEdit.text,
              let ans2 = ans2TextEdit.text,
              let ans3 = ans3TextEdit.text,
              let ans4 = ans4TextEdit.text,
              !(ans1TextEdit.text?.isEmpty ?? true),
              !(ans2TextEdit.text?.isEmpty ?? true),
              !(ans3TextEdit.text?.isEmpty ?? true),
              !(ans4TextEdit.text?.isEmpty ?? true)
        else { return }
        
        let newQuestion = Question(text: questionText,
                                   answerOptions: [ans1, ans2, ans3, ans4],
                                   correctAnswerIndex: correctAnswerSegmentedControl.selectedSegmentIndex)
        
        Game.shared.addUserQuestion(newQuestion)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGR)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

}
