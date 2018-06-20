//
//  imagga.swift
//  moodApp
//
//  Created by ishgupta on 6/14/18.
//  Copyright © 2018 ishgupta. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SwiftyJSON





func tags(url: String, completion: @escaping (Array<Any>?) -> Void)  {
    
    
    var tag: String = ""
    Alamofire.request("https://api.imagga.com/v1/tagging?url=\(url)",
        //   parameters: ["words" : "Monkey"],
        headers :["Authorization" : "Basic YWNjXzRmODY1YzNhNTdlZDVkYjozZTVmYzNhNjI0NmFjMzA3MTRhODA1ZGQ1MzAwMjNmMw=="]).responseJSON(completionHandler:  { response in
            guard response.result.isSuccess,
                let value = response.result.value as? [String:Any] else{
                    print("Error", response.result.error)
                    return
            }
            var tagArray = [""]
            let returnedValue = JSON(value)
            //print(returnedValue)
            print("*#*!**!#*!*#*!*#!#*#*!*!#*!*#*!*!*!*#!#")
            print("*#*!**!#*!*#*!*#!#*#*!*!#*!*#*!*!*!*#!#")
            print("*#*!**!#*!*#*!*#!#*#*!*!#*!*#*!*!*!*#!#")
            print(returnedValue)
            
            var randomTag1 = returnedValue["results"][0]["tags"][0]["tag"].stringValue// this is the tag that should determine the other 3 images
             var randomTag2 = returnedValue["results"][0]["tags"][1]["tag"].stringValue     //also use the other 3 or 4 tags as well
                                                                                    // when calling the imagga api then pass it to the thing
            print(randomTag1)
            let tag1 = randomTag1.components(separatedBy: " ")
            let tag2 = randomTag2.components(separatedBy: " ")
            
            tagArray.append(tag1[0])
            tagArray.append(tag2[0])

            completion(tagArray)
            //vc.doInitialRequest(tag: array[0])
            
        })
    
    
    
    
}
