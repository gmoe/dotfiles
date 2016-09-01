"use strict";	

(function() {

  var canvas = document.createElement('canvas');
  var size = 32;
  canvas.width = size; canvas.height = size;
  var ctx = canvas.getContext('2d');
  ctx.fillStyle = "#FFF";
  ctx.fillRect(0, 0, 64, 64);

  var colors = ['242,56,90', '245,165,3', '233,241,223', '74,217,217', '54,177,191'];

  var lineWidth = (size*2)/colors.length;

  for(var i=0; i < colors.length; i++) {
    ctx.strokeStyle = 'rgb('+colors[i]+')';
    ctx.lineWidth = lineWidth + 2;
    ctx.beginPath();
    ctx.moveTo(0,lineWidth*(i+1)+2);
    ctx.lineTo(lineWidth*(i+1)+2,0);
    ctx.stroke();
  }

  var link = document.createElement('link');
  link.type = 'image/x-icon';
  link.rel = 'shortcut icon';
  link.href = canvas.toDataURL("image/x-icon");
  document.getElementsByTagName('head')[0].appendChild(link);

}());
