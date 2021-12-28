import UIKit

class Constants {
    
    static let kAppDelegate          = UIApplication.shared.delegate as! AppDelegate
    static let kScreenWidth          = UIScreen.main.bounds.width
    static let kScreenHeight         = UIScreen.main.bounds.height
    static let kAppDisplayName       = UIApplication.appName
    static let kUserDefaults         = UserDefaults.standard
    static var kTest                 = 1
    static var optionColor           = "#EEFEEF7"
    static var UDID                  = UIDevice.current.identifierForVendor?.uuidString ?? ""
    static var KBundleID             = Bundle.main.bundleIdentifier
}

// MARK: - Failed Errors
public struct ConstantsErrors {
    
    static let kNoInternetConnection = NSError(domain: Constants.kAppDisplayName, code: NSURLErrorNotConnectedToInternet, userInfo: [NSLocalizedDescriptionKey: ConstantsMessages.kConnectionFailed])
    
    static let kCancelledFacebook = NSError(domain: Constants.kAppDisplayName, code: 1000000, userInfo: [NSLocalizedDescriptionKey : "Vous avez annulé votre connexion à Facebook."])
    
    static let kDeclinedFacebookPermissions = NSError(domain: Constants.kAppDisplayName, code: 1000001, userInfo: [NSLocalizedDescriptionKey : "Vous avez refusé les autorisations Facebook."])
    
    static let kSomethingWrong = NSError(domain: Constants.kAppDisplayName, code: 1000002, userInfo: [NSLocalizedDescriptionKey : "Quelque chose s'est mal passé.Veuillez réessayer bientôt !"])
}

public struct ConstantsMessages {
    
    static let kConnectionFailed    = NSLocalizedString("Il semble qu'il y ait un problème dans votre connexion Internet. Veuillez réessayer après un certain temps.", comment :"NetworkError")
    static let kNetworkFailure      = NSLocalizedString("semble qu'il y ait une erreur de réseau, veuillez essayer après un certain temps.", comment :"NetworkError")
    static let kSomethingWrong      = NSLocalizedString("Quelque chose a mal tourné. Veuillez réessayer bientôt !", comment :"NetworkError")
}

public func convertDateFormater(_ date: String, _ formatFrom: String = "", _ format: String = "dd-MM-yyyy") -> String {
    let dateFormatter = DateFormatter()
    if formatFrom == "" {
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
    } else {
        dateFormatter.dateFormat = formatFrom
    }
//    dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0].hasPrefix("fr") ? "fr_FR" : "en_US")
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = format
    return  dateFormatter.string(from: date!)
}
