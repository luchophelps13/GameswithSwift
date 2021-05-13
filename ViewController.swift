//
//  ViewController.swift
//  tictactoe
//
//  Created by period2 on 4/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    
    var labels:[UILabel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearLabels()
        for i in 0...labels.count - 1{
            if i % 2 == 0{
                labels[i].backgroundColor = .blue
            }
            else{
                labels[i].backgroundColor = .green
            }
        }
        
        
    }
    
    func clearLabels(){
        labels = [label1, label2, label3, label4, label5, label6, label7, label8, label9]
        
        for label in labels{
            label.text = ""
        }
        
        winnerLabel.text = "No Winner Yet"
        
        turnLabel.text = "X"
    }
    
    
    func checkForWinner() {
        
        if label1.text == label2.text && label1.text == label3.text && label2.text == label3.text && label1.text != "" {
                if label1.text == "X" {
                    winnerLabel.text = "X Wins!"
                    alert()
                }
                else {
                    winnerLabel.text = "O Wins!"
                    alert()
                }
        }
        
        else if label1.text == label4.text && label7.text == label1.text && label7.text == label4.text && label1.text != "" {
                if label1.text == "X" && label1.text != "" {
                    winnerLabel.text = "X Wins!"
                    alert()
                }
                else {
                    winnerLabel.text = "O Wins!"
                    alert()
                }
        }
        
        else if label1.text == label5.text && label9.text == label1.text && label5.text == label9.text && label1.text != "" {
                if label1.text == "X" {
                    winnerLabel.text = "X Wins!"
                    alert()
                }
                else{
                    winnerLabel.text = "O Wins!"
                    alert()
                }
        }
        
        else if label2.text == label5.text && label8.text == label5.text && label8.text == label2.text && label2.text != "" {
                if label2.text == "X" {
                    winnerLabel.text = "X Wins!"
                    alert()
                }
                else{
                    winnerLabel.text = "O Wins!"
                    alert()
                }
        }
        
        else if label3.text == label6.text && label6.text == label9.text && label3.text == label9.text && label3.text != "" {
                if label3.text == "X" {
                    winnerLabel.text = "X Wins!"
                    alert()
                }
                else {
                    winnerLabel.text = "O Wins!"
                    alert()
                }
        }
        
        else if label3.text == label5.text && label5.text == label7.text && label3.text == label7.text && label3.text != "" {
                if label3.text == "X" {
                    winnerLabel.text = "X Wins!"
                    alert()
                }
                else {
                    winnerLabel.text = "O Wins!"
                    alert()
                }
        }
        
        else if label4.text == label5.text && label5.text == label6.text && label6.text == label4.text && label4.text != "" {
                if label4.text == "X" {
                    winnerLabel.text = "X Wins!"
                    alert()
                }
                else {
                    winnerLabel.text = "O Wins!"
                    alert()
                }
        }
        
        else if label7.text == label8.text && label8.text == label9.text && label7.text == label9.text && label7.text != "" {
                if label1.text == "X" {
                    winnerLabel.text = "X Wins!"
                    alert()
                }
                else{
                    winnerLabel.text = "O Wins!"
                    alert()
                }
        }

    }
    
    @IBAction func clear(_ sender: UIButton) {
        clearLabels()
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        
        let point = sender.location(in: myView)
        for label in labels{
            
            if label.frame.contains(point) {
                placeIntoLabel(myLabel: label)
            }
        }
        
        checkForWinner()
        
    }
    
    func placeIntoLabel(myLabel: UILabel){
    
        
        if myLabel.text == "" { // first check if Label is empty
            
            
            if turnLabel.text == "X" { // if it's X's turn, place in an X and switch to O's turn
                myLabel.text = "X"
                turnLabel.text = "O"
            }
            
            else {
                myLabel.text = "O"
                turnLabel.text = "X"
            }
            
        }
        
    }
    
    func alert(){
        
        let winner = String(winnerLabel.text!.split(separator: " ")[0])
        
        let winnerAlert = UIAlertController(title: "Winner", message: winner + " Won!", preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "Exit", style: .cancel) { (btn) in
            self.clearLabels()
        }
        
        winnerAlert.addAction(closeButton)
        
        present(winnerAlert, animated: true, completion: nil)
    

    }
}


