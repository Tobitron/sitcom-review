$('.set_rating').raty({
                  path: "/assets/",
                  score: function(){
                    return $(this).attr('data-score');
                  }
});

$('.avg_rating').raty({
                 path: "/assets/",
                 readOnly: true,
                 score: function(){
                   return $(this).attr('data-score');
                 }
});

$('.review_rating').raty({
                    path: "/assets/",
                    readOnly:true,
                    score: function(){
                      return $(this).attr('data-score');
                    }
});
