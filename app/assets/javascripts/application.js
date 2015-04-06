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
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

$(function() {
  $('.flash-messages').delay(1500).fadeOut(600);
});

$('.set_rating').raty({
                  path: '/assets/',
                  score: function(){
                    return $(this).attr('data-score');
                  }
});

$('.avg_rating').raty({
                 path: '/assets/',
                 readOnly: true,
                 score: function(){
                   return $(this).attr('data-score');
                 }
});

$('.review_rating').raty({
                    path: '/assets/',
                    readOnly:true,
                    score: function(){
                      return $(this).attr('data-score');
                    }
});

//when you click it should set current_user's review.rating to the selected star
