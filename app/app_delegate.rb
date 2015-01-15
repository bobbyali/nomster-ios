class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    $places = Places.new 
    $places.get_list_from_server 

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    tabbar = UITabBarController.alloc.init
    tabbar.viewControllers = [PlacesMapController.alloc.init, PlacesListController.alloc.init]
    tabbar.selectedIndex = 0
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(tabbar)
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible

    true    
  end

  def place_details_controller
    @place_details_controller ||= PlaceDetailsController.alloc.init
  end 
end
