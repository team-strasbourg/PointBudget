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

if($("body").data("controller") == "gas_simulations" && $("body").data("action") == "new") {
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
} else if($("body").data("controller") == "full_simulations" && $("body").data("action") == "show"){
  try {
    $('.btn-block')[0].on('click', function () {
      $('#myModal').trigger('focus');
    })
  }
  catch(error){
  }
}


if (document.cookie != "username=guest"){
  navCollapse = document.getElementById("nav-user-collapse")
  userNavStatus = true ;

  navCollapse.addEventListener('click', function() {
    if (userNavStatus == true) {
      document.getElementById("sidenav").style.marginLeft = "-15%";
      document.getElementById("body_content_user").classList.remove("col-md-9", "col-lg-10")
      document.getElementById("body_content_user").classList.add("col-md-11")
      document.getElementById("nav-arrow").classList.remove("fa-angle-left")
      document.getElementById("nav-arrow").classList.add("fa-angle-right")
      userNavStatus = false
    }
    else if (userNavStatus == false) {
      document.getElementById("sidenav").style.marginLeft = "0";
      document.getElementById("nav-arrow").classList.remove("fa-angle-right");
      document.getElementById("nav-arrow").classList.add("fa-angle-left");
      document.getElementById("body_content_user").classList.add("col-md-9", "ml-sm-auto", "col-lg-10")
      userNavStatus = true
    }
  });
};

});

/* MODAL VALIDATION FULL_SIMULATION */
