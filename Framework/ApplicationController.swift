//
//  ApplicationController.swift
//  Framework
//
//  Created by Pallav Trivedi on 25/11/16.
//

import UIKit

public class ApplicationController: NSObject
{
    let webServiceHelper:WebServiceHelper?
    
    static let sharedInstance:ApplicationController = {
        let instance = ApplicationController()
        return instance
    }()
    
    override init()
    {
         webServiceHelper = WebServiceHelper()
    }
}
