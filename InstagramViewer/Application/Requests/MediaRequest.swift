// MediaRequest.swift
//
// Copyright (c) 2014 __MyCompanyName__
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import Alamofire
import SwiftyJSON

class MediaRequest: NSObject {

    class func getPopular(success: ((JSON) -> Void)?, failure: ((NSError?) -> Void)?) {
        let urlString = "https://api.instagram.com/v1/media/popular"
        let param = ["client_id": "<#CLIENT-ID#>"]
        let req = request(.GET, urlString, parameters: param)
        req.response { (request, response, responseData, error) -> Void in
            if error == nil {
                if let data = responseData as? NSData {
                    let json = JSON(data: data)
                    success?(json)
                } else {
                    failure?(nil)
                }
            } else {
                failure?(error)
            }
        }
    }

}
