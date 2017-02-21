//
//  WebConnector.swift
//  Framework
//
//  Created by Pallav Trivedi on 25/11/16.
//

import UIKit

class WebConnector: NSObject
{
    let session:URLSession?
    var refreshSSO:RefreshSSO?
    var cachePolicy             = NSURLRequest.CachePolicy.useProtocolCachePolicy
    let imageCache              = NSCache<AnyObject, AnyObject>()
    var refreshSSORequestCount  = 0
    
    var receivedURL:String?
    var receivedParams:[String:String]?
    var receivedVO:Any?
    var receivedHeaders:[String:String]?
    var receivedSuccessBlock: (Any) -> Void = {arg in}
    var receivedRequestType:String?
    //var receivedClosure:(Any) -> Void
    
    override init()
    {
        session = URLSession(configuration: URLSessionConfiguration.default)
        session?.configuration.httpMaximumConnectionsPerHost = 6
    }
    init(refreshSSO:RefreshSSO)
    {
        self.refreshSSO = refreshSSO
        session = URLSession(configuration: URLSessionConfiguration.default)
        session?.configuration.httpMaximumConnectionsPerHost = 6
    }
    
    //MARK: Service Request Methods
    func sendGetRequestWith(url:String,vo:Any,params:[String:String],headers:[String:String],success:@escaping (_ response:Any)->Void)
    {
        receivedURL = url
        receivedVO = vo
        receivedParams = params
        receivedHeaders = headers
        receivedSuccessBlock = success
        receivedRequestType = "GET"
        
        let formattedURL = NSURL.init(string: url)
        var request = URLRequest(url: formattedURL as! URL)
        request.httpMethod = HTTPMethodGetKey
        request.setValue(HTTPHeaderContentTypeURLEncodedValue, forHTTPHeaderField: HTTPHeaderContentTypeTag)
        request.setValue(HTTPHeaderAcceptTypeJSONValue, forHTTPHeaderField: HTTPHeaderAcceptTypeTag)
        request.timeoutInterval = TimeInterval(HTTPRequestTimeOutIntervalValue)
        
        let paramsArray = Array(params.keys)
        if (!(paramsArray[0].isEqual("")))
        {
            let parameterString = params.stringFromHttpParameters()
            let urlString =  (string: "\(url)?\(parameterString)")
            request = URLRequest(url: URL(string: urlString)!)
        }
        
        let headerArray = Array(headers.keys)
        
        if (!(headerArray[0].isEqual("")))
        {
            let keys = headers.keys
            for key in keys
            {
                let value = headers[key]
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.cachePolicy = cachePolicy
        
        
        session?.dataTask(with: request, completionHandler: {
            data,response,error in
            
            if let error = error
            {
                print(error.localizedDescription)
                success([error.localizedDescription])
            }
            else if let httpResponse = response as? HTTPURLResponse
            {
                if httpResponse.statusCode == HTTP_SUCCESS
                {
                    let dict = ["response":self.seializeJSON(data: data),"code":httpResponse.statusCode]
                    success(dict)
                }
                else if httpResponse.statusCode == HTTP_AUTH_TOKEN_EXPIRY   //refresh sso token
                {
                    if(self.refreshSSORequestCount < 3)
                    {
                        self.refreshSSORequestCount = self.refreshSSORequestCount + 1
                        self.updateSSOTokenAndResendCurrentRequest()
                    }
                    else
                    {
                        let dict = ["response":nil,"code":httpResponse.statusCode]
                        success(dict)
                    }
                }
                else if httpResponse.statusCode == HTTP_AUTH_FAILURE
                {
                    let dict = ["response":self.seializeJSON(data: data),"code":httpResponse.statusCode]
                    success(dict)
                }
                else if httpResponse.statusCode == HTTP_NO_CONTENT
                {
                    let dict = ["response":self.seializeJSON(data: data),"code":httpResponse.statusCode]
                    success(dict)
                }
                else
                {
                    let dict = ["response":nil,"code":httpResponse.statusCode]
                    success(dict)
                }
            }
        }).resume()
    }
    
    func sendPostRequestWith(url:String,vo:Any,params:[String:String],headers:[String:String],success:@escaping (_ response:Any)->Void)
    {
        
        receivedURL = url
        receivedParams = params
        receivedVO = vo
        receivedHeaders = headers
        receivedSuccessBlock = success
        receivedRequestType = "POST"
        
        let formattedURL = NSURL.init(string: url)
        var request = URLRequest(url: formattedURL as! URL)
        request.httpMethod = HTTPMethodPostKey
        request.timeoutInterval = TimeInterval(HTTPRequestTimeOutIntervalValue)
        request.cachePolicy = cachePolicy
        
        if (params.count > 0)
        {
            let parameterString = params.stringFromHttpParameters()
            request.httpBody = parameterString.data(using: .utf8)
            request.setValue(HTTPHeaderAcceptTypeJSONValue, forHTTPHeaderField: HTTPHeaderAcceptTypeTag)
        }
        else
        {
            request.setValue(HTTPHeaderContentTypeURLEncodedValue, forHTTPHeaderField: HTTPHeaderContentTypeTag)
            request.setValue(HTTPHeaderAcceptTypeJSONValue, forHTTPHeaderField: HTTPHeaderAcceptTypeTag)
        }
        
        if (headers.count > 0)
        {
            let keys = headers.keys
            for key in keys
            {
                let value = headers[key]
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.cachePolicy = cachePolicy
        session?.dataTask(with: request, completionHandler: {
            data,response,error in
            
            if let error = error
            {
                print(error.localizedDescription)
                success([error.localizedDescription])
            }
            else if let httpResponse = response as? HTTPURLResponse
            {
                if httpResponse.statusCode == HTTP_SUCCESS
                {
                    let dict = ["response":self.seializeJSON(data: data),"code":httpResponse.statusCode]
                    success(dict)
                }
                else if httpResponse.statusCode == HTTP_AUTH_TOKEN_EXPIRY   //refresh sso token
                {
                    if(self.refreshSSORequestCount < 3)
                    {
                        self.refreshSSORequestCount = self.refreshSSORequestCount + 1
                        self.updateSSOTokenAndResendCurrentRequest()
                    }
                    else
                    {
                        let dict = ["response":nil,"code":httpResponse.statusCode]
                        success(dict)
                    }
                }
                else if httpResponse.statusCode == HTTP_AUTH_FAILURE
                {
                    let dict = ["response":self.seializeJSON(data: data),"code":httpResponse.statusCode]
                    success(dict)
                }
                else if httpResponse.statusCode == HTTP_NO_CONTENT
                {
                    let dict = ["response":self.seializeJSON(data: data),"code":httpResponse.statusCode]
                    success(dict)
                }
                else
                {
                    let dict = ["response":nil,"code":httpResponse.statusCode]
                    success(dict)
                }
            }
            
        }).resume()
    }
    
    //MARK: Image downloading
    func getDataFrom(url:String,completion:@escaping (_ image:UIImage)->Void)
    {
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            
            completion(cachedImage)
        }
        else
        {
            let formattedURL = NSURL.init(string: url)
            var request = URLRequest(url: formattedURL as! URL)
            request.httpMethod = HTTPMethodGetKey
            request.timeoutInterval = TimeInterval(HTTPRequestTimeOutIntervalValue)
            request.cachePolicy = cachePolicy
            
            session?.dataTask(with: request, completionHandler: {
                data,response,error in
                
                if let error = error
                {
                    print(error.localizedDescription)
                }
                else if let httpResponse = response as? HTTPURLResponse
                {
                    if httpResponse.statusCode == HTTP_SUCCESS
                    {
                        if let downloadedImage = UIImage(data: data!) {
                            self.imageCache.setObject(downloadedImage, forKey: url as AnyObject)
                            completion(downloadedImage)
                        }
                        
                    }
                }
                
            }).resume()
        }
    }
    
    //MARK: Helper Methods
    func seializeJSON(data:Data?) -> Any
    {
        if (data != nil)
        {
            do {
                if let parsedResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                {
                    let code = getErrorCodeFrom(dictionary: parsedResponse)
                    if code == SSOTokenExpiredCode
                    {
                        self.updateSSOTokenAndResendCurrentRequest()
                    }
                    else
                    {
                        return parsedResponse as Any
                    }
                }
                else if let parsedResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
                {
                    return parsedResponse
                }
                
            } catch
            {
                print(error.localizedDescription)
            }
        }
        return [""]
    }
    
    func getErrorCodeFrom(dictionary:[String:Any]) -> Int
    {
        if let code = dictionary["code"] as? Int
        {
            return code
        }
        else if let code = dictionary["messageCode"] as? Int
        {
            return code
        }
        else
        {
            return 0
        }
    }
    
    func updateSSOTokenAndResendCurrentRequest()
    {
        if refreshSSO != nil
        {
            let ssoToken = refreshSSO?.refreshSSO()
            if ssoToken != nil      // resend the request
            {
                if receivedRequestType == "GET"
                {
                    sendGetRequestWith(url: receivedURL!, vo: receivedVO!, params: receivedParams!, headers: receivedHeaders!, success: receivedSuccessBlock)
                }
                else
                {
                    sendPostRequestWith(url: receivedURL!, vo: receivedVO!, params: receivedParams!, headers: receivedHeaders!, success: receivedSuccessBlock)
                }
            }
            else
            {
                print("unable to refresh sso")
            }
            //save this sso in db or wherever
        }
    }
    
    func setMaximumNumberOfHttpConnections(count:Int)
    {
        session?.configuration.httpMaximumConnectionsPerHost = count
    }
    
}

//MARK: Extensions

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// :returns: Returns percent-escaped string.
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}
