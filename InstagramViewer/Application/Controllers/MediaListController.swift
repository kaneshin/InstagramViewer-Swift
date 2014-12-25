// MediaListController.swift
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

class MediaListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MediaModel.getPopular({ (media) -> Void in
            self.tableView.reloadData()
            self.tableView.setNeedsLayout()
        }, failure: { (error) -> Void in
            self.tableView.reloadData()
            self.tableView.setNeedsLayout()
        })

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let screenName = reflect(self).summary
        AnalyticsUtils.trackView(screenName)
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let media = MediaModel.sharedInstance.mediaList[indexPath.row] as Media
                (segue.destinationViewController as DetailViewController).media = media
            }
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaModel.sharedInstance.mediaList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as MediaListCell
        let media = MediaModel.sharedInstance.mediaList[indexPath.row]
        return cell.configure(media)
    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let media = MediaModel.sharedInstance.mediaList[indexPath.row]
        return MediaListCell.heightForRow(media)
    }

}
