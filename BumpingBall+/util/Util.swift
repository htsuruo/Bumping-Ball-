//
//  Utils.swift
//  BumpingBall+
//
//  Created by Tsuru on H28/04/01.
//  Copyright © 平成28年 Hideki Tsuruoka. All rights reserved.
//

import UIKit
import SpriteKit
import Alamofire
import SwiftyJSON

struct define {
    static let MAX = 20
    static let BALL_INIT_SCALE = CGFloat(0.5)
    static let BALL_INIT_SPEED = CGFloat(0.5)
    static let BALL_MAX_SCALE = CGFloat(1.7)
    static let TOUCH_MARGIN = CGFloat(50.0) //タッチ箇所とボールが被って見難くなってしまうので少しずらします.
    static let HEADER_HEIGHT: CGFloat = 60.0
    static let REMOVE_HEIGHT = CGFloat(CGFloat.HEIGHT - (HEADER_HEIGHT))
    static let TOUCH_HEIGHT: CGFloat = 65.0
    static let TOUCH_AREA = CGRect(x: 0, y: 0, width: CGFloat.WIDTH, height: TOUCH_HEIGHT)
    static let APPSTORE_URL = "https://itunes.apple.com/us/app/bumping-ball+/id1148383719?l=ja&ls=1&mt=8"
    static let MAX_ITEM_BALL = 5
    static let COMBO_FOR_ITEM_BALL = 2
    static let SPECIAL_MODE_TIME = 15
    static let VERSION_URL = "http://tsurutsuru.php.xdomain.jp/bumping_ball_plus/version.php"
    static let STAGE_SIGN_HEIGHT: CGFloat = 60.0
    static let LEVEL_MAX = 20
}

struct Util {
    
    //最前面のビューコントローラを取得する
   static func getForegroundViewController() -> UIViewController {
        var tc = UIApplication.shared.keyWindow?.rootViewController
        while tc!.presentedViewController != nil {
            tc = tc!.presentedViewController
        }
        return tc!
    }
    
    static func versionCheck() {
        Alamofire.request(define.VERSION_URL, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            print("response: \(response)")
            guard let object = response.result.value else {
                return
            }
            if response.result.isSuccess {
                print("versionCheck: success!!")
                let json = JSON(object)
                let latestVersion = json["version"].string
                if latestVersion == nil {
                    return
                }
                let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String?
                let isOld = (currentVersion?.compare(latestVersion!) == .orderedAscending )
                print("isOld: \(isOld)")
                if isOld {
                    let alertUtil = AlertUtil()
                    alertUtil.versionUpdate()
                }
            } else {
                print("versionCheck: failed.")
            }
        }
    }
    
}

struct udKey {
    static let off_music = "off_music"
    static let off_sound = "off_sound"
    static let is_not_first = "is_not_first"
}
