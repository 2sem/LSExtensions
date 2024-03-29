//
//  UIApplication.swift
//  LSExtensions
//
//  Created by 영준 이 on 2017. 1. 10..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

@objc extension UIApplication{
    /**
        Value of property nameed of 'Itunes App Id' in Info.plist
        - Requires: Property 'Itunes App Id' in Info.plist
        - Note: this property is used in openReview(_: , completion: )
     */
    open var appId : String{
        get{
            guard let value = Bundle.main.infoDictionary?["Itunes App Id"] as? String else{
                preconditionFailure("Add 'Itunes App Id' info Info.plist.");
            }
            
            return value;
        }
    }
    
    /**
        Value of property named of 'CFBundleDisplayName' in Info.plist
    */
    public var displayName : String?{
        get{
            var value = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String;
            if value == nil{
                value = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String;
            }
            
            return value;
        }
    }
    
    /**
        Value of property named of 'CFBundleShortVersionString' in Info.plist
     */
    public var version : String{
        get{
            var value = Bundle.main.localizedInfoDictionary?["CFBundleShortVersionString"] as? String;
            if value == nil{
                value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String;
            }
            
            return value ?? "";
        }
    }
    
    /**
        return determine whether current application's version is less than given version or equal to it
        - parameter version: version string to compare with version of current application
        - parameter same: whether to return true if given verion string is equal to current application version
        - Returns: whether current application's version is less than given version or equal to it
     */
    public func isVersion(lessThan version: String, orSame same: Bool = false) -> Bool{
        let value = self.version.compare(version, options: .numeric);
        var candidates : [ComparisonResult] = [.orderedAscending];
        if same{
            candidates.append(.orderedSame);
        }
        
        return candidates.contains(value);
    }
    
    /**
        return determine whether current application's version is larger than given version or equal to it
        - parameter version: version string to compare with version of current application
        - parameter same: whether to return true if given verion string is equal to current application version
        - Returns: whether current application's version is larger than given version or equal to it
     */
    public func isVersion(largerThan version: String, orSame same: Bool = false) -> Bool{
        let value = self.version.compare(version, options: .numeric);
        var candidates : [ComparisonResult] = [.orderedDescending];
        if same{
            candidates.append(.orderedSame);
        }
        
        return candidates.contains(value);
    }
    
    /**
        carrier info of this device
    */
    public var carrier : CTCarrier?{
        let tel = CTTelephonyNetworkInfo();
        
        return tel.subscriberCellularProvider;
    }
    
    /**
        Is kind of Current Device iPhone?
    */
    public var isIPhone : Bool{
        get{
            return UIDevice().userInterfaceIdiom == .phone;
        }
    }
    
    /**
     Is kind of Current Device iPad?
     */
    public var isIPad : Bool{
        get{
            return UIDevice().userInterfaceIdiom == .pad;
        }
    }
    
    /**
        Url for Itunes Link for this App
     */
    open var urlForItunes : URL{
        get{
            return URL(string :"https://itunes.apple.com/kr/app/myapp/id\(self.appId)?l=ko&mt=8")!;
        }
    }
    
