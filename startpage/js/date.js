"use strict";

(function() {

  mDate(); 
  setInterval(mDate, 1000);

  function mDate() {
    var d = new Date();
    var mDate = d.getDate();
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var m = d.getMonth();
    var y = d.getFullYear();
    var h = d.getHours();
    var min = d.getMinutes(); 
    min = (min < 10) ? "0"+min : min;
    var meri = (h >= 12) ? "pm" : "am";
    document.getElementById("date").innerHTML = (mDate+" "+months[m]+" "+y+" | "+((h > 12) ? h%12 : h)+":"+min+meri);
  }

}());
