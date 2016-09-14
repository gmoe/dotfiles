"use strict";

(function() {

var lat = 41.9905;
var lon = -87.7049;
var weatherURL = "http://forecast.weather.gov/MapClick.php?";
var weatherData = "lat="+lat+"&lon="+lon;

document.getElementById("weather-link").href = weatherURL + weatherData;

var url = weatherURL + weatherData + "&unit=0&lg=english&FcstType=xml";
var xhr = new XMLHttpRequest();

xhr.onload = function() {
  var hi = xhr.responseXML.getElementsByTagName("period")[0].getElementsByTagName("temp")[0].childNodes[0].nodeValue;
  var lo = xhr.responseXML.getElementsByTagName("period")[1].getElementsByTagName("temp")[0].childNodes[0].nodeValue;
  var cur = xhr.responseXML.getElementsByTagName("period")[0].getElementsByTagName("image")[0].childNodes[0].nodeValue;

  document.getElementById("weather").innerHTML = "<i class=\"wi "+insertIcon(cur)+"\"></i> "+hi+" / "+lo+" ˚ F";
};

xhr.onerror = function() {
  dump("Error while getting weather data.");
  document.getElementById("weather").style.visibility = "hidden";
}

xhr.ontimeout = function() {
  dump("Timed out while getting weather data.");
  document.getElementById("weather").style.visibility = "hidden";
}

xhr.timeout = 2000;
xhr.open("GET", url);
xhr.responseType = "document";
xhr.send();

function insertIcon(weather) {
  var regex1 = /newimages\/medium\/(\w+).png/;
  var regex2 = /DualImage\.php\?i=(\w+)&/;

  var image = regex1.exec(weather);
  if(image == null) {
    image = regex2.exec(weather);
  }

  switch(image[1]) {
    case "bkn":
    case "few":
    case "sct":
      return "wi-day-cloudy";
    case "nfew":
    case "nbkn":
    case "nsct":
      return "wi-night-alt-cloudy";
    case "skc":
      return "wi-day-sunny";
    case "nskc":
      return "wi-night-clear";
    case "ovc":
      return "wi-day-sunny-overcast";
    case "novc":
      return "wi-night-alt-partly-cloudy";
    case "fg":
      return "wi-day-fog";
    case "nfg":
      return "wi-night-fog";
    case "smoke":
      return "wi-smoke";
    case "fzra":
    case "mix":
    case "raip":
      return "wi-day-sleet";
    case "nmix":
      return "wi-night-sleet";
    case "ip":
      return "wi-day-hail";
    case "rasn":
      return "wi-day-rain-mix";
    case "nrasn":
      return "wi-night-alt-rain-mix";
    case "ra":
    case "ra1":
    case "hra":
    case "shra":
      return "wi-day-rain";
    case "nra":
      return "wi-night-alt-rain";
    case "hi_trsa":
    case "tsra":
      return "wi-day-thunderstorm";
    case "hi_ntrsa":
    case "ntsra":
      return "wi-night-alt-thunderstorm";
    case "sn":
      return "wi-day-snow";
    case "nsn":
      return "wi-night-alt-snow";
    case "wind":
      return "wi-day-windy";
    case "nwind":
      return "wi-night-alt-cloudy-gusts";
    case "hi_shwrs":
      return "wi-day-showers";
    case "hi_nshwrs":
      return "wi-night-alt-showers";
    case "nsvrtrsa":
      return "wi-tornado";
    case "dust":
      return "wi-dust";
    case "mist":
      return "wi-day-haze";
    default:
      return "";
  }
};

}());
