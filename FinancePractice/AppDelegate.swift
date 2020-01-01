//
//  AppDelegate.swift
//  FinancePractice
//
//  Created by Karthik M S on 01/01/20.
//  Copyright © 2020 Zoho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	private let coreDataService = CoreDataService.shared

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//		coreDataService.addTestData()
		coreDataService.printCoreDataContents()
		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
		coreDataService.saveContext()
	}
}

