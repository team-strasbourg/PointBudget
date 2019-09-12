// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
// require turbolinks
//= require_tree .
//= require jquery3
//= require jquery_ujs

//= require js/pixel

//= require vendor/jquery/jquery.min
//= require vendor/popper/popper.min
//= require vendor/bootstrap/bootstrap.min
//= require vendor/headroom/headroom.min
//= require vendor/bootstrap-tagsinput/bootstrap-tagsinput.min
//= require vendor/waypoints/jquery.waypoints.min
//= require vendor/smooth-scroll/smooth-scroll.polyfills.min
//= require vendor/prism/prism
//= require js/all
//= require_self

$(document).ready(function () {


  radioYes = document.getElementById("answer_yes")
  radioNo = document.getElementById("answer_no")

  radioYes.addEventListener('click', function(){

      document.getElementById('consumption').style.display = "block"
      document.getElementById('estimation').style.display = "none"

  });


  radioNo.addEventListener('click', function(){

      document.getElementById('estimation').style.display = "block"
      document.getElementById('consumption').style.display = "none"

  });

});