    /**
        os compatible for function to open url
    */
    private func openCompatible(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Swift.Void)? = nil){
        if #available(iOS 10.0, *) {
            self.open(url, options: options, completionHandler: completion)
        } else {
            self.openURL(url);
        }
    }
    
    /**
        Open AppStore for this App
    */
    @objc public func openItunes(){
        self.openCompatible(self.urlForItunes, options: [:], completionHandler: nil) ;
    }
    
    /**
        Open Review Page for this App on AppStore
        - parameter appId: App ID for Review Page
        - parameter completion: block to call after opening review has been completed
        - parameter result: hoho siba
    */
    public func openReview(_ appId : String = "", completion: ((_ result: Bool) -> Void)? = nil){
        let appId = appId.isEmpty ? self.appId : appId;
        let rateUrl = URL(string: "https://itunes.apple.com/app/myapp/id\(appId)?mt=8&action=write-review");
    
        self.openCompatible(rateUrl!, options: [:], completionHandler: completion);
    }
    
    /**
        Opens Settings App page for this app
         - parameter completion: block to call after opening Settings App has been completed
    */
    public func openSettings(_ completion: ((Bool) -> Swift.Void)? = nil){
        let url_settings = URL(string:UIApplication.openSettingsURLString);
        self.openCompatible(url_settings!, options: [:], completionHandler: completion)
    }
    
    /**
        Open Page of specified User on Twitter App
        - parameter id: Twitter Account Name
        - parameter webOpen: Handler to open url
    */
    public func openTwitter(_ id : String, webOpen: ((URL) -> Void)? = nil){
        var twitterUrl = URL(string: "twitter://user?screen_name=\(id)")!;
        if self.canOpenURL(twitterUrl){
            self.openCompatible(twitterUrl, options: [:], completionHandler: nil);
        }else{
            twitterUrl = URL(string: "https://twitter.com/\(id)")!;
            if webOpen != nil{
                webOpen!(twitterUrl);
            }else{
                self.openCompatible(twitterUrl, options: [:], completionHandler: nil);
            }
        }
    }
    
    /**
        Open Page of specified User on Facebook App
        - parameter id: FaceBook id converted number by [Find my Facebook ID](www.findmyfbid.com)
        - parameter webOpen: Handler to open url
    */
    public func openFacebook(_ id : String, webOpen: ((URL) -> Void)? = nil){
        var facebookUrl = URL(string: "fb://profile/\(id)")!;

        if self.canOpenURL(facebookUrl){
            self.openCompatible(facebookUrl, options: [:], completionHandler: nil);
        }else{
            facebookUrl = URL(string: "https://www.facebook.com/\(id)")!;
            if webOpen != nil{
                webOpen!(facebookUrl);
            }else{
                self.openCompatible(facebookUrl, options: [:], completionHandler: nil);
            }
        }
        
        /*FBSDKGraphRequest(graphPath: "\(id)", parameters: ["fields" : "id, name, first_name"]).start { (conn, res, error) in
            print("facebook request. conn[\(conn)] data[\(res)] error[\(error)]")
        }*/
    }
    
    /**
        Open Page of specified User on Instagram App
        - parameter id: Instagram Account
        - parameter webOpen: Handler to open url
    */
    public func openInstagram(_ id : String, webOpen: ((URL) -> Void)? = nil){
        var instagramUrl = URL(string: "instagram://user?username=\(id)")!;

        if self.canOpenURL(instagramUrl){
            self.openCompatible(instagramUrl, options: [:], completionHandler: nil);
        }else{
            instagramUrl = URL(string: "https://www.instagram.com/\(id)")!;
            if webOpen != nil{
                webOpen!(instagramUrl);
            }else{
                self.openCompatible(instagramUrl, options: [:], completionHandler: nil);
            }
        }
        
        /*FBSDKGraphRequest(graphPath: "\(id)", parameters: ["fields" : "id, name, first_name"]).start { (conn, res, error) in
            print("facebook request. conn[\(conn)] data[\(res)] error[\(error)]")
        }*/
    }
    
    /**
         Open Page Kakao Story of specified User  on Kakao App
         - parameter id: Kakao Story Account Name
         - parameter webOpen: Handler to open url
     */
    public func openKakaoStory(_ id : String, webOpen: ((URL) -> Void)? = nil){
        let storyUrl = URL(string: "https://story.kaka.com/\(id)")!;
        if self.canOpenURL(storyUrl){
            self.openCompatible(storyUrl, options: [:], completionHandler: nil);
        }else{
            webOpen?(storyUrl);
            /*twitterUrl = URL(string: "https://story.kaka.com/\(id)/\(id)")!;
             if webOpen != nil{
             webOpen!(twitterUrl);
             }else{
             self.openCompatible(twitterUrl, options: [:], completionHandler: nil);
             }*/
        }
    }
    
    /**
         Open Page Kakao Plus Friends of specified User on Kakao App
         - parameter id: Kakao Plus Account Name
         - parameter webOpen: Handler to open url
     */
    public func openKakaoPlus(_ id : String, webOpen: ((URL) -> Void)? = nil){
        let storyUrl = URL(string: "https://pf.kakao.com/\(id)")!;
        if self.canOpenURL(storyUrl){
            self.openCompatible(storyUrl, options: [:], completionHandler: nil);
        }else{
            webOpen?(storyUrl);
            /*twitterUrl = URL(string: "https://story.kaka.com/\(id)/\(id)")!;
             if webOpen != nil{
             webOpen!(twitterUrl);
             }else{
             self.openCompatible(twitterUrl, options: [:], completionHandler: nil);
             }*/
        }
    }
    
    /**
        Open Safari with specified string as url
        - Parameter urlString: url to open with Safari
    */
    public func openWeb(_ urlString : String){
        let Url = URL(string: urlString)!;
        if self.canOpenURL(Url){
            self.openCompatible(Url, options: [:], completionHandler: nil);
        }
    }
    
    /**
        Open Mail App with specified email
        - Parameter email: E-mail address to open with Mail App
    */
    public func openEmail(_ email : String){
        let Url = URL(string: "mailto:\(email)")!;
        if self.canOpenURL(Url){
            self.openCompatible(Url, options: [:], completionHandler: nil);
        }
    }
    
    /**
        Open Message App with specified phone number
     - Parameter sms: Phone Number to open with Message App
    */
    public func openSms(_ sms : String){
        let Url = URL(string: "sms:\(sms)")!;
        if self.canOpenURL(Url){
            self.openCompatible(Url, options: [:], completionHandler: nil);
        }
    }
    
    /**
        Call to specified phone number
         - parameter phone: Phone number to call
    */
    public func openTel(_ phone : String){
        let Url = URL(string: "tel:\(phone)")!;
        if self.canOpenURL(Url){
            self.openCompatible(Url, options: [:], completionHandler: nil);
        }
    }
    
    /**
         Open Web Browser(Safari) with Google Site to search by given keyboard
        - parameter keyword: Keyword to search
        - parameter webOpen: Handler to open url
    */
    public func searchByGoogle(_ keyword : String, webOpen: ((URL) -> Void)? = nil){
        var urlComponents = URLComponents(string: "https://www.google.co.kr/search");
        urlComponents?.queryItems = [URLQueryItem(name: "q", value: keyword)];
        let url = urlComponents!.url!;
        
        if webOpen != nil{
            webOpen!(url);
        }else{
            self.openCompatible(url, options: [:], completionHandler: nil);
        }
    }
    
    /**
         Open Web Browser(Safari) with Daum Site to search by given keyboard
         - parameter keyword: Keyword to search
        - parameter webOpen: Handler to open url
     */
    public func searchByDaum(_ keyword : String, webOpen: ((URL) -> Void)? = nil){
        var urlComponents = URLComponents(string: "http://search.daum.net/search");
        urlComponents?.queryItems = [URLQueryItem(name: "q", value: keyword)];
        let url = urlComponents!.url!;
        
        if webOpen != nil{
            webOpen!(url);
        }else{
            self.openCompatible(url, options: [:], completionHandler: nil);
        }
    }
    
    /**
         Open Web Browser(Safari) with Naver Site to search by given keyboard
         - parameter keyword: Keyword to search
        - parameter webOpen: Handler to open url
     */
    public func searchByNaver(_ keyword : String, webOpen: ((URL) -> Void)? = nil){
        var urlComponents = URLComponents(string: "http://search.naver.com/search.naver");
        urlComponents?.queryItems = [URLQueryItem(name: "query", value: keyword)];
        let url = urlComponents!.url!;
        
        if webOpen != nil{
            webOpen!(url);
        }else{
            self.openCompatible(url, options: [:], completionHandler: nil);
        }
    }
    
    /**
        Show Network Indicator asynchronously
    */
    public static func onNetworking(){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        }
    }
    
    /**
         Hide Network Indicator asynchronously
     */
    public static func offNetworking(){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
        }
    }
    
    /**
         Most Top View Controller of first window of this application
     */
    public var mostTopViewController : UIViewController?{
        return self.windows.first?.rootViewController?.mostTopViewController;
    }
    
    /**
        Indication whether this application is on foreground
    */
    public var isForeground : Bool{
        return [UIApplication.State.active].contains(UIApplication.shared.applicationState);
    }
    
    /**
        Indication whether this application is in background
     */
    public var isBackground : Bool{
        return [UIApplication.State.inactive, UIApplication.State.background].contains(UIApplication.shared.applicationState);
    }
    
    /**
         Value of property named of 'CFBundleVersionString' in Info.plist
     */
    public var buildVersion : String{
        get{
            var value = Bundle.main.localizedInfoDictionary?["CFBundleVersion"] as? String;
            if value == nil{
                value = Bundle.main.infoDictionary?["CFBundleVersion"] as? String;
            }
            
            return value ?? "";
        }
    }
    
    /**
        Whether this iOS version is fixed the bug that user can't touch navigation bar with search bar(UISearchController)
     */
    public var isHasSearchNavigationBarTouchBug: Bool {
        if #available(iOS 13.2, *) {
            return false
        }else{
            return true;
        }
//        if #available(iOS 13.0, *) {
//            return true
//        }
        //return false
    }
    
    /// Increases app icon badge number
    open func increaseBadgeNumber(){
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber.advanced(by: 1);
    }
    
    /// Decrease app icon badge number
    open func decreaseBadgeNumber(){
        UIApplication.shared.applicationIconBadgeNumber = max(UIApplication.shared.applicationIconBadgeNumber.advanced(by: -1), 0);
    }
}
