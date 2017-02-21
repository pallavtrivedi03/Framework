//
//  UserManager.swift
//  Framework
//
//  Created by Pallav Trivedi on 14/02/17.
//  Copyright © 2017 Reliance Jio Infocomm Ltd. All rights reserved.
//

import UIKit

class UserManager: NSObject
{
    var userVO:UserVO?
    override init()
    {
        userVO = UserVO()
    }
    
    func initializeUserVOWith(apiKey:String)
    {
        userVO?.apiKey = apiKey
    }
    
    func initializeUserVOWithDefaultValues()
    {
        userVO?.apiKey = ""
        userVO?.jToken = ""
        userVO?.lBCookie = ""
        userVO?.ssoToken = ""
        userVO?.isUserLoggedIn = false
        userVO?.jioID = ""
        userVO?.displayName = "Guest"
        userVO?.photoURL = ""
        userVO?.uniqueKey = ""
        userVO?.userId = -1
        userVO?.loginURL = ""
        userVO?.profileID = ""
        userVO?.subscriberID = ""
        userVO?.mail = ""
        userVO?.mobile = ""
    }
    
    func initializeUserVOWith(dictionary:[String:Any])
    {
        let resultDict = dictionary["result"] as! [String:Any]
        userVO?.jToken = resultDict["jToken"] as? String
        userVO?.lBCookie = resultDict["lbCookie"] as? String
        userVO?.ssoToken = resultDict["ssoToken"] as? String
        userVO?.jioID = resultDict["uId"] as? String
        userVO?.displayName = resultDict["displayName"] as? String
        userVO?.photoURL = resultDict["photoUrl"] as? String
        userVO?.uniqueKey = resultDict["uniqueId"] as? String
        userVO?.profileID = resultDict["profileId"] as? String
        userVO?.subscriberID = resultDict["subscriberId"] as? String
        userVO?.mail = resultDict["mail"] as? String
        userVO?.mobile = resultDict["mobile"] as? String
        userVO?.userId = -1
    }
}
