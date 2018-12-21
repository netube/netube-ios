//
// -------------------------------------------------------------------------
// Copyright 2018 Bing Djeung
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// -------------------------------------------------------------------------
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
        
        private let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
                let homeNavigationController: UINavigationController = UINavigationController()
                homeNavigationController.viewControllers = [HomeTableViewController()]
                homeNavigationController.tabBarItem = UITabBarItem(title: LocalText.Home, image: UIImage(named: "HomeTabBarItem"), tag: 0)
                
                let rulesNavigationController: UINavigationController = UINavigationController()
                rulesNavigationController.viewControllers = [RulesTableViewController()]
                rulesNavigationController.tabBarItem = UITabBarItem(title: LocalText.Rules, image: UIImage(named: "RulesTabBarItem"), tag: 0)
                
                let dataNavigationController: UINavigationController = UINavigationController()
                dataNavigationController.viewControllers = [DataTableViewController()]
                dataNavigationController.tabBarItem = UITabBarItem(title: LocalText.Data, image: UIImage(named: "DataTabBarItem"), tag: 0)
                
                let settingsNavigationController: UINavigationController = UINavigationController()
                settingsNavigationController.viewControllers = [SettingsTableViewController()]
                settingsNavigationController.tabBarItem = UITabBarItem(title: LocalText.Settings, image: UIImage(named: "SettingsTabBarItem"), tag: 0)
                
                let tabBarController: UITabBarController = UITabBarController()
                tabBarController.viewControllers = [homeNavigationController, rulesNavigationController, dataNavigationController, settingsNavigationController]
                tabBarController.tabBar.tintColor = UIColor.primary
                
                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
                
                return true
        }
}
