// MediaListCell.swift
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

class MediaListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.numberOfLines = 0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView!.image = nil
        self.textLabel?.text = nil
    }

    class func heightForRow(media: Media) -> CGFloat {
        return 100.0
    }

    func configure(media: Media) -> MediaListCell {
        self.textLabel?.text = media.caption?.text
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let data = NSData(contentsOfURL: media.thumbnailURL!)
            dispatch_sync(dispatch_get_main_queue(), {
                self.imageView!.image = UIImage(data: data!, scale: UIScreen.mainScreen().scale)
                self.setNeedsLayout()
            })
        })
        return self
    }

}
