//
//  ViewController.swift
//  lifecounter
//
//  Created by Yoobin Lee on 4/19/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var loseLabel: UILabel!

    @IBOutlet var playerRows: [UIView]!
    @IBOutlet var lifeLabels: [UILabel]!         // “Life: XX”
    @IBOutlet var plusButtons: [UIButton]!       // +1
    @IBOutlet var minusButtons: [UIButton]!      // –1
    @IBOutlet var deltaFields: [UITextField]!    // numeric input
    @IBOutlet var applyButtons: [UIButton]!      // “Apply”
    @IBOutlet weak var addPlayerButton: UIButton!

    private var lifeTotals = [Int](repeating: 20, count: 8)
    private var currentPlayers = 2
    private var gameStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in currentPlayers..<playerRows.count {
            playerRows[i].isHidden = true
        }
        
        for i in 0..<playerRows.count {
            plusButtons[i].tag  = i + 1
            minusButtons[i].tag = -(i + 1)
            applyButtons[i].tag = i + 1
            deltaFields[i].delegate = self
            deltaFields[i].keyboardType = .numbersAndPunctuation
            deltaFields[i].text = "0"
        }
        
        updateAllLabels()
    }
    
    // MARK: – Add Player
    @IBAction func addPlayerTapped(_ sender: UIButton) {
      guard currentPlayers < playerRows.count else { return }
      playerRows[currentPlayers].isHidden = false
      lifeTotals[currentPlayers] = 20
      currentPlayers += 1
      updateAllLabels()

      if currentPlayers == playerRows.count {
        addPlayerButton.isEnabled = false
      }
    }

    // MARK: – +/– IBActions
    @IBAction func plusMinusTapped(_ sender: UIButton) {
      let idx = abs(sender.tag) - 1
      let delta = sender.tag > 0 ?  1 : -1
      adjustLife(at: idx, by: delta)
    }

    // MARK: – Apply IBActions
    @IBAction func applyTapped(_ sender: UIButton) {
      let idx = sender.tag - 1
      guard
        idx < deltaFields.count,
        let text = deltaFields[idx].text,
        let delta = Int(text)
      else { return }
      adjustLife(at: idx, by: delta)
      deltaFields[idx].resignFirstResponder()
    }

    // MARK: – Core Logic
    private func adjustLife(at idx: Int, by delta: Int) {
      // disable Add on first change
      if !gameStarted {
        gameStarted = true
        addPlayerButton.isEnabled = false
      }
      lifeTotals[idx] += delta
      updateAllLabels()
    }

    private func updateAllLabels() {
      for i in 0..<currentPlayers {
        let life = lifeTotals[i]
        lifeLabels[i].text = "Life: \(life)"
          if life <= 0 {
              loseLabel.text = "Player " + String(i + 1) + " LOSES!"
              loseLabel.isHidden = false
          }
      }
    }

    // MARK: – UITextFieldDelegate (restrict to digits & “-”)
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
      let allowed = CharacterSet(charactersIn: "-0123456789")
      return string.rangeOfCharacter(from: allowed.inverted) == nil
    }
}

