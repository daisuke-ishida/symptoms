// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

/*global $*/
$(document).on('ready page:load', function() {
      $('a[data-popup="true"]').live('click', function(e) {
            window.open($(this).href);
            e.preventDefault();
      });
});

window.onload = function (){
          var contentHeight = $("#content_border").height();
          var sidebarHeight = $("#sidebar_sub").height();
          var w = $("#window");
          
          if(sidebarHeight < contentHeight){
                $("#sidebar").css("height", contentHeight);
          var sidebarSub = $("#sidebar_sub");
          var sidebarScrollStop
          = $("#header_bar").height() + $("#sidebar_sub").height() +36 +24 - w.height();
          
          var sidebarScrollStart
          = $("#header_bar").height() + $("#content_border").height() +24 -w.height();
          
          w.scroll(function(){
                
                if(sidebarScrollStop<w.ScrollTop()
                && w.ScrollTop()<sidebarScrollStart){
                      sidebarSub.css({"position":"fixed","bottom":"24px"});
                }else if(w.ScrollTop()>sidebarScrollStart){
                      sidebarSub.css({"position":"absolute","bottom":"0"});
                }else{
                      sidebarSub.css({"position":"static"});
                      
                }
          });
          }
    }
