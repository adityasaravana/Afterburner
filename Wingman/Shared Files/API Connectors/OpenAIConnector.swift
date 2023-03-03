//
//  OpenAIConnector.swift
//  Wingman for Xcode
//
//  Created by Aditya Saravana on 2/1/23.
//

//import Foundation
//import OpenAISwift
//
//struct OpenAIConnector {
//    let openAI = OpenAISwift(authToken: "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")
//    
//    func sendRequest(_ input: String) {
//        openAI.sendCompletion(with: input, model: .codex(.davinci)) { result in // Result<OpenAI, OpenAIError>
//            // switch on result to get the response or error
//            switch result {
//            case .success(let success):
//                print(success.choices.first?.text ?? "ERROR NO FIRST CHOICE FROM API OUTPUT - OPENAICONNECTOR LINE 19")
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//       
//        
//        
//    }
//}

import Foundation

struct OpenAIResponseHandler {
    func decodeJson(jsonString: String) -> OpenAIResponse? {
        let json = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let product = try decoder.decode(OpenAIResponse.self, from: json)
            return product
            
        } catch {
            print("Error decoding OpenAI API Response")
        }
        
        return nil
    }
}

struct OpenAIResponse: Codable {
    var id: String
    var object: String
    var created: Int
    var model: String
    var choices: [Choice]
}

struct Choice: Codable {
    var text: String
    var index: Int
    var logprobs: String?
    var finish_reason: String
}

//public class OpenAIConnectorOld {
//    let openAIURL = URL(string: "https://api.openai.com/v1/engines/code-davinci-edit-001/completions")
//    var openAIKey = "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"
//
//    private func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?) -> Data? {
//        let semaphore = DispatchSemaphore(value: 0)
//        let session: URLSession
//        if (sessionConfig != nil) {
//            session = URLSession(configuration: sessionConfig!)
//        } else {
//            session = URLSession.shared
//        }
//        var requestData: Data?
//        let task = session.dataTask(with: request as URLRequest, completionHandler:{ (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            if error != nil {
//                print("error: \(error!.localizedDescription): \(error!.localizedDescription)")
//            } else if data != nil {
//                requestData = data
//            }
//
//            print("Semaphore signalled")
//            semaphore.signal()
//        })
//        task.resume()
//
//        // Handle async with semaphores. Max wait of 10 seconds
//        let timeout = DispatchTime.now() + .seconds(20)
//        print("Waiting for semaphore signal")
//        let retVal = semaphore.wait(timeout: timeout)
//        print("Done waiting, obtained - \(retVal)")
//        return requestData
//    }
//
//    private func sendPrompt(_ prompt: String) -> Optional<String> {
//
//        var request = URLRequest(url: self.openAIURL!)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
//        let httpBody: [String: Any] = [
//            //            #error("reconfigure OpenAIConnector for Codex Edit and Codex Insert")
//            "input" : prompt,
//
//            //            "temperature": String(temperature)
//        ]
//
//        var httpBodyJson: Data
//
//        do {
//            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
//        } catch {
//            print("Unable to convert to JSON \(error)")
//            return nil
//        }
//        request.httpBody = httpBodyJson
//        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
//            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//            print(jsonStr)
//            let responseHandler = OpenAIResponseHandler()
//            return responseHandler.decodeJson(jsonString: jsonStr)?.choices[0].text
//
//        }
//
//        return nil
//    }
//
//    public func processPrompt(_ prompt: String) -> Optional<String> {
//        return sendPrompt(prompt)
//    }
//}


public class OpenAIConnector {
    let codexEditURL = URL(string: "https://api.openai.com/v1/engines/code-davinci-edit-001/completions")
    let textDavinciURL = URL(string: "https://api.openai.com/v1/engines/text-davinci-003/completions")
    let openAIKey = User.sharedInstance.apiKey
    
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
    
//    func processCodexEdit(file: String, instructions: String) -> Optional<String> {
//
//        var request = URLRequest(url: self.codexEditURL!)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
//        let httpBody: [String: Any] = [
//            "input": file,
//            "instruction": instructions,
//        ]
//
//        var httpBodyJson: Data
//
//        do {
//            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
//        } catch {
//            print("Unable to convert to JSON \(error)")
//            return nil
//        }
//        request.httpBody = httpBodyJson
//        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
//            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//            print(jsonStr)
//            let responseHandler = OpenAIResponseHandler()
//            return responseHandler.decodeJson(jsonString: jsonStr)?.choices[0].text
//
//        }
//
//        return nil
//    }

    
    func processDavinci(_ prompt: String) -> Optional<String> {
        
        var request = URLRequest(url: self.textDavinciURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        let httpBody: [String: Any] = [
            "prompt" :
            """
            // Swift 5
            \(prompt)
            """,
            "temperature" : 0.7,
            "max_tokens" : 180
        ]
        
        var httpBodyJson: Data
        
        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error)")
            return nil
        }
        request.httpBody = httpBodyJson
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print(jsonStr)
            let responseHandler = OpenAIResponseHandler()
            return responseHandler.decodeJson(jsonString: jsonStr)?.choices[0].text
            
        }
        
        return nil
    }
}


