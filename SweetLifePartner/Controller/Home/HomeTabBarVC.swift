
import UIKit

class HomeTabBarVC: UITabBarController {
    
    //MARK: Properties
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height } ()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let newTabBarHeight = defaultTabBarHeight
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        tabBar.frame = newFrame
        DispatchQueue.main.async {
            self.tabBar.isTranslucent = true
            self.tabBar.backgroundColor = .white
            self.tabBar.tintColor = #colorLiteral(red: 0.9411141276, green: 0.2281579971, blue: 0.4627662301, alpha: 1)
        }
    }
    
    fileprivate func setupTabs() {
        
        let strybd = UIStoryboard(name: "Main", bundle: nil)
        
        let profileVC = strybd.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        profileVC.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "my_shaadi"), selectedImage: #imageLiteral(resourceName: "my_shaadi"))
        
        let matchesVC = strybd.instantiateViewController(withIdentifier: "MatchesVC") as! MatchesVC
        matchesVC.tabBarItem = UITabBarItem(title: "Matches", image: #imageLiteral(resourceName: "match"), selectedImage: #imageLiteral(resourceName: "match"))
        
        let inboxVC = strybd.instantiateViewController(withIdentifier: "InboxVC") as! InboxVC
        inboxVC.tabBarItem = UITabBarItem(title: "Inbox", image: #imageLiteral(resourceName: "inbox"), selectedImage: #imageLiteral(resourceName: "inbox"))
        
        let chatVC = strybd.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        chatVC.tabBarItem = UITabBarItem(title: "Chat", image: #imageLiteral(resourceName: "chat"), selectedImage: #imageLiteral(resourceName: "chat"))
        
        let notificationVC = strybd.instantiateViewController(withIdentifier: "NotifiactionsVC") as! NotifiactionsVC
        notificationVC.tabBarItem = UITabBarItem(title: "Notify", image: #imageLiteral(resourceName: "notification-4"), selectedImage: #imageLiteral(resourceName: "notification-4"))
        
        let controllers = [profileVC, matchesVC, inboxVC, chatVC, notificationVC]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
    }
}
