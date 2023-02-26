//
//  GumroadConnector.swift
//  Wingman for Xcode
//
//  Created by Aditya Saravana on 2/10/23.
//

import Foundation

public class GumroadConnector {
    let gumroadAPIURL = URL(string: "https://api.gumroad.com/v2/licenses/verify")
    
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

    
    func validateKey(_ customerLicenseKey: String) -> Bool {
        
        var request = URLRequest(url: self.gumroadAPIURL!)
        request.httpMethod = "POST"
        
        let httpBody: [String: Any] = [
            "product_id" : "bRm-VoI49soIdeGnXAcZsQ==",
            "license_key" : customerLicenseKey
        ]
        
        var httpBodyJson: Data
        
        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error)")
            return false
        }
        
        request.httpBody = httpBodyJson
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print(jsonStr)
           
            /// Output and return
            let responseHandler = GumroadResponseHandler()
            return responseHandler.decodeJson(jsonString: jsonStr)?.success ?? false
            
        }
        
        return false
    }
}


private struct GumroadResponseHandler {
    func decodeJson(jsonString: String) -> GumroadResponse? {
        let json = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let product = try decoder.decode(GumroadResponse.self, from: json)
            return product
            
        } catch {
            print("Error decoding Gumroad API Response")
        }
        
        return nil
    }
}

private struct GumroadResponse: Decodable {
    var success: Bool
   
    private enum CodingKeys: String, CodingKey {
        case success
    }
}

//{
//  "success": true,
//  "uses": 3,
//  "purchase": {
//    "seller_id": "kL0psVL2admJSYRNs-OCMg==",
//    "product_id": "32-nPAicqbLj8B_WswVlMw==",
//    "product_name": "licenses demo product",
//    "permalink": "QMGY",
//    "product_permalink": "https://sahil.gumroad.com/l/pencil",
//    "email": "customer@example.com",
//    "price": 0,
//    "gumroad_fee": 0,
//    "currency": "usd",
//    "quantity": 1,
//    "discover_fee_charged": false,
//    "can_contact": true,
//    "referrer": "direct",
//    "card": {
//      "visual": null,
//      "type": null
//    },
//    "order_number": 524459935,
//    "sale_id": "FO8TXN-dbxYaBdahG97Y-Q==",
//    "sale_timestamp": "2021-01-05T19:38:56Z",
//    "purchaser_id": "5550321502811",
//    "subscription_id": "GDzW4_aBdQc-o7Gbjng7lw==",
//    "variants": "",
//    "license_key": "85DB562A-C11D4B06-A2335A6B-8C079166",
//    "is_multiseat_license": false,
//    "ip_country": "United States",
//    "recurrence": "monthly",
//    "is_gift_receiver_purchase": false,
//    "refunded": false,
//    "disputed": false,
//    "dispute_won": false,
//    "id": "FO8TXN-dvaYbBbahG97a-Q==",
//    "created_at": "2021-01-05T19:38:56Z",
//    "custom_fields": [],
//    "chargebacked": false, # purchase was refunded, non-subscription product only
//    "subscription_ended_at": null, # subscription was ended, subscription product only
//    "subscription_cancelled_at": null, # subscription was cancelled, subscription product only
//    "subscription_failed_at": null # we were unable to charge the subscriber's card
//  }
//}


