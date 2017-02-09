//
//  OmdbResponseVO.swift
//  Framework
//
//  Created by Pallav Trivedi on 28/11/16.

//

import UIKit

class OmdbResponseVO: NSObject
{
    var actors:String?
    var awards:String?
    var country:String?
    var director:String?
    var genre:String?
    var language:String?
    var metascore:String?
    var plot:String?
    var poster:String?
    var rated:String?
    var released:String?
    var runtime:String?
    var title:String?
    var type:String?
    var writer:String?
    var year:String?
    var imdbRating:String?
    var imdbVotes:String?

}
extension OmdbResponseVO:WebServiceResponseVO
{
    func setData(response:Any)->Void
    {
        if (response is [String:Any])
        {
            let dictionary:[String:Any] = (response as? [String:Any])!
            actors = dictionary["Actors"] as! String?
            awards = dictionary["Awards"] as! String?
            country = dictionary["Country"] as! String?
            director = dictionary["Director"] as! String?
            genre = dictionary["Genre"] as! String?
            language = dictionary["Language"] as! String?
            metascore = dictionary["Metascore"] as! String?
            plot = dictionary["Plot"] as! String?
            poster = dictionary["Poster"] as! String?
            rated = dictionary["Rated"] as! String?
            released = dictionary["Released"] as! String?
            runtime = dictionary["Runtime"] as! String?
            title = dictionary["Title"] as! String?
            writer = dictionary["Writer"] as! String?
            year = dictionary["Year"] as! String?
            imdbVotes = dictionary["imdbVotes"] as! String?
            imdbRating = dictionary["imdbRating"] as! String?
            print("Title \(title!) Rating \(imdbRating!)")
        }
    }
}
