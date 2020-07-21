//
//  SelfAssessmentViewController.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-22.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import UIKit

class SelfAssessmentViewController: UIViewController {
    var index: Int = 0
    let questions: [String] = ["Are you experiencing any of the following symptoms?", "Do you have any of the following symptoms?", "Do any of the following apply to you?", "Have you travelled anywhere in the last 14 days?", "Has someone you are in close contact with tested positive for COVID-19?"]
    let questionsDescription: [String] = ["Severe difficult breathing (struggling for each breath), severe chest pain (constant tightness), losing conciousness.", "Fever, Chills, Cough (barking or getting worse), Shortness of breath, Sore throat, Runny Nose.", "I am 65 years old or older, I have a chronic health condition, I am getting treatment that affects immune system.", "Any where outside your country or within the country.", "For example, someone in your household or workplace."]
    var answers: [Int: Bool] = [0:false]
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true) {
            self.resignFirstResponder()
        }
    }
    
    @IBOutlet weak var questionLabel: UITextView!
    @IBOutlet weak var questionDescription: UITextView!
    @IBOutlet weak var paginationLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func yesButton(_ sender: Any) {
        if index < 4 {
            answers[index] = true
            index += 1
            updateView()
        } else {
            answers[index] = true
            checkResult()
        }
    }
    
    @IBAction func noButton(_ sender: Any) {
        if index < 4 {
            answers[index] = false
            index += 1
            updateView()
        } else {
            answers[index] = true
            checkResult()
        }
    }
    
    func checkResult() {
        if answers[0]! && answers[2]! && answers[3]! && answers[4]! {
            questionLabel.text = "You may be infected. Please call help."
            questionLabel.textColor = #colorLiteral(red: 0.7980980277, green: 0.3257266581, blue: 0.3257569075, alpha: 1)
            questionDescription.text = "Contact a doctor as soon as possible. Please wear a mask to prevent infecting others around you."
            paginationLabel.isHidden = true
            yesButton.isHidden = true
            noButton.isHidden = true
            cancelButton.titleLabel?.text = "Close"
        } else if answers[0]! && answers[4]! {
            questionLabel.text = "You may be infected."
            questionLabel.textColor = #colorLiteral(red: 0.7980980277, green: 0.3257266581, blue: 0.3257569075, alpha: 1)
            questionDescription.text = "Contact a doctor and do not panic. Please wear a mask to prevent infecting others around you."
            paginationLabel.isHidden = true
            yesButton.isHidden = true
            noButton.isHidden = true
            cancelButton.titleLabel?.text = "Close"
        } else {
            questionLabel.text = "You are fine."
            questionLabel.textColor = #colorLiteral(red: 0.253870219, green: 0.6325016022, blue: 0.4113356471, alpha: 1)
            questionDescription.text = "But avoid going in public and stay home as much as possible. Keep exercising in the neighbourhood but maintain at least 6 meters distance from others."
            paginationLabel.isHidden = true
            yesButton.isHidden = true
            noButton.isHidden = true
            cancelButton.titleLabel?.text = "Close"
        }
    }
    
    func updateView() {
        questionLabel.text = questions[index]
        questionDescription.text = questionsDescription[index]
        paginationLabel.text = "\(index + 1)/\(questions.count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
}
