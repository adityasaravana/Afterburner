//
//  OpenAIValidator.swift
//  Afterburner 
//
//  Created by Aditya Saravana on 7/25/23.
//

import Foundation
import Combine

class OpenAIValidator {
    let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")
    let dataManager = DataManager()
    var openAIKey: String
    
    init(openAIKey: String) {
        self.openAIKey = openAIKey
        
        logMessage("VALIDATION MSG", messageUserType: .user)
    }
    
    var messageLog: [[String: String]] = [
        ["role": "system", "content": "You're a validation service for the OpenAI API. If the validation message below reaches you, respond in a friendly manner."]
    ]
    
    func validate(onboarding: Bool = false) -> String {
        var request = URLRequest(url: self.openAIURL!)
        var errorMessage = "There was an issue validating your OpenAI API key."
        if !onboarding {
            errorMessage += " Try validating again and using the Xcode extension."
        }
        errorMessage += " If that doesn't work, email aditya.saravana@icloud.com for help."
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        
        let httpBody: [String: Any] = [
            /// In the future, you can use a different chat model here.
            "model" : "gpt-3.5-turbo",
            "messages" : messageLog
        ]
        
        var httpBodyJson: Data? = nil
        
        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            return "⚠️ \(errorMessage) | DEBUG DESCRIPTION: Error converting to JSON: \(error). Caught at OpenAIValidator.validate. ⚠️"
        }
        
        request.httpBody = httpBodyJson
        
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print(jsonStr)
            let responseHandler = OpenAIResponseHandler()
            return (responseHandler.decodeJson(jsonString: jsonStr)?.choices[0].message["content"])!
        } else {
            return "⚠️ \(errorMessage) | DEBUG DESCRIPTION: OpenAIValidator.validate.requestData was nil. ⚠️"
        }
    }
}


extension OpenAIValidator {
    private func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        let session: URLSession
        if (sessionConfig != nil) {
            session = URLSession(configuration: sessionConfig!)
        } else {
            session = URLSession.shared
        }
        var requestData: Data?
        let task = session.dataTask(with: request as URLRequest, completionHandler:{ (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error != nil {
                print("error: \(error!.localizedDescription): \(error!.localizedDescription)")
            } else if data != nil {
                requestData = data
            }
            
            print("Semaphore signalled")
            semaphore.signal()
        })
        task.resume()
        
        // Handle async with semaphores. Max wait of 10 seconds
        let timeout = DispatchTime.now() + .seconds(20)
        print("Waiting for semaphore signal")
        let retVal = semaphore.wait(timeout: timeout)
        print("Done waiting, obtained - \(retVal)")
        return requestData
    }
}

extension OpenAIValidator {
    /// This function makes it simpler to append items to messageLog.
    func logMessage(_ message: String, messageUserType: MessageUserType) {
        var messageUserTypeString = ""
        switch messageUserType {
        case .user:
            messageUserTypeString = "user"
        case .assistant:
            messageUserTypeString = "assistant"
        }
        
        messageLog.append(["role": messageUserTypeString, "content": message])
    }
    
    enum MessageUserType {
        case user
        case assistant
    }
}


