class PlacesListController < UITableViewController
  def init
    if super
      self.tabBarItem = UITabBarItem.alloc.initWithTitle('List', image:UIImage.imageNamed('list.png'), tag:1)
    end
    self
  end

  def viewDidLoad
    view.dataSource = view.delegate = self
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(true, animated:true)
  end    

  def tableView(tableView, numberOfRowsInSection:section)
    $places.get_places.size
  end

  CELLID = 'CellIdentifier'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELLID) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CELLID)
      cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton
      cell.selectionStyle = UITableViewCellSelectionStyleNone
      cell
    end

    place = $places.get_place(indexPath.row)
    cell.textLabel.text = place.title
    cell
  end

  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath:indexPath)
    place = $places.get_place(indexPath.row)
    controller = UIApplication.sharedApplication.delegate.place_details_controller
    navigationController.pushViewController(controller, animated:true)
    controller.showDetailsForPlace(place)
  end
end
