//
//  WeatherResponseVO.swift
//  Framework
//
//  Created by Pallav Trivedi on 09/02/17.

//

import UIKit

class WeatherResponseVO: NSObject
{
    var temperature:String?
    var cityName:String?
    var humidity:String?
    var windSpeed:String?
    var region:String?
    var latitude:String?
    var longitude:String?
    var icon:String?
    var text:String?
}
extension WeatherResponseVO:WebServiceResponseVO
{
    func setData(response:Any)->Void
    {
        if (response is [String:Any])
        {
            let dictionary:[String:Any] = (response as? [String:Any])!
            print(dictionary)
            let current = dictionary["current"] as! [String:Any]
            let condition = current["condition"] as! [String:Any]
            let location = dictionary["location"] as! [String:Any]
            icon = condition["icon"] as? String
            text = condition["text"] as? String
            humidity = current["humidity"] as? String
            temperature = current["temp_c"] as? String
            windSpeed = current["wind_kph"] as? String
            latitude = location["lat"] as? String
            longitude = location["lon"] as? String
            cityName = location["name"] as? String
            region = location["region"] as? String
            
        }
    }
}
