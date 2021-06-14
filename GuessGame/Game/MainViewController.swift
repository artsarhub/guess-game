//
//  ViewController.swift
//  GuessGame
//
//  Created by Артём Сарана on 13.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? GameViewController else { return }
        vc.delegate = self
    }
}

extension MainViewController: GameViewControllerDelegate {
    func gameViewController(_ viewController: GameViewController, didEndGameWith result: Int) {
        viewController.dismiss(animated: true)
    }
}

