//
//  WebServiceHelper.swift
//  Framework
//  Created by Pallav Trivedi on 30/11/16.


import UIKit

class WebServiceHelper: NSObject
{
    var refreshSSO:RefreshSSO?
    
    override init()
    {
    }
    
    func getWebServiceWith(url:String, returningVO:WebServiceResponseVO,policy:NSURLRequest.CachePolicy, completionHandler:@escaping (_ response:Any)->Void)
    {
        let aParams = ["":""]
        let aHeaders = ["":""]
        let webConnector:WebConnector?
        if (refreshSSO != nil)
        {
            webConnector = WebConnector(refreshSSO: refreshSSO!)
        }
        else
        {
            webConnector = WebConnector()
        }
        webConnector?.cachePolicy = policy
        webConnector?.sendGetRequestWith(url: url,vo: returningVO,params:aParams
            ,headers:aHeaders,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func getWebServiceWith(url:String,params:[String:String], returningVO:WebServiceResponseVO, policy:NSURLRequest.CachePolicy,completionHandler:@escaping (_ response:Any)->Void)
    {
        let aHeaders = ["":""]
        let webConnector:WebConnector?
        if (refreshSSO != nil)
        {
            webConnector = WebConnector(refreshSSO: refreshSSO!)
        }
        else
        {
            webConnector = WebConnector()
        }
        webConnector?.cachePolicy = policy
        webConnector?.sendGetRequestWith(url: url,vo: returningVO,params:params,headers:aHeaders ,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
        })
    }
    
    func getWebServiceWith(url:String,headers:[String:String], returningVO:WebServiceResponseVO, policy:NSURLRequest.CachePolicy,completionHandler:@escaping (_ response:Any)->Void)
    {
        let aParams = ["":""]
        let webConnector:WebConnector?
        if (refreshSSO != nil)
        {
            webConnector = WebConnector(refreshSSO: refreshSSO!)
        }
        else
        {
            webConnector = WebConnector()
        }
        webConnector?.cachePolicy = policy
        webConnector?.sendGetRequestWith(url: url,vo: returningVO,params:aParams,headers:headers,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    
    func getWebServiceWith(url:String,params:[String:String],headers:[String:String], returningVO:WebServiceResponseVO,policy:NSURLRequest.CachePolicy, completionHandler:@escaping (_ response:Any)->Void)
    {
        let webConnector:WebConnector?
        if (refreshSSO != nil)
        {
            webConnector = WebConnector(refreshSSO: refreshSSO!)
        }
        else
        {
            webConnector = WebConnector()
        }
        webConnector?.cachePolicy = policy
        webConnector?.sendGetRequestWith(url: url,vo: returningVO,params:params,headers:headers,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func postWebServiceWith(url:String, returningVO:WebServiceResponseVO,policy:NSURLRequest.CachePolicy, completionHandler:@escaping (_ response:Any)->Void)
    {
        let aParams = ["":""]
        let aHeaders = ["":""]
        let webConnector:WebConnector?
        if (refreshSSO != nil)
        {
            webConnector = WebConnector(refreshSSO: refreshSSO!)
        }
        else
        {
            webConnector = WebConnector()
        }
        webConnector?.cachePolicy = policy
        webConnector?.sendPostRequestWith(url: url,vo: returningVO,params:aParams,headers:aHeaders,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func postWebServiceWith(url:String,params:[String:String], returningVO:WebServiceResponseVO, policy:NSURLRequest.CachePolicy,completionHandler:@escaping (_ response:Any)->Void)
    {
        let aHeaders = ["":""]
        let webConnector:WebConnector?
        if (refreshSSO != nil)
        {
            webConnector = WebConnector(refreshSSO: refreshSSO!)
        }
        else
        {
            webConnector = WebConnector()
        }
        webConnector?.cachePolicy = policy
        webConnector?.sendPostRequestWith(url: url,vo: returningVO,params:params,headers:aHeaders,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func postWebServiceWith(url:String,headers:[String:String], returningVO:WebServiceResponseVO, policy:NSURLRequest.CachePolicy,completionHandler:@escaping (_ response:Any)->Void)
    {
        let aParams = ["":""]
        let webConnector:WebConnector?
        if (refreshSSO != nil)
        {
            webConnector = WebConnector(refreshSSO: refreshSSO!)
        }
        else
        {
            webConnector = WebConnector()
        }
        webConnector?.cachePolicy = policy
        webConnector?.sendPostRequestWith(url: url,vo: returningVO,params:aParams,headers:headers,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func postWebServiceWith(url:String,params:[String:String],headers:[String:String], returningVO:WebServiceResponseVO,policy:NSURLRequest.CachePolicy, completionHandler:@escaping (_ response:Any)->Void)
    {
        let webConnector:WebConnector?
        if (refreshSSO != nil)
        {
            webConnector = WebConnector(refreshSSO: refreshSSO!)
        }
        else
        {
            webConnector = WebConnector()
        }
        webConnector?.cachePolicy = policy
        webConnector?.sendPostRequestWith(url: url,vo: returningVO,params:params,headers:headers,success: { (dictionary) in
            returningVO.setData(response: dictionary)
            completionHandler(returningVO)
            
        })
    }
    
    func downloadImageFromURL(url:String,policy:NSURLRequest.CachePolicy,completionHandler:@escaping(_ image:UIImage)->Void)
    {
        let webConnector = WebConnector(refreshSSO: refreshSSO!)
        webConnector.cachePolicy = policy
        webConnector.getDataFrom(url: url) { (image) in
            completionHandler(image)
        }
    }
    
}
