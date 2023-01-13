//
//  Questions.swift
//  Personality Quiz
//
//  Created by Vaughn Angoy on 09/01/2023.
//

import Foundation

enum ResponseType {
    case single, multiple, ranged
}

enum AnimalType: Character {
    case dog = "🐶", panda = "🐼", lion = "🦁", frog = "🐸"
    
    var definition: String {
        switch self {
        case .dog:
            return "You are increadably outgoing, a proud follower that like to take the lead"
        case .panda:
            return "Playful blighter is the type of person you are! Soft and cuddly with a laid back atitude to life"
        case .lion:
            return "Dominant whenn it comes to taking the lead, but lazy when it comes to making food"
        case .frog:
            return "Proper people watcher. You like to sit and take in the view but definitely will jump in and get involved"
        }
    }
}

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

struct Answer {
    var text: String
    var type: AnimalType
}

