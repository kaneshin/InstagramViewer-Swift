// MediaModel.swift
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

import SwiftyJSON

struct Caption {
    var username: String?
    var text: String?
}

struct Media {
    var thumbnailURL: NSURL?
    var imageURL: NSURL?
    var caption: Caption?
}

func parseMedia(json: JSON) -> Media {
    var caption = Caption(
        username: json["caption"]["from"]["username"].string,
        text:     json["caption"]["text"].string
    )
    var media = Media(
        thumbnailURL: json["images"]["thumbnail"]["url"].URL,
        imageURL:     json["images"]["standard_resolution"]["url"].URL,
        caption:      caption
    )
    return media
}

class MediaModel: NSObject {

    var mediaList: [Media] = []

    class var sharedInstance: MediaModel {
        struct Singleton {
            static let instance = MediaModel()
        }
        return Singleton.instance
    }

    class func getPopular(success: (([Media]) -> Void)?, failure: ((NSError?) -> Void)?) {
        MediaRequest.getPopular({ (json) -> Void in
            MediaModel.sharedInstance.mediaList = []
            if let array = json["data"].array {
                array.map({ (elm: JSON) -> Void in
                    MediaModel.sharedInstance.mediaList.append(parseMedia(elm))
                })
                success?(MediaModel.sharedInstance.mediaList)
            } else {
                failure?(nil)
            }
        }, failure: { (error) -> Void in
            failure?(error)
            return
        })
    }

}
