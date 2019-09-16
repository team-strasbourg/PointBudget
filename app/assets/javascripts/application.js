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
      $('#consumption').show(600);
      $('#estimation').hide(600);
  });

  radioNo.addEventListener('click', function(){
      $('#consumption').hide(600);
      $('#estimation').show(600);
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



if ($("body").data("controller") == "full_simulations" && $("body").data("action") == "new"){
  clickToDisplayDomains = document.getElementById("btn-click-1")

  clickToDisplayDomains.addEventListener('click', function(){
    $("#domain-list").toggle(600);
  })
};

if ($("body").data("controller") == "full_simulations" && $("body").data("action") == "show"){
  clickToDisplayEnergies = document.getElementById("btn-energy")

  clickToDisplayEnergies.addEventListener('click', function(){
    $("#energy-categories").toggleClass("d-flex");
    $("#energy-categories").toggle(1000);
    
  })
};

if (document.cookie !== "username=guest"){
  navCollapse = document.getElementById("nav-user-collapse")
  userNavStatus = true ;

  navCollapse.addEventListener('click', function() {
    if (userNavStatus == true) {
        $('#sidenav').animate({
            right: $('#sidenav').width()
        });
        $('#body_content_user').animate({
            right: $('#sidenav').width()/2
        });
      document.getElementById("nav-arrow").classList.remove("fa-angle-left");
      document.getElementById("nav-arrow").classList.add("fa-angle-right");
      userNavStatus = false
    }
    else if (userNavStatus == false) {
        $('#sidenav').animate({
            right: '0px'
        });
        $('#body_content_user').animate({
            right: '0px'
        });
      document.getElementById("nav-arrow").classList.remove("fa-angle-right");
      document.getElementById("nav-arrow").classList.add("fa-angle-left");
      userNavStatus = true
    }
  });
};

});
