//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Vaughn Angoy on 09/01/2023.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var ssvBtn1: UIButton!
    @IBOutlet var ssvBtn2: UIButton!
    @IBOutlet var ssvBtn3: UIButton!
    @IBOutlet var ssvBtn4: UIButton!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var msvLabel1: UILabel!
    @IBOutlet var msvLabel2: UILabel!
    @IBOutlet var msvLabel3: UILabel!
    @IBOutlet var msvLabel4: UILabel!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rsvLabel1: UILabel!
    @IBOutlet var rsvLabel2: UILabel!
    
    @IBOutlet var qtnLabel: UILabel!
    @IBOutlet var qtnProgressView: UIProgressView!
    
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet var rangedSlider: UISlider!
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    var answersChosen: [Answer] = []
    
    var questions: [Question] = [
      Question(
        text: "Which food do you like the most?",
        type: .single,
        answers: [
          Answer(text: "Steak", type: .dog),
          Answer(text: "Fish", type: .panda),
          Answer(text: "Carrots", type: .lion),
          Answer(text: "Corn", type: .frog)
        ]
      ),
      Question(
        text: "Which activities do you enjoy?",
        type: .multiple,
        answers: [
          Answer(text: "Swimming", type: .panda),
          Answer(text: "Sleeping", type: .lion),
          Answer(text: "Cuddling", type: .frog),
          Answer(text: "Eating", type: .dog)
        ]
      ),
      Question(
        text: "How much do you enjoy car rides?",
        type: .ranged,
        answers: [
          Answer(text: "I dislike them", type: .frog),
          Answer(text: "I get a little nervous", type: .lion),
          Answer(text: "I barely notice them", type: .panda),
          Answer(text: "I love them", type: .dog)
        ]
      )
    ]
    var questionIndex = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    fileprivate func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        ssvBtn1.setTitle(answers[0].text, for: .normal)
        ssvBtn2.setTitle(answers[1].text, for: .normal)
        ssvBtn3.setTitle(answers[2].text, for: .normal)
        ssvBtn4.setTitle(answers[3].text, for: .normal)
    }
    
    fileprivate func updateMultiStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        msvLabel1.text = answers[0].text
        msvLabel2.text = answers[1].text
        msvLabel3.text = answers[2].text
        msvLabel4.text = answers[3].text
    }
    
    fileprivate func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rsvLabel1.text = answers.first?.text
        rsvLabel2.text = answers.last?.text
    }
    
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
            qtnLabel.text = currentQuestion.text
            qtnProgressView.setProgress(totalProgress, animated:
                true)
      
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultiStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else{
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBAction func ssvBtnAction(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
            case ssvBtn1:
                answersChosen.append(currentAnswers[0])
            case ssvBtn2:
                answersChosen.append(currentAnswers[1])
            case ssvBtn3:
                answersChosen.append(currentAnswers[2])
            case ssvBtn4:
                answersChosen.append(currentAnswers[3])
            default:
                break
            }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
            if multiSwitch1.isOn {
                answersChosen.append(currentAnswers[0])
            }
            if multiSwitch2.isOn {
                answersChosen.append(currentAnswers[1])
            }
            if multiSwitch3.isOn {
                answersChosen.append(currentAnswers[2])
            }
            if multiSwitch4.isOn {
                answersChosen.append(currentAnswers[3])
            }
            
        nextQuestion()
        
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
            let index = Int(round(rangedSlider.value *
              Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        nextQuestion()
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
