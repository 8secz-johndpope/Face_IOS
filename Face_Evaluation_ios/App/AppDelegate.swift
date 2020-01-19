//
//  AppDelegate.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 07/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Firebase
import FirebaseMessaging
import KYDrawerController
@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

    let disposeBag = DisposeBag()
    var window: UIWindow?
    var coordinator = FlowCoordinator()
    let preferencesService = PreferencesService()
    let apiService = ApiService()
    lazy var appServices = {
        return AppServices(preferencesService: self.preferencesService, apiService :self.apiService)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        guard let window = self.window else { return false }
        
        let appFlow = AppFlow(services: self.appServices)
        
        Flows.whenReady(flow1: appFlow) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
        
        self.coordinator.coordinate(flow: appFlow, with: AppStepper())

        Messaging.messaging().delegate = self
              
              
        registerForNotifications()
        
        return true
    }
    
    func registerForNotifications(){
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options:[.alert,.sound,.badge]) { (granted, error) in
                if granted{
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()
                    })
                }else{
                    print("Notification permission denied.")
                    
                }
            }
            
        } else {
            // For iOS 9 and Below
            let type: UIUserNotificationType = [.alert,.sound,.badge];
            let setting = UIUserNotificationSettings(types: type, categories: nil);
            UIApplication.shared.registerUserNotificationSettings(setting);
            DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()
            })
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    

}


extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("\(#function)")
    
    completionHandler([.alert,.badge,.sound])

  }
}
extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    print("Firebase registration token: \(fcmToken)")
    let dataDict:[String: String] = ["token": fcmToken]
    print(dataDict)
    
    preferencesService.setValue(UserPreferences.fcmToken, fcmToken)
        
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
  }
}


struct AppServices: HasApiService  {
    let preferencesService: PreferencesService
    let apiService : ApiService
}
