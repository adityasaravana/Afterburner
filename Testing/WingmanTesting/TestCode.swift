// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
//
// TestCode.swift
// XCExtensionTesting
//
//  Created by Aditya Saravana on 3/2/23.
//

import Foundation

// Can you convert this JSON code to a Swift class?

//{
//   "id":"chatcmpl-abc123",
//   "object":"chat.completion",
//   "created":1677858242,
//   "model":"gpt-3.5-turbo-0301",
//   "usage":{
//      "prompt_tokens":13,
//      "completion_tokens":7,
//      "total_tokens":20
//   },
//   "choices":[
//      {
//         "message":{
//            "role":"assistant",
//            "content":"\n\nThis is a test!"
//         },
//         "finish_reason":"stop",
//         "index":0
//      }
//   ]
//}

struct ChatCompletion: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let usage: Usage
    let choices: [Choice]
    
    struct Usage: Codable {
        let promptTokens: Int
        let completionTokens: Int
        let totalTokens: Int
    }
    
    struct Choice: Codable {
        let message: Message
        let finishReason: String
        let index: Int
        
        struct Message: Codable {
            let role: String
            let content: String
        }
    }
}
