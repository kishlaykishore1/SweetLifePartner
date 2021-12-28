import UIKit
import Alamofire
import SystemConfiguration

open class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable     = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection) ? true : false
    }
    
}

enum API: String {
    
     var baseURL: String {
        #if DEBUG
        return "https://sweetlifepartner.com/"
        
        #else
        return "https://sweetlifepartner.com/"
        
        #endif
    }
    var apiURL: String {
        return "\(baseURL)webservice/"
    }
    var imageURL: String {
        return "\(baseURL)assets/uploads/users/"
    }
    
    /**
     When Update Api Version Please Update.
     - 'API_VERSION' on 'Constants.swift'
     */
    
    //  var encoding: ParameterEncoding {
    //    switch self {
    //    case .STATIC:
    //      return JSONEncoding.default
    //    default:
    //      return URLEncoding.default
    //    }
    //  }
    
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .STATIC:
            return .get
        default:
            return .post
        }
    }
    
    case STATIC                             = ""
    case USERLOGIN                          = "login"
    case SIGNUP                             = "sinup"
    case CHECKEMAIL                         = "check_email"
    case UPDATEABOUT                        = "update_about"
    case UPDATEPHOTO                        = "profile_photo"
    case FORGOTPASS                         = "forget_pass"
    case RESETPASSWORD                      = "change_password"
    case PROFILECREATEDFOR                  = "on_behalf"
    case RELIGION                           = "get_religion"
    case MOTHERTONGUE                       = "get_language"
    case MARITALSTATUS                      = "marital_status"
    case GETCASTE                           = "get_caste"
    case GETSUBCASTE                        = "get_sub_caste"
    case GETCOUNTRY                         = "get_country"
    case GETSTATE                           = "get_state"
    case GETCITY                            = "get_city"
    case FAMILYSTATUS                       = "get_family_status"
    case FAMILYVALUES                       = "get_family_value"
    case DECISION                           = "get_decision"
    case EDUCATIONCAREER                    = "education_and_career"
    case UPDATEEDUCATIONCAREER              = "update_education_and_career"
    case PHYSICALATTRIBUTE                  = "physical_attributes"
    case UPDATEPHYSICALATTRIBUTE            = "update_physical_attributes"
    case PROFILELANGUAGE                    = "get_profile_language"
    case UPDATEPROFILELANGUAGE              = "update_profile_language"
    case HOBBIESINTEREST                    = "hobbies_and_interest"
    case UPDATEHOBBIESINTEREST              = "update_hobbies_and_interest"
    case PERSONALATTITUDE                   = "personal_attitude_and_behavior"
    case UPDATEPERSONALATTITUDE             = "update_personal_attitude_and_behavior"
    case RESIDENCYINFO                      = "residency_information"
    case UPDATERESIDENCYINFO                = "update_residency_information"
    case SPIRITUALSOCIALINFO                = "spiritual_and_social_background"
    case UPDATESPIRITUALSOCIALINFO          = "update_spiritual_and_social_background"
    case LIFESTYLEINFO                      = "life_style"
    case UPDATELIFESTYLEINFO                = "update_life_style"
    case ASTROINFO                          = "astronomic_information"
    case UPDATEASTROINFO                    = "update_astronomic_information"
    case PARTNEREXPECTATION                 = "partner_expectation"
    case UPDATEPARTNEREXPECTATION           = "update_partner_expectation"
    case PERMANENTADDRESS                   = "permanent_address"
    case UPDATEPERMANENTADDRESS             = "update_permanent_address"
    case FAMILYINFO                         = "family_information"
    case UPDATEFAMILYINFO                   = "update_family_information"
    case ADDITIONALPERSONALINFO             = "additional_personal_details"
    case UPDATEADDITIONALPERSONALINFO       = "update_additional_personal_details"
    case PICTUREPRIVACY                     = "picture_privacy_setting"
    case UPDATEPICTUREPRIVACY               = "update_picture_privacy_setting"
    case GENERALSEARCH                      = "all_member"
    case ADDINTEREST                        = "add_interest"
    case ADDSHORTLIST                       = "add_shortlist"
    case ADDREPORT                          = "add_report"
    case ADDIGNORE                          = "add_ignore"
    case MESSAGEENABLE                      = "message_enable"
    case ADDFOLLOW                          = "add_follow"
    case GETMEMBERDETAILS                   = "member_detail"
    case GETMATCHES                         = "matches"
    case GETRECENTVISITORS                  = "recent_visitor"
    case GETNOTIFICATIONS                   = "notification"
    case GETRECENTCHATS                     = "recent_chat"
    case REMOVEFOLLOW                       = "add_unfollow"
    case REMOVESHORTLIST                    = "remove_shortlist"
    case RECEIVECHATLIST                    = "get_message"
    case SENDCHAT                           = "send_message"
    case GETGALLERY                         = "get_gallery"
    case ADDGALLERY                         = "add_gallery"
    case GETHAPPYSTORY                      = "happy_story"
    case ADDHAPPYSTORY                      = "add_happy_story"
    case UPADTEPROFILE                      = "update_profile"
    case APIINBOX                           = "inbox"
    case APIFOLLOWED                        = "get_member"
    
    
    static let alamofireManager: SessionManager = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 100
        return Alamofire.SessionManager(configuration: sessionConfiguration)
    }()
    
    func request(method: Alamofire.HTTPMethod = .post, with parameters: [String : Any]?, forJsonEncoding: Bool = false) -> Alamofire.DataRequest! {
        
        if !Reachability.isConnectedToNetwork() {
            Global.showAlert(withMessage:ConstantsMessages.kConnectionFailed)
            return nil
        } else {
            //            let manager = Alamofire.SessionManager.default
            //            manager.session.configuration.timeoutIntervalForRequest = 120
            // encoding: forJsonEncoding ? JSONEncoding.default : URLEncoding.default
            
            return API.alamofireManager.request(apiURL + self.rawValue, method: method, parameters: parameters, encoding: forJsonEncoding ? JSONEncoding.default : URLEncoding.default, headers: nil)
            
            //        return API.alamofireManager.request(apiURL + self.rawValue, method: method, parameters: parameters, headers: nil)
        }
    }
    func requestRaw(with parameters: [String: Any]!) -> URLRequest{
        
        let posturl: URL? = URL(string:apiURL + self.rawValue)
        
        var request = URLRequest(url: posturl!)
        request.httpMethod = "Post"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        return request
    }
    
    
    func requestUpload(with parameters: [String: Any]? = nil, files: [String: Any]? = nil , completionHandler:((_ jsonObject: [String: Any]?, _ error: Error?) -> Void)?) {
        
        Alamofire.upload( multipartFormData: { multipartFormData in
            // Attach image
            if let files = files {
                for (key, value) in files {
                    if let getImage = value as? UIImage {
                        let imageData = getImage.jpegData(compressionQuality: 0.5)
                        multipartFormData.append(imageData!, withName: key, fileName: "\(key).jpg", mimeType: "image/jpg")
                        
                        print("\(key).jpg")
                    } else if let getAudioUrl = value as? Data {
                        
                        // multipartFormData.append(songData_ as Data, withName: "audio", fileName: songName, mimeType: "audio/m4a")
                        
                        multipartFormData.append(getAudioUrl, withName: key, fileName: "\(key).m4a", mimeType: "audio/m4a")
                    }
                }
            }
            
            for (key, value) in parameters ?? [:]  {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        },to: apiURL + self.rawValue , method: .post , headers: self.headerRequest(),
          encodingCompletion: { encodingResult in
            
            self.validatedResponse(encodingResult, completionHandler: { (jsonObject, error) -> Void in
                completionHandler!(jsonObject, error )
            })
        })
    }
    
    func validatedResponse(_ response: DataResponse<Any>, completionHandler:((_ jsonObject: [String:Any]?, _ error:Error?) ->Void)?) {
        if let data = response.data {
            _ = String.init(data: data, encoding: String.Encoding.utf8)
        }
        
        switch response.result {
            
        case .success(let JSON):
            print("API NAME ********* \(self.rawValue)")
            print("Success with JSON: \(JSON)")
            let response = JSON as! [String: Any]
            
            let status = Global.getInt(for: response["status"] ?? 0)
            let getMessage = response["message"] as? String ?? ""
            // Successfully recieve response from server
            switch self {
            case .STATIC:
                completionHandler!(response, nil)
                
            default:
                
                if status == 1 { /*------- Success -----------*/
                    completionHandler!(response, nil)
                }else if status == 0 {  /*------- Records Not Found -----------*/
                    completionHandler!(nil, NSError(domain: Constants.kAppDisplayName, code: 204, userInfo:nil))
                    Common.showAlertMessage(message: getMessage, alertType: .warning)
                }else {
                    completionHandler!(nil, NSError(domain: Constants.kAppDisplayName, code: 402, userInfo:nil))
                    Common.showAlertMessage(message: getMessage, alertType: .error)
                    //Global.showAlert(withMessage: getMessage)
                }
                //                }else if status == 401 { /*------- Session exipred -----------*/
                //                    // Constants.kAppDelegate.logout()
                //                    Global.showAlert(withMessage: getMessage)
                //                }else { /*----------Error Handling ------------------*/
                //                    //Server Error Error Handling......
                //                    if let message = response["response_message"] {
                //                        let messageStr = (message as! String)
                //                        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.caseInsensitive])
                //                        let range = NSMakeRange(0, messageStr.count)
                //                        let htmlLessString :String = regex.stringByReplacingMatches(in: messageStr, options: [], range:range, withTemplate: "")
                //                        Global.showAlert(withMessage:htmlLessString as String)
                //                    }
                //                    completionHandler!(nil, NSError(domain: Constants.kAppDisplayName, code: 404, userInfo:nil))
                //                }
            }
            
        case .failure(let error):
            
            print("Request failed with error: \(error)")
            
            // recieve response from server
            switch self {
            case .STATIC:
                Global.showAlert(withMessage:ConstantsMessages.kSomethingWrong)
                completionHandler!(nil, error as NSError?)
            default:
                //let requestURLstring:String = (response.request?.URL?.description)!
                
                if let data = response.data {
                    Common.showAlertMessage(message: ConstantsMessages.kNetworkFailure, alertType: .error)
                    
                    let responceData = String(data: data, encoding:String.Encoding.utf8)!
                    print("**** SerializationFailed\n\(responceData) \n ****")
                    completionHandler!(nil, error as NSError?)
                } else {
                    Common.showAlertMessage(message: ConstantsMessages.kNetworkFailure, alertType: .error)
                    completionHandler!(nil, error as NSError?)
                }
            }
        }
    }
    
    func validatedResponse(_ response: SessionManager.MultipartFormDataEncodingResult, completionHandler:((_ jsonObject: [String: Any]?, _ error: Error?) ->Void)?) {
        
        switch response {
        case .success(let JSON,_,_):
            JSON.responseJSON { responseResult in
                print(responseResult)
                if responseResult.data != nil  {
                    print("Success with JSON: \(String(describing: String.init(data: responseResult.data!, encoding: String.Encoding.utf8)))")
                    _ = String.init(data: responseResult.data!, encoding: String.Encoding.utf8)
                }
                if responseResult.result.value == nil {
                    
                    completionHandler!(nil, NSError(domain: Constants.kAppDisplayName, code: 404, userInfo:nil))
                    Global.showAlert(withMessage: ConstantsMessages.kConnectionFailed)
                    return ;
                }
                guard let response = responseResult.result.value as? [String: Any] else {
                    return  completionHandler!(nil, NSError(domain: Constants.kAppDisplayName, code: 404, userInfo:nil))
                }
                
                let status = Global.getInt(for: response["status"] ?? 0)
                let getMessage = response["message"] as? String ?? ""
                // Successfullu recieve response from server
                switch self {
                case .STATIC:
                    completionHandler!(response, nil)
                default:
                    
                    if status == 1 { /*------- Success -----------*/
                        completionHandler!(response, nil)
                    }else if status == 0 { /*------- Success -----------*/
                        // Constants.kAppDelegate.logout()
                        Global.showAlert(withMessage: getMessage)
                    } else { /*----------Error Handling ------------------*/
                        //Server Error Error Handling......
                        if let message = response["message"] {
                            let messageStr = (message as! String)
                            let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.caseInsensitive])
                            let range = NSMakeRange(0, messageStr.count)
                            let htmlLessString :String = regex.stringByReplacingMatches(in: messageStr, options: [], range:range, withTemplate: "")
                            
                            Common.showAlertMessage(message: htmlLessString as String, alertType: .error)
                        }
                        
                        completionHandler!(nil, NSError(domain: Constants.kAppDisplayName, code: 404, userInfo:nil))
                    }
                }
            }
        case .failure(let error):
            completionHandler!(nil, error as NSError?)
            
            Common.showAlertMessage(message: ConstantsMessages.kConnectionFailed, alertType: .error)
        }
    }
    
    /// Configure Headers
    
    private func headerRequest() -> [String : String] {
        
        //    var headers = [String : String]()
        //    headers["AUTH-TOKEN"] = Constants.kUser.accessToken ?? "" //Constants.kAppDelegate.user!.authToken
        //    headers["LANG-TYPE"] = "1"
        return [:]
    }
}

