var current_timer_id = null;
var current_auto_update_timer_id = null;

function getCarAndCityData(position){
  var lat = position.lat(), lng = position.lng();

  $.ajax({
    url: "/city?lat=" + lat + "&lng=" + lng + "&csc=" + csc,
    method: 'get',
    dataType: 'json'
  }).done(function(city){
    $.ajax({
      url: "/nearest?lat=" + lat + "&lng=" + lng + "&cid=" + city.cityid + 
               "&csc=" + csc,
      method: 'get',
      dataType: 'json'
    }).done(function(data){
       $.each(data.cars, function(idx, car) {
         notifyCloseCars(car);
       });
    });
  });
}

function autoNotification() {
  try {
    getCarAndCityData(current_location);
  } catch (x) {
  }
  current_timer_id = setTimeout(autoNotification, 10000);
}

function autoUpdateCars() {
  try {
    var pos = {
      coords: {
        latitude: current_location.lat(),
        longitude: current_location.lng()
      }
    };
    updateMarkers(pos);
  } catch (x) {
  }
  current_auto_update_timer_id = setTimeout(autoUpdateCars, 10000);
}

$(document).ready(function(){
  $('#autonotify').change(function() {
     if(this.checked) {
       current_timer_id = setTimeout(autoNotification, 10000);
       listenForLocationChange();
     } else {
       if ( current_timer_id !== null ) {
         clearTimeout(current_timer_id);
         current_timer_id = null;
       }
       stopListeningForLocationChange();
     }
  });


  $('#autoupdate').change(function() {
     if(this.checked) {
       current_auto_update_timer_id = setTimeout(autoUpdateCars, 10000);
       listenForLocationChange();
     } else {
       if ( current_auto_update_timer_id !== null ) {
         clearTimeout(current_auto_update_timer_id);
         current_auto_update_timer_id = null;
       }
       stopListeningForLocationChange();
     }
  });
});


