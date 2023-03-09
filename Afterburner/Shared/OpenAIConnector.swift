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
    let openAIURL = URL(string: "https://api.openai.com/v1/engines/text-davinci-003/completions")
    var openAIKey = ""
    
    // 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
    
    init() {
        if DataManager().readValue("OPENAIKEY") == nil {
            let manager = DataManager()
            manager.writeValue("", key: "OPENAIKEY")
            manager.writeValue("", key: "MAXTOKENS")
            
            openAIKey = DataManager().readValue("OPENAIKEY")!
        }
    }
    
    func burn_swift(_ prompt: String) -> Optional<String> {
        return processDavinci(prompt, language: .swift)
    }
    
    func burn_objectiveC(_ prompt: String) -> Optional<String> {
        return processDavinci(prompt, language: .objective_c)
    }
}


