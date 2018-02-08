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
    let HTTPMethodGetKey                        = "GET"
    let HTTPMethodPostKey                       = "POST"
    let HTTPHeaderContentTypeURLEncodedValue    = "application/x-www-form-urlencoded"
    let HTTPHeaderContentTypeTag                = "Content-Type"
    let HTTPHeaderAcceptTypeJSONValue           = "application/json"
    let HTTPHeaderAcceptTypeTag                 = "Accept"
    let HTTPRequestTimeOutIntervalValue         = 30
    var cachePolicy                             = NSURLRequest.CachePolicy.useProtocolCachePolicy
    let imageCache                              = NSCache<AnyObject, AnyObject>()
    
    override init()
    {
        session = URLSession(configuration: URLSessionConfiguration.default)
        session?.configuration.httpMaximumConnectionsPerHost = 6
    }
    
    
    //MARK: Service Request Methods
    func sendGetRequestWith(url:String,vo:Any,params:[String:String],headers:[String:String],success:@escaping (_ response:Any)->Void)
    {
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
            //let urlString =  (string: "\(url)?\(parameterString)")
            let urlString =  "\(url)?\(parameterString)"
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
                if httpResponse.statusCode == 200
                {
                    success(self.seializeJSON(data: data))
                }
            }
            
        }).resume()
    }
    
    func sendPostRequestWith(url:String,vo:Any,params:[String:String],headers:[String:String],success:@escaping (_ response:Any)->Void)
    {
        let formattedURL = NSURL.init(string: url)
        var request = URLRequest(url: formattedURL as! URL)
        request.httpMethod = HTTPMethodPostKey
        request.setValue(HTTPHeaderContentTypeURLEncodedValue, forHTTPHeaderField: HTTPHeaderContentTypeTag)
        request.setValue(HTTPHeaderAcceptTypeJSONValue, forHTTPHeaderField: HTTPHeaderAcceptTypeTag)
        request.timeoutInterval = TimeInterval(HTTPRequestTimeOutIntervalValue)
        request.cachePolicy = cachePolicy
        
        if (params.count > 0)
        {
            let parameterString = params.stringFromHttpParameters()
            let urlString = "\(url)?\(parameterString)"
            request.httpBody = urlString.data(using: .utf8)
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
                if httpResponse.statusCode == 200
                {
                    success(self.seializeJSON(data: data))
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
                if httpResponse.statusCode == 200
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
                    return parsedResponse as Any
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
