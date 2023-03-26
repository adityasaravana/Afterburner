//
//  OpenAIConnector.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import Foundation

public enum AfterburnerLanguage {
    case swift
    case objective_c
}

public class OpenAIConnector {
    let defaults = UserDefaults(suiteName: "afterburner.settings")
    let openAIURL = URL(string: "https://api.openai.com/v1/engines/text-davinci-003/completions")
    var openAIKey: String {
        return defaults?.string(forKey: "APIKEY") ?? "invalid"
    }
    
    #warning("get rid of this before distributing")
    // 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
    
    func burn_swift(_ prompt: String) -> Optional<String> {
        print("-----------------")
        print("OPENAIKEY:")
        print(openAIKey)
        print("----------------")
        return processDavinci(prompt, language: .swift)
    }
    
    func burn_objectiveC(_ prompt: String) -> Optional<String> {
        return processDavinci(prompt, language: .objective_c)
    }
}


