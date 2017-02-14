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
    
    static let sharedInstance:ApplicationController = ApplicationController()
     
    override init()
    {
         webServiceHelper = WebServiceHelper()
    }
}
