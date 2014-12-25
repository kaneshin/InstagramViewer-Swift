//
//  AppDelegate.swift
//  InstagramViewer
//
//  Created by Shintaro Kaneko on 12/24/14.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override class func initialize() {
        AnalyticsUtils.setupGoogleAnalytics()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }


}

