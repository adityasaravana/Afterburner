//
//  OpenAIConnector.swift
//  Afterburner
//
//  Created by Aditya Saravana on 4/16/23.
//

import Foundation
import Combine

public enum AfterburnerLanguage {
    case swift
    case objective_c
}

class OpenAIConnector: ObservableObject {
    let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")
    let dataManager = DataManager()
    var openAIKey: String {
        print("DataManager returned nil for OPENAIKEY")
        return self.dataManager.pull(key: .openAIKey) ?? "DataManager returned nil for OPENAIKEY"
    }
    
    @Published var messageLog: [[String: String]] = [
        ["role": "system", "content": "You're Afterburner, an Xcode Extension that makes coding apps easier. Respond only in code, but make sure to add comments detailing what each part does."]
    ]
    
    func sendToAssistant() {
        /// DON'T TOUCH THIS
        var request = URLRequest(url: self.openAIURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        
        let httpBody: [String: Any] = [
            /// In the future, you can use a different chat model here.
            "model" : "gpt-3.5-turbo",
            "messages" : messageLog
        ]
        
        /// DON'T TOUCH THIS
        var httpBodyJson: Data? = nil
        
        do {
            //            httpBodyJson = try JSONEncoder().encode(httpBody)
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error)")
            logMessage("error", messageUserType: .assistant)
        }
        
        request.httpBody = httpBodyJson
        
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print(jsonStr)
            let responseHandler = OpenAIResponseHandler()
            logMessage((responseHandler.decodeJson(jsonString: jsonStr)?.choices[0].message["content"])!, messageUserType: .assistant)
        }
    }
    
    
    func burn_swift(_ prompt: String) -> Optional<String> {
        self.logMessage(
"""
// Swift 5

"""     + prompt, messageUserType: .user)
        self.sendToAssistant()
        return messageLog[2]["content"]
    }
    
    func burn_objectiveC(_ prompt: String) -> Optional<String> {
        self.logMessage(
"""
// Objective-C

"""     + prompt, messageUserType: .user)
        self.sendToAssistant()
        return messageLog[2]["content"]
    }
}

extension Dictionary: Identifiable { public var id: UUID { UUID() } }
extension Array: Identifiable { public var id: UUID { UUID() } }
extension String: Identifiable { public var id: UUID { UUID() } }

extension OpenAIConnector {
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

extension OpenAIConnector {
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


