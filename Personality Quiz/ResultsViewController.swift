//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by Vaughn Angoy on 09/01/2023.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    var responses: [Answer]
    
    init?(coder:NSCoder, responses: [Answer]){
        self.responses = responses
        super.init(coder:coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult() {
        let frequencyOfAnswers = responses.reduce(into: [:]) {
            (counts, answer) in
            counts[answer.type, default: 0] += 1
        }
        
        let mostCommonAnswer = frequencyOfAnswers.sorted{$0.1 > $1.1}.first!.key
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
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
