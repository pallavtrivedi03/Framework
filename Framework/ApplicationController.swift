 //
 //  ApplicationController.swift
 //  Framework
 //
 //  Created by Pallav Trivedi on 25/11/16.
 //
 
 import UIKit
 
 public class ApplicationController: NSObject
 {
    var webServiceHelper:WebServiceHelper?
    var userManager:UserManager?
    public static let sharedInstance:ApplicationController = ApplicationController()
    
    override init()
    {
        webServiceHelper = WebServiceHelper()
        userManager = UserManager()
    }
 }
 
