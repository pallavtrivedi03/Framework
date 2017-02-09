//
//  ViewController.swift
//  Framework
//
//  Created by Pallav Trivedi on 25/11/16.
//

import UIKit

class ViewController: UIViewController {

    let url = "http://www.omdbapi.com/"
    var omdbResponseVO:OmdbResponseVO?
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var movieImageview: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var activityIndicator:UIActivityIndicatorView?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickOnHitServiceButton(_ sender: UIButton)
    {
        if (searchTextField.text!.characters.count != 0)
        {
            self.setupView()
                omdbResponseVO = OmdbResponseVO()
            let params = ["t":searchTextField.text!]
            self.showActivityIndicatory()
            ApplicationController.sharedInstance.webServiceHelper?.setCachePolicyForRequest(policy: NSURLRequest.CachePolicy.returnCacheDataElseLoad)
            ApplicationController.sharedInstance.webServiceHelper?.getWebServiceWith(url: url, params: params, returningVO: omdbResponseVO!, completionHandler: { (vo) in
                self.omdbResponseVO = vo as? OmdbResponseVO
                DispatchQueue.main.async {
                    self.updateView()
                }
            })
        }
    }
    
    func setupView()
    {
        actorLabel.text = ""
        runtimeLabel.text = ""
        ratingLabel.text = ""
        releasedLabel.text = ""
        genreLabel.text = ""
        directorLabel.text = ""
        titleLabel.text = ""
        movieImageview.image = UIImage.init(named: "default-placeholder.png")
    }

    func updateView()
    {
        if (omdbResponseVO?.actors != nil) {
            errorLabel.isHidden = true
            actorLabel.text = omdbResponseVO?.actors!
            runtimeLabel.text = omdbResponseVO?.runtime!
            ratingLabel.text = omdbResponseVO?.imdbRating!
            releasedLabel.text = omdbResponseVO?.released!
            genreLabel.text = omdbResponseVO?.genre!
            directorLabel.text = omdbResponseVO?.director!
            titleLabel.text = omdbResponseVO?.title!
            ApplicationController.sharedInstance.webServiceHelper?.downloadImageFromURL(url: (omdbResponseVO?.poster)!, completionHandler: { (image) in
                DispatchQueue.main.async {
                    self.movieImageview.image = image
                }
            })
            containerView.isHidden = false
            self.hideActivityIndicatory()    
        }
        else
        {
            errorLabel.isHidden = false
            actorLabel.isHidden = true
            runtimeLabel.isHidden = true
            releasedLabel.isHidden = true
            genreLabel.isHidden = true
            directorLabel.isHidden = true
            titleLabel.isHidden = true
            movieImageview.isHidden = true
            self.hideActivityIndicatory()
        }
        
    }
    
    func showActivityIndicatory()
    {
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator?.frame = CGRect.init(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        self.activityIndicator?.center = self.view.center
        self.activityIndicator?.hidesWhenStopped = true
        self.activityIndicator?.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator!)
        self.activityIndicator?.startAnimating()
    }
    
    func hideActivityIndicatory()
    {
        self.activityIndicator?.isHidden = true
        self.activityIndicator?.removeFromSuperview()
        self.activityIndicator?.stopAnimating()
    }
}

