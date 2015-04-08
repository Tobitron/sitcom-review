$('.set_rating').raty({
                  score: function(){
                    return $(this).attr('data-score');
                  }
});

$('.avg_rating').raty({
                 readOnly: true,
                 score: function(){
                   return $(this).attr('data-score');
                 }
});

$('.review_rating').raty({
                    readOnly:true,
                    score: function(){
                      return $(this).attr('data-score');
                    }
});
