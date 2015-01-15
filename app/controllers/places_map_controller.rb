class PlacesMapController < UIViewController
  def init
    if super
      self.tabBarItem = UITabBarItem.alloc.initWithTitle('Map', image:UIImage.imageNamed('map.png'), tag:1)
    end
    self
  end

  def loadView
    self.view = MKMapView.alloc.init
    view.delegate = self
  end

  def viewDidLoad
    view.frame = tabBarController.view.bounds
    
    coords_for_first_place = $places.get_place(0).coordinate
    region = MKCoordinateRegionMake(coords_for_first_place, MKCoordinateSpanMake(0.5, 0.5))

    self.view.setRegion(region)

    $places.get_places.each { |place| self.view.addAnnotation(place) }    
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(true, animated:true)
  end    

  ViewIdentifier = 'ViewIdentifier'
  def mapView(mapView, viewForAnnotation:place)
    if view = mapView.dequeueReusableAnnotationViewWithIdentifier(ViewIdentifier)
      view.annotation = place
    else
      view = MKPinAnnotationView.alloc.initWithAnnotation(place, reuseIdentifier:ViewIdentifier)
      view.canShowCallout = true
      view.animatesDrop = true
      button = UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
      button.addTarget(self, action: :'showDetails:', forControlEvents:UIControlEventTouchUpInside)
      view.rightCalloutAccessoryView = button
    end
    view
  end

  def showDetails(sender)
    if view.selectedAnnotations.size == 1
      place = view.selectedAnnotations[0]
      controller = UIApplication.sharedApplication.delegate.place_details_controller
      navigationController.pushViewController(controller, animated:true)
      controller.showDetailsForPlace(place)
    end
  end
end
