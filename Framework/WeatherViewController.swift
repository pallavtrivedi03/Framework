//
//  WeatherViewController.swift
//  Framework
//
//  Created by Pallav Trivedi on 09/02/17.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityNameSearchTextField: UITextField!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    let appKey = "745a772315db4f16a6783409170902"
    var url = "http://api.apixu.com/v1/current.json"
    var weatherResponseVO:WeatherResponseVO?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickOnSearchButton(_ sender: UIButton)
    {
        if(cityNameSearchTextField.text!.characters.count != 0)
        {
            weatherResponseVO = WeatherResponseVO()
            let cityName = cityNameSearchTextField.text!
            let params = ["key":appKey,"q":cityName]
            ApplicationController.sharedInstance.webServiceHelper?.setCachePolicyForRequest(policy: NSURLRequest.CachePolicy.reloadIgnoringCacheData)
            ApplicationController.sharedInstance.webServiceHelper?.getWebServiceWith(url: url, params: params, returningVO: weatherResponseVO!, completionHandler: { (vo) in
                self.weatherResponseVO = vo as? WeatherResponseVO
                DispatchQueue.main.async {
                    self.updateView(vo: self.weatherResponseVO!)
                }
            })
            containerView.isHidden = true
        }
    }
    
    func updateView(vo:WeatherResponseVO)
    {
        cityNameLabel.text = vo.cityName!
       // temperatureLabel.text = vo.temperature!
        //windSpeedLabel.text = vo.windSpeed!
       // humidityLabel.text = vo.humidity!
        //latitudeLabel.text = vo.latitude!
        //longitudeLabel.text = vo.longitude!
        regionLabel.text = vo.region!
        weatherLabel.text = vo.text!
        var url = vo.icon!
        let index = url.index(url.startIndex, offsetBy: 2)
        url = url.substring(from: index)
        ApplicationController.sharedInstance.webServiceHelper?.downloadImageFromURL(url: url, completionHandler: { (image) in
            DispatchQueue.main.async {
                self.iconImageView.image = image
            }
        })
        containerView.isHidden = false
    }

   }
