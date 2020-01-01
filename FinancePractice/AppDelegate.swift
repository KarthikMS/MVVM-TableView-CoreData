import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	private let coreDataService = CoreDataService.shared

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
		coreDataService.saveContext()
	}
}

