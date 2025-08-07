# Load required libraries
library(leaflet)
library(htmltools)
library(htmlwidgets)
library(dplyr)

# Define your journey points with coordinates and descriptions
journey_points <- data.frame(
  lat = c(40.7128, 47.6062, 71.2906, 38.1041, 22.232, 37.7749, 36.6177, 34.4208),
  lng = c(-74.0060, -122.3321, -156.7886, -122.2566, -159.402, -122.4194, -121.8746, -119.6982),
  name = c("New York, NY", "Seattle, WA", "Utgiagvik, AK", 
           "Vallejo, CA", "Kilauea, HI", "San Francisco, CA", 
           "Pacific Grove, CA", "Santa Barbara, CA"),
  description = c(
    "Undergrad in computer science",
    "Software developer at Microsoft",
    "Seabirds in the Alaskan Arctic",
    "Counting ducks for USGS",
    "Tracking seabirds in Hawaii",
    "MS in GIS",
    "PhD in Marine Biology",
    "Teaching MEDS and Marine Science"
  ),
  order = 1:8
)

# Create the base map
create_journey_map <- function() {
  # Create base map centered to show all points
  map <- leaflet() %>%
    addTiles(options = tileOptions(attribution = 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a>')) %>%
    fitBounds(lng1 = min(journey_points$lng) - 2, 
              lat1 = min(journey_points$lat) - 2,
              lng2 = max(journey_points$lng) + 2, 
              lat2 = max(journey_points$lat) + 2)
  
  # Custom JavaScript for reveal.js integration
  animation_js <- sprintf('
  function(el, x) {
    var map = this;
    var points = %s;
    var currentIndex = 0;
    var animatedLine = L.polyline([], {
      color: "#FF6B35", 
      weight: 4, 
      opacity: 0.8,
      dashArray: "10, 10"
    }).addTo(map);
    
    var markers = [];
    
    // Add progress indicator
    var progressControl = L.control({position: "topright"});
    progressControl.onAdd = function(map) {
      var div = L.DomUtil.create("div", "progress-control");
      div.innerHTML = `
        <div id="journey-progress" style="
          background: rgba(255, 107, 53, 0.9); 
          color: white; 
          border: none; 
          padding: 8px 12px; 
          border-radius: 5px;
          font-weight: bold;
          box-shadow: 0 2px 4px rgba(0,0,0,0.2);
          font-size: 14px;
        ">Journey: 0 / ${points.length}</div>
      `;
      return div;
    };
    progressControl.addTo(map);
    
    // Create custom icon for markers
    var customIcon = L.divIcon({
      html: `<div style="
        background: #FF6B35; 
        border: 3px solid white; 
        border-radius: 50%%; 
        width: 20px; 
        height: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.3);
      "></div>`,
      className: "custom-marker",
      iconSize: [20, 20],
      iconAnchor: [10, 10]
    });
    
    function addNextLocation() {
      if (currentIndex >= points.length) return;
      
      var point = points[currentIndex];
      var latLng = [point.lat, point.lng];
      
      // Add point to animated line
      animatedLine.addLatLng(latLng);
      
      // Create popup content
      var popupContent = `
        <div style="text-align: center; font-family: Arial, sans-serif;">
          <h4 style="margin: 5px 0; color: #FF6B35;">${point.name}</h4>
          <p style="margin: 5px 0; font-size: 14px; color: #666;">${point.description}</p>
          <small style="color: #999;">Stop ${point.order} of ${points.length}</small>
        </div>
      `;
      
      // Add marker
      var marker = L.marker(latLng, {icon: customIcon}).addTo(map);
      marker.bindPopup(popupContent, {
        maxWidth: 300,
        className: "custom-popup"
      });
      markers.push(marker);
      
      // Pan to point
      map.flyTo(latLng, map.getZoom() > 6 ? map.getZoom() : 6, {
        animate: true,
        duration: 1.5
      });
      
      // Show popup after pan
      setTimeout(function() {
        marker.openPopup();
      }, 1000);
      
      currentIndex++;
      
      // Update progress
      document.getElementById("journey-progress").innerHTML = 
        `Journey: ${currentIndex} / ${points.length}`;
    }
    
    // Global function to advance map animation
    window.advanceJourney = function() {
      addNextLocation();
    };
    
    // Reveal.js integration - listen for fragment events
    if (typeof Reveal !== "undefined") {
      Reveal.on("fragmentshown", function(event) {
        if (event.fragment.classList.contains("journey-step")) {
          addNextLocation();
        }
      });
      
      Reveal.on("fragmenthidden", function(event) {
        if (event.fragment.classList.contains("journey-step") && currentIndex > 0) {
          // Remove last location when going backwards
          currentIndex--;
          var lastMarker = markers.pop();
          if (lastMarker) map.removeLayer(lastMarker);
          
          var lineCoords = animatedLine.getLatLngs();
          if (lineCoords.length > 0) {
            lineCoords.pop();
            animatedLine.setLatLngs(lineCoords);
          }
          
          document.getElementById("journey-progress").innerHTML = 
            `Journey: ${currentIndex} / ${points.length}`;
            
          // Pan to previous location
          if (currentIndex > 0) {
            var prevPoint = points[currentIndex - 1];
            map.flyTo([prevPoint.lat, prevPoint.lng], map.getZoom());
          }
        }
      });
    }
    
    // Add custom CSS
    var style = document.createElement("style");
    style.textContent = `
      .custom-popup .leaflet-popup-content-wrapper {
        border-radius: 8px;
        box-shadow: 0 3px 6px rgba(0,0,0,0.16);
      }
      .custom-popup .leaflet-popup-tip {
        background: white;
      }
      .animation-control {
        background: transparent;
        border: none;
      }
      #start-animation:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
      }
      .journey-step {
        opacity: 0;
        transition: opacity 0.3s ease;
      }
      .journey-step.visible {
        opacity: 1;
      }
    `;
    document.head.appendChild(style);
  }
  ', jsonlite::toJSON(journey_points, auto_unbox = TRUE))
  
  # Apply the JavaScript to create the interactive map
  map %>% onRender(animation_js)
}

# Create and display the map
journey_map <- create_journey_map()