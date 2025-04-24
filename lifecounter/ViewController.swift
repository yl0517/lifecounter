//
//  ViewController.swift
//  lifecounter
//
//  Created by Yoobin Lee on 4/19/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var p1plus: UIButton!
    @IBOutlet var p1minus: UIButton!
    @IBOutlet var p1DeltaField: UITextField!
    @IBOutlet var p1ApplyButton: UIButton!
 
    @IBOutlet var p2plus: UIButton!
    @IBOutlet var p2minus: UIButton!
    @IBOutlet var p2plus5: UIButton!
    @IBOutlet var p2minus5: UIButton!
    
    @IBOutlet var player1LifeLabel: UILabel!
    @IBOutlet var player2LifeLabel: UILabel!
    @IBOutlet var loseLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("player1LifeLabel is", player1LifeLabel as Any)
        print("player2LifeLabel is", player2LifeLabel as Any)
        
        p1plus.tag = 1
        p1minus.tag = -1
        
        p2plus.tag = 1
        p2minus.tag = -1
        p2plus5.tag = 5
        p2minus5.tag = -5
        
        loseLabel.textColor = .red
        loseLabel.font = UIFont.boldSystemFont(ofSize: 36)
        loseLabel.textAlignment = .center
        loseLabel.isHidden = true
        
        updateLabels()
    }
    
    @IBAction func player1ButtonTapped(_ sender: UIButton) {
        print("tapped Player 1 button “\(sender.currentTitle ?? "?")”")
        adjustLife(for: 1, button: sender)
    }
    
    @IBAction func p1ApplyTapped(_ sender: UIButton) {
        guard let text = p1DeltaField.text, let delta = Int(text) else { return }
        adjustLife(for: 1, delta: delta)
        p1DeltaField.resignFirstResponder()
    }

    @IBAction func player2ButtonTapped(_ sender: UIButton) {
        print("tapped Player 2 button “\(sender.currentTitle ?? "?")”")
        adjustLife(for: 2, button: sender)
    }

    var player1Life = 20
    var player2Life = 20
    
    func updateLabels() {
        player1LifeLabel.text = "Life: \(player1Life)"
        player2LifeLabel.text = "Life: \(player2Life)"

        if player1Life <= 0 {
            loseLabel.text = "Player 1 LOSES!"
            loseLabel.isHidden = false
        } else if player2Life <= 0 {
            loseLabel.text = "Player 2 LOSES!"
            loseLabel.isHidden = false
        } else {
            loseLabel.text = ""
            loseLabel.isHidden = true
        }
    }

    func adjustLife(for player: Int, button: UIButton) {
        let delta = button.tag

        if player == 1 {
            player1Life += delta
        } else {
            player2Life += delta
        }

        updateLabels()
    }
    
    func adjustLife(for player: Int, delta: Int) {
        if player == 1 {
            player1Life += delta
        } else {
            player2Life += delta
        }
        updateLabels()
    }
}

