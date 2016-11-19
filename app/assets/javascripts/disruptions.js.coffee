# This function needs to be attached to the global scope as it is called
# implicitly by the Google MAP API. Otherwise, Coffeescript preprocessor wraps
# everything automatically into an anonymous function. Therefore, external
# script's visibility to the initMap() function is lost.
initMap= ->
  londonLatLng = new google.maps.LatLng(51.509865, -0.118092)
  mapOptions =
    zoom: 10
    center: londonLatLng

  # Create map
  map = new (google.maps.Map)($('#disruptions_map')[0], mapOptions)

  # Create empty cluster marker
  markerCluster = new MarkerClusterer(map, [],
    {imagePath: 'cluster_images/m', averageCenter: true})

  # Cache map and cluster marker object for later use
  $('#disruptions_map').data('marker-cluster', markerCluster)
  $('#disruptions_map').data('map', map)

  loadMarkers()
  setInterval () ->
    loadMarkers()
  , 30000

# Attach function to global scope
this.initMap = initMap

# Construct a <script> element and attach it to the end of the <body> to ensure
# that the maps API is loaded last.
$(document).on 'ready', ->
  if !@_script
    @_script = document.createElement("script")
    @_script.type = "text/javascript"
    src = "//maps.googleapis.com/maps/api/js?callback=initMap"
    src = "#{src}&key=#{Tims.SECRETS.GOOGLE_API_KEY}" if Tims.SECRETS.GOOGLE_API_KEY
    @_script.src = src
    document.body.appendChild(@_script)

loadMarkers= ->
  $.get('/api/v1/disruptions', null, null, 'json')
    .done (data) ->
      map = $('#disruptions_map').data('map')

      # Create the new markers
      markers = []
      data.forEach (elem)->
        latLngObject = new google.maps.LatLng(
          parseFloat(elem.split(",")[1]),
          parseFloat(elem.split(",")[0])
        )
        marker = new google.maps.Marker(
          position: latLngObject
        )
        markers.push marker

      # Create new cluster markers and cache them
      markerCluster = $('#disruptions_map').data('marker-cluster')
      markerCluster.clearMarkers()
      markerCluster.addMarkers(markers)
      $('#disruptions_map').data('marker-cluster', markerCluster)
    .fail (data) ->
      alert('Error loading disruption data from the server!')

# Attach function to global scope
this.loadMarkers = loadMarkers
