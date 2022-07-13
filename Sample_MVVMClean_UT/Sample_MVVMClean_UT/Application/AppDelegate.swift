import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appFlowCoordinator: AppFlowCoordinator?
    let appDIContainer = AppDIContainer()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
        
        /// Set Navigation bar appearance
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(red: 48/255.0, green: 176/255.0, blue: 199/255.0, alpha: 1.0)
            UINavigationBar.appearance().standardAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = UIColor(red: 48/255.0, green: 176/255.0, blue: 199/255.0, alpha: 1.0)
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        return true
    }
}

