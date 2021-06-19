//
//  GameViewViewController.swift
//  GuessGame
//
//  Created by Артём Сарана on 13.06.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func gameViewController(_ viewController: GameViewController, didEndGameWith result: Int)
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var currentQuestionNumber: UILabel!
    @IBOutlet weak var gamePassPercentage: UILabel!
    
    private var buttons: [UIButton] = []
    
    @IBAction func onTouchAnswerButton(_ sender: UIButton) {
        guard let isGameNotEnded = gameSession?.checkAnswer(answerIndex: sender.tag) else { return }
        if isGameNotEnded {
            setNextQuestion()
        }
    }
    
    @IBAction func onTouchGet2x2HintButton(_ sender: UIButton) {
        guard let incorrectAnsvers = gameSession?.get2x2Hint() else { return }
        sender.isEnabled = false
        sender.setTitleColor(.systemRed, for: .disabled)
        buttons.forEach { $0.isEnabled = !incorrectAnsvers.contains($0.tag) }
    }
    
    weak var delegate: GameViewControllerDelegate?
    
    private var gameSession: GameSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [button1, button2, button3, button4]
        
        var questions = [
            Question(text: "Кто автор «Сказки о попе и работнике его Балде»?",
                     answerOptions: ["Лермонтов", "Пушкин", "Крылов", "Достоевский"],
                     correctAnswerIndex: 1),
            Question(text: "Исполнитель роли Бендера в «Золотом теленке»?",
                     answerOptions: ["Миронов", "Папанов", "Гомиашвили", "Юрский"],
                     correctAnswerIndex: 3),
            Question(text: "За чем послала жена мужа в мультфильме «Падал прошлогодний снег»?",
                     answerOptions: ["Подснежниками", "Спичками", "Ёлкой", "Дровами"],
                     correctAnswerIndex: 2),
            Question(text: "Где, если верить пословице, любопытной Варваре нос оторвали?",
                     answerOptions: ["На базаре", "На фонтане", "На лавке", "На печке"],
                     correctAnswerIndex: 0),
            Question(text: "Что говорит человек, когда замечает нечто необычное?",
                     answerOptions: ["Попало в лоб", "Залетело в рот", "Накапало в уши", "Бросилось в глаза"],
                     correctAnswerIndex: 3)
        ]
        questions.append(contentsOf: Game.shared.userQuestions)

        let gameStrategiesFacade = GameStrategiesFacade(questionOrder: Game.shared.settings.questionOrder)
        
        gameSession = GameSession(questions: questions, gameStrategiesFacade: gameStrategiesFacade)
        gameSession?.gameDelegate = self
        
        gameSession?.questionNumber.addObserver(self,
                                                options: [.initial, .new],
                                                closure: { [weak self] value, _ in
                                                    self?.currentQuestionNumber.text = "Вопрос номер \(value)"
                                                })
        gameSession?.gamePassPercentage.addObserver(self,
                                                    options: [.initial, .new],
                                                    closure: { [weak self] value, _ in
                                                        self?.gamePassPercentage.text = "Игра пройдена на \(value)%"
                                                    })
        
        Game.shared.session = gameSession
        
        setNextQuestion()
    }
    
    private func setNextQuestion() {
        guard let question = gameSession?.getNextQuestion() else { return }
        buttons.forEach { $0.isEnabled = true }
        questionTextLabel.text = question.text
        button1.setTitle(question.answerOptions[0], for: .normal)
        button2.setTitle(question.answerOptions[1], for: .normal)
        button3.setTitle(question.answerOptions[2], for: .normal)
        button4.setTitle(question.answerOptions[3], for: .normal)
    }

}

extension GameViewController: GameSessionDelegate {
    func endGame(with result: Int) {
        delegate?.gameViewController(self, didEndGameWith: result)
    }
}
