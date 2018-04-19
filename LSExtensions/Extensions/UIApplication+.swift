//
//  UIApplication.swift
//  relatedstocks
//
//  Created by 영준 이 on 2017. 1. 10..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation
import UIKit
//import FBSDKCoreKit

extension UIApplication{
    var appId : String{
        get{
            guard let value = Bundle.main.infoDictionary?["Itunes App Id"] as? String else{
                preconditionFailure("Add 'Itunes App Id' info Info.plist.");
            }
            
            return value;
        }
    }
    
    var displayName : String?{
        get{
            var value = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String;
            if value == nil{
                value = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String;
            }
            
            return value;
        }
    }
    
    var version : String{
        get{
            var value = Bundle.main.localizedInfoDictionary?["CFBundleShortVersionString"] as? String;
            if value == nil{
                value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String;
            }
            
            return value ?? "";
        }
    }
    
    var isIPhone : Bool{
        get{
            return UIDevice().userInterfaceIdiom == .phone;
        }
    }
    
    var urlForItunes : URL{
        get{
            return URL(string :"https://itunes.apple.com/kr/app/democracyaction/id\(self.appId)?l=ko&mt=8")!;
        }
    }
    
    func openItunes(){
        self.open(self.urlForItunes, options: [:], completionHandler: nil) ;
    }
    
    public func openReview(_ appId : String = "", completion: ((Bool) -> Void)? = nil){
        let appId = appId.isEmpty ? self.appId : appId;
        let rateUrl = URL(string: "https://itunes.apple.com/app/myapp/id\(appId)?mt=8&action=write-review");
        
        self.open(rateUrl!, options: [:], completionHandler: completion);
    }
    
    func openTwitter(_ id : String){
        var twitterUrl = URL(string: "twitter://user?screen_name=\(id)")!;
        if self.canOpenURL(twitterUrl){
            self.open(twitterUrl, options: [:], completionHandler: nil);
        }else{
            twitterUrl = URL(string: "https://twitter.com/\(id)")!;
            self.open(twitterUrl, options: [:], completionHandler: nil);
        }
    }
    
    func openFacebook(_ id : String){
        //var facebookAppUrl = URL(string: "fb://profile/\(id)")!;
        var facebookUrl = URL(string: "fb://profile/\(id)")!;

        if self.canOpenURL(facebookUrl){
            self.open(facebookUrl, options: [:], completionHandler: nil);
            /*var req = URLRequest(url: facebookUrl);
            URLSession.shared.dataTask(with: req) { (data, res, err) in
                print("facebook request. data[\(data)] res[\(res)] error[\(err)]");
            }.resume();*/
            
        }else{
            facebookUrl = URL(string: "https://www.facebook.com/\(id)")!;
            self.open(facebookUrl, options: [:], completionHandler: nil);
        }
        
        /*FBSDKGraphRequest(graphPath: "\(id)", parameters: ["fields" : "id, name, first_name"]).start { (conn, res, error) in
            print("facebook request. conn[\(conn)] data[\(res)] error[\(error)]")
        }*/
    }
    
    func openWeb(_ urlString : String){
        var Url = URL(string: urlString)!;
        if self.canOpenURL(Url){
            self.open(Url, options: [:], completionHandler: nil);
        }
    }
    
    func openEmail(_ email : String){
        var Url = URL(string: "mailto:\(email)")!;
        if self.canOpenURL(Url){
            self.open(Url, options: [:], completionHandler: nil);
        }
    }
    
    func openSms(_ sms : String){
        var Url = URL(string: "sms:\(sms)")!;
        if self.canOpenURL(Url){
            self.open(Url, options: [:], completionHandler: nil);
        }
    }
    
    func openTel(_ phone : String){
        var Url = URL(string: "tel:\(phone)")!;
        if self.canOpenURL(Url){
            self.open(Url, options: [:], completionHandler: nil);
        }
    }
}
