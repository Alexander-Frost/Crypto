//
//  CryptexViewController.swift
//  Crypto
//
//  Created by Alex on 5/1/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Constants
    
    var cryptexController = CryptexController()
    var countdownTimer: Timer?
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    // MARK: Outlets
    
    @IBOutlet var myLbl: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var myBtn: UIButton!
    
    
    @IBAction func myBtnPressed(_ sender: UIButton) {
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        newCryptexAndReset()
    }
    
    // MARK: Pickerview
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        return cryptexController.currentCryptex?.password.count ?? 0

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }

    // MARK: Functions
    
    func updateViews(){
        guard let myHint = cryptexController.currentCryptex else { return }
        myLbl.text = myHint.hint
        
        // reload components of the picker view below
        pickerView.reloadAllComponents() // may be incorrect
    }
    
    func hasMatchingPassword() -> Bool {
        
        guard let dataSource = pickerView.dataSource else { return false }
        guard let delegate = pickerView.delegate else { return false }
        let numOfChars = dataSource.numberOfComponents(in: pickerView)
        var myWord = "" // treat string as array
        
        
        for index in 0..<numOfChars {
            let selectedRow = pickerView.selectedRow(inComponent: index)
            if let letter = delegate.pickerView?(pickerView, titleForRow: selectedRow, forComponent: index) {
                myWord += letter
            }
        }
        
        return myWord.lowercased() == cryptexController.currentCryptex?.password.lowercased()
    }
    
    func reset(){
        
        if let timer = countdownTimer {
            timer.invalidate()
        }
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { (_) in
            self.presentNoTimeRemainingAlert()
        })
        
    }
    
    func newCryptexAndReset(){
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    func presentCorrectPasswordAlert(){
        let alert = UIAlertController(title: "Congratulations!", message: "You solved the puzzle", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Start Over", style: .default, handler: { (_) in
            self.newCryptexAndReset()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func presentIncorrectPasswordAlert(){
        let alert = UIAlertController(title: "Sorry!", message: "You entered an incorrect answer", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        alert.addAction(UIAlertAction(title: "Start Over", style: .default, handler: { (_) in
            self.newCryptexAndReset()
        }))
        
        present(alert, animated: true, completion: nil)

    }
    
    func presentNoTimeRemainingAlert(){
        let alert = UIAlertController(title: "No Time!", message: "You have run out of time.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.newCryptexAndReset()
        }))
        alert.addAction(UIAlertAction(title: "Start Over", style: .default, handler: { (_) in
            self.newCryptexAndReset()
        }))
        
        present(alert, animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
