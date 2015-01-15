class Places
  attr_accessor :places 
  
	def initialize
    @places = []
    lat = 51.496573
    long = -0.176904
    name = "Natural History Museum"
    address = "Cromwell Road, London SW7 5BD"
    description = "A London favourite. Amazing dinosaur skeletons (although most were \"on holiday\" when we visited) and a full-scale model blue whale which is seriously impressive!"
    id = 1;
    init_place = Place.new(lat, long, name, address, description, id)
    @places << init_place
  end

  def get_place(index)
    @places[index]
  end

  def get_places
    @places
  end

  def get_list_from_server
    BubbleWrap::HTTP.get("https://nomster-rehan-ali.herokuapp.com/all.json") do |response|
      if response.ok?
        result_data = BubbleWrap::JSON.parse(response.body.to_str)
        result_data.each do |result|
          lat = result[:latitude]
          long = result[:longitude]
          name = result[:name]
          address = result[:address]
          description = result[:description]
          id = result[:id]
          new_place = Place.new(lat, long, name, address, description, id)          
          @places << new_place 
        end

        vc = App.delegate.instance_variable_get("@window")
        pmc = vc.rootViewController.viewControllers[0].viewControllers[0]
        pmc.viewDidLoad

      else
        App.alert(response.error_message)
      end
    end
  end

end