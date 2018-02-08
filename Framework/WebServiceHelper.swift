//
//  WebServiceHelper.swift
//  Framework
//  Created by Pallav Trivedi on 30/11/16.


import UIKit

class WebServiceHelper: NSObject
{
    private let webConnector:WebConnector?
    override init()
    {
        webConnector = WebConnector()
    }
 
    func getWebServiceWith(url:String, returningVO:WebServiceResponseVO, completionHandler:@escaping (_ response:Any)->Void)
    {
        let aParams = ["":""]
        let aHeaders = ["":""]
        webConnector!.sendGetRequestWith(url: url,vo: returningVO,params:aParams
            ,headers:aHeaders,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func getWebServiceWith(url:String,params:[String:String], returningVO:WebServiceResponseVO, completionHandler:@escaping (_ response:Any)->Void)
    {
        let aHeaders = ["":""]
        webConnector!.sendGetRequestWith(url: url,vo: returningVO,params:params,headers:aHeaders ,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func getWebServiceWith(url:String,headers:[String:String], returningVO:WebServiceResponseVO, completionHandler:@escaping (_ response:Any)->Void)
    {
        let aParams = ["":""]
        webConnector!.sendGetRequestWith(url: url,vo: returningVO,params:aParams,headers:headers,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    
    func getWebServiceWith(url:String,params:[String:String],headers:[String:String], returningVO:WebServiceResponseVO, completionHandler:@escaping (_ response:Any)->Void)
    {
        webConnector!.sendGetRequestWith(url: url,vo: returningVO,params:params,headers:headers,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func postWebServiceWith(url:String, returningVO:WebServiceResponseVO, completionHandler:@escaping (_ response:Any)->Void)
    {
        let aParams = ["":""]
        let aHeaders = ["":""]
        webConnector!.sendPostRequestWith(url: url,vo: returningVO,params:aParams,headers:aHeaders,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func postWebServiceWith(url:String,params:[String:String], returningVO:WebServiceResponseVO, completionHandler:@escaping (_ response:Any)->Void)
    {
        let aHeaders = ["":""]
        webConnector!.sendPostRequestWith(url: url,vo: returningVO,params:params,headers:aHeaders,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func postWebServiceWith(url:String,headers:[String:String], returningVO:WebServiceResponseVO, completionHandler:@escaping (_ response:Any)->Void)
    {
        let aParams = ["":""]
        webConnector!.sendPostRequestWith(url: url,vo: returningVO,params:aParams,headers:headers,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func postWebServiceWith(url:String,params:[String:String],headers:[String:String], returningVO:WebServiceResponseVO, completionHandler:@escaping (_ response:Any)->Void)
    {
        webConnector!.sendPostRequestWith(url: url,vo: returningVO,params:params,headers:headers,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func downloadImageFromURL(url:String,completionHandler:@escaping(_ image:UIImage)->Void)
    {
        webConnector!.getDataFrom(url: url) { (image) in
            completionHandler(image)
        }
    }
    
    func setCachePolicyForRequest(policy:NSURLRequest.CachePolicy)
    {
        webConnector?.cachePolicy = policy
    }
}
