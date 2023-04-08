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
    let dataManager = DataManager()
    var openAIKey: String {
        print("DataManager returned nil for OPENAIKEY")
        return self.dataManager.pull(key: .Afterburner_UserOpenAIKey) ?? "DataManager returned nil for OPENAIKEY"
    }
    
    func burn_swift(_ prompt: String) -> Optional<String> {
        return processDavinci(prompt, language: .swift)
    }
    
    func burn_objectiveC(_ prompt: String) -> Optional<String> {
        return processDavinci(prompt, language: .objective_c)
    }
}


