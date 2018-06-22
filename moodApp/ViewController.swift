//
//  ViewController.swift
//  moodApp
//
//  Created by ishgupta on 6/13/18.
//  Copyright © 2018 ishgupta. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON


class ViewController: UIViewController {
    
    @IBOutlet weak var tagTextField: UITextField!
    // outlets for ui images
    
    @IBAction func refresh(_ sender: Any) {
        
        self.stock1Bool = false
        self.stock2Bool = false
        self.stock3Bool = false
        self.stock4Bool = false
        
        self.imageArray = [1,2,3,4]
        
    }
    
    
    @IBOutlet weak var stockImage1: UIImageView!
    @IBOutlet weak var stockImage2: UIImageView!
    @IBOutlet weak var stockImage3: UIImageView!
    @IBOutlet weak var stockImage4: UIImageView!
    
    var stock1url = ""
    var stock2url = ""
    var stock3url = ""
    var stock4url =  ""
    
    var stock1Bool = false
    var stock2Bool = false
    var stock3Bool = false
    var stock4Bool = false
    
    var count = 0
    
    var number = 0
    
    var imageArray = [1,2,3,4]
    
    
    let inputTag1 = "Yosemite"
    let inputTag2 = "Park"
    let inputTag3 = "monkey"
    var previous = ""
    var imageNumber = 0
    
    
    
    
    @IBAction func moodAction(_ sender: Any) {
        
        
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stockImage1.isUserInteractionEnabled = true
        stockImage2.isUserInteractionEnabled = true
        stockImage3.isUserInteractionEnabled = true
        stockImage4.isUserInteractionEnabled = true
        
        
        // handle initial population of images
        doInitialRequest(tag1: "life", type: "initial")
        
        
        // placing recognizer on image 1
        let tapImage1 = UITapGestureRecognizer(target: self, action: #selector(self.handleMoodImage1))
        stockImage1.addGestureRecognizer(tapImage1)
        
        
        // placing recognizer on image 2
        let tapImage2 = UITapGestureRecognizer(target: self, action: #selector(self.handleMoodImage2))
        stockImage2.addGestureRecognizer(tapImage2)
        
        // placing recognizer on image 3
        let tapImage3 = UITapGestureRecognizer(target: self, action: #selector(self.handleMoodImage3))
        stockImage3.addGestureRecognizer(tapImage3)
        
        // placing recognizer on image 4
        let tapImage4 = UITapGestureRecognizer(target: self, action: #selector(self.handleMoodImage4))
        stockImage4.addGestureRecognizer(tapImage4)
        
        
    }
    
    
    
    // touch recognizer for image 1
    @objc func handleMoodImage1(){
        
        
        tags(url: self.stock1url) { (tag) in
            if let tag = tag {
                print(tag,"this is turnt")
                let tag1sub = tag[1] as? String ?? "space"
                let tag2sub = tag[2] as? String ?? "space"
                
                if self.stock1Bool == false {
                    print(tag1sub,tag2sub, "turnt good boy")
                    if let index = self.imageArray.index(of: 1) {
                        self.imageArray.remove(at: index)
                    }
                    self.doInitialRequest(tag1: tag1sub,  type: "one")
                    self.stock1Bool = true
                    
                }
                
                
            }
            
            //  self.doInitialRequest(tag1: tag!, tag2: "life", type: "one")
        }
        
        
        
    }
    
    // touch recognizer for image 2
    @objc func handleMoodImage2() {
        tags(url: self.stock2url) { (tag) in
            if let tag = tag {
                print(tag,"this is turnt")
                let tag1sub = tag[1] as? String ?? "space"
                let tag2sub = tag[2] as? String ?? "space"
                
                if self.stock2Bool == false {
                    print(tag1sub,tag2sub, "turnt good boy")
                    if let index = self.imageArray.index(of: 2) {
                        self.imageArray.remove(at: index)
                    }
                    self.doInitialRequest(tag1: tag1sub, type: "two")
                    self.stock2Bool = true
                }
            }
        }
        
    }
    
    // touch recognizer for image 3
    @objc func handleMoodImage3() {
        
        tags(url: self.stock3url) { (tag) in
            if let tag = tag {
                print(tag,"this is turnt")
                
                let tag1sub = tag[1] as? String ?? "space"
                let tag2sub = tag[2] as? String ?? "space"
                
                if self.stock3Bool == false {
                    print(tag1sub,tag2sub, "turnt good boy")
                    if let index = self.imageArray.index(of: 3) {
                        self.imageArray.remove(at: index)
                    }
                    self.doInitialRequest(tag1: tag1sub,  type: "three")
                    self.stock3Bool = true
                }
            }
            
            //  self.doInitialRequest(tag1: tag!, tag2: "life", type: "three")
        }
        
        
    }
    
    // touch recognizer for image 4
    @objc func handleMoodImage4() {
        
        tags(url: self.stock4url) { (tag) in
            if let tag = tag {
                print(tag,"this is turnt")
                let tag1sub = tag[1] as? String ?? "space"
                let tag2sub = tag[2] as? String ?? "space"
                
                if self.stock4Bool == false {
                    print(tag1sub,tag2sub, "turnt good boy")
                    if let index = self.imageArray.index(of: 4) {
                        self.imageArray.remove(at: index)
                    }
                    self.doInitialRequest(tag1: tag1sub, type: "four")
                    self.stock4Bool = true
                }
            }
            
            //    self.doInitialRequest(tag1: tag!, tag2: "life", type: "four")
        }
        
    }
    
    
    
    
    func doInitialRequest(tag1: String, type: String) {
        let endpoint: String = "https://stock.adobe.io/Rest/Media/1/Search/Files?locale=en_US&search_parameters%5Bwords%5D=\(tag1)&search_parameters%5Blimit%5D=15&search_parameters%5Bfilters%5D%5Bcontent_type%3Aphoto%5D=1&search_parameters%5Border%5D=nb_downloads&result_columns%5B%5D=title&result_columns%5B%5D=details_url&result_columns%5B%5D=thumbnail_1000_url"
        
        
        Alamofire.request(endpoint,
                          //   parameters: ["words" : "Monkey"],
            headers : [ "x-api-key" : "8dfb956aa4e649c69a217ebfc4db5642",
                        "x-product": "MySampleApp/1.0"]).responseJSON(completionHandler:  { response in
                            guard response.result.isSuccess,
                                let value = response.result.value as? [String:Any] else{
                                    print("Error", response.result.error)
                                    return
                            }
                            let returnedValue = JSON(value)
                            //print(returnedValue)
                            print("*#*!**!#*!*#*!*#!#*#*!*!#*!*#*!*!*!*#!#")
                            print("*#*!**!#*!*#*!*#!#*#*!*!#*!*#*!*!*!*#!#")
                            print("*#*!**!#*!*#*!*#!#*#*!*!#*!*#*!*!*!*#!#")
                            print(returnedValue)
                            //  print(returnedValue["files"][\(imageNumber)]["details_url"])
                            
                            
                            guard let stock1URL = URL(string: returnedValue["files"][2]["thumbnail_1000_url"].stringValue) else {
                                print("stock 1 url doesnt work")
                                return
                            }
                            guard let stock2URL = URL(string: returnedValue["files"][4]["thumbnail_1000_url"].stringValue) else {
                                print("stock 2 url doesnt work")
                                return
                            }
                            guard let stock3URL = URL(string: returnedValue["files"][13]["thumbnail_1000_url"].stringValue) else {
                                print("Stock 3 url doesnt work")
                                return
                            }
                            guard let stock4URL = URL(string: returnedValue["files"][9]["thumbnail_1000_url"].stringValue) else {
                                print("stock 4 url doesnt work")
                                return
                            }
                            
                            
                            
                            self.stock1url = stock1URL.absoluteString
                            self.stock2url = stock2URL.absoluteString
                            self.stock3url = stock3URL.absoluteString
                            self.stock4url = stock4URL.absoluteString
                            
                            
                            print(stock1URL , "this is the stock 1 URL")
                            
                            print(self.imageArray.description)
                            self.count = self.imageArray.count
                            print(self.count, "this is the count")
                            
                            
                            for i in 0..<self.count {
                                print(self.imageArray[i])
                                self.number = self.imageArray[i]
                                
                                if self.number == 1 {
                                    self.stockImage1?.af_setImage(withURL: stock1URL)
                                }
                                
                                if self.number == 2 {
                                    self.stockImage2?.af_setImage(withURL: stock2URL)
                                }
                                
                                if self.number == 3 {
                                    self.stockImage3?.af_setImage(withURL: stock3URL)
                                }
                                
                                if self.number == 4{
                                    self.stockImage4?.af_setImage(withURL: stock4URL)
                                }
                                
                            }
                            
                            
                            
                            print("")
                            //                            if type == "initial" {
                            //
                            //                                self.stockImage1?.af_setImage(withURL: stock1URL)
                            //                                self.stockImage2?.af_setImage(withURL: stock2URL)
                            //                                self.stockImage3?.af_setImage(withURL: stock3URL)
                            //                                self.stockImage4?.af_setImage(withURL: stock4URL)
                            //
                            //                            }
                            //
                            //                            if type == "one" {
                            //
                            //
                            //                                self.stockImage2?.af_setImage(withURL: stock2URL)
                            //                                self.stockImage3?.af_setImage(withURL: stock3URL)
                            //                                self.stockImage4?.af_setImage(withURL: stock4URL)
                            //
                            //                            }
                            //
                            //                            if type == "two" {
                            //
                            //                                self.stockImage1?.af_setImage(withURL: stock1URL)
                            //
                            //                                self.stockImage3?.af_setImage(withURL: stock3URL)
                            //                                self.stockImage4?.af_setImage(withURL: stock4URL)
                            //
                            //                            }
                            //
                            //
                            //                            if type == "three" {
                            //
                            //                                self.stockImage1?.af_setImage(withURL: stock1URL)
                            //                                self.stockImage2?.af_setImage(withURL: stock2URL)
                            //
                            //                                self.stockImage4?.af_setImage(withURL: stock4URL)
                            //
                            //                            }
                            //
                            //
                            //                            if type == "four" {
                            //
                            //                                self.stockImage1?.af_setImage(withURL: stock1URL)
                            //                                self.stockImage2?.af_setImage(withURL: stock2URL)
                            //                                self.stockImage3?.af_setImage(withURL: stock3URL)
                            //
                            //
                            //                            }
                            
                            
                            
                            
                            
                            
                            
                        })
        
        
    }
    
    
    func getImage(url: String, imageInArray: Int) {
        print(url, "this is the URL")
        Alamofire.request(url,method: .get)
            .responseImage { response in
                // check for errors
                guard response.result.isSuccess,
                    let imageResponse = response.result.value else{
                        print("Error", response.result.error)
                        return
                }
                print(imageResponse, "This is the IMAGE BOOM")
                //self.stockImage = imageResponse
        }
        
        //
        
        var image: UIImageView = stockImage1
        if imageNumber == 1 {
            image = stockImage1
        } else if imageNumber == 2 {
            image = stockImage2
        } else if imageNumber == 3 {
            image = stockImage3
        } else {
            image = stockImage4
        }
        
        
        guard let test = URL(string: url) else {
            print("There is an error")
            return
        }
        // this sends the request to alamo fire to download the image via the url
        image.af_setImage(withURL: test)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}

