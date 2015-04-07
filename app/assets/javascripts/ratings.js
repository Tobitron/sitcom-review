$('.set_rating').raty({
                  path: "<%= asset_path('/assets/') %>",
                  score: function(){
                    return $(this).attr('data-score');
                  }
});

$('.avg_rating').raty({
                 path: "<%= asset_path('/assets/') %>",
                 readOnly: true,
                 score: function(){
                   return $(this).attr('data-score');
                 }
});

$('.review_rating').raty({
                    path: "<%= asset_path('/assets/') %>",
                    readOnly:true,
                    score: function(){
                      return $(this).attr('data-score');
                    }
});

//when you click it should set current_user's review.rating to the selected star
