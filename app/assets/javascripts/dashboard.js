$('#scrollTop').on('click', function () {
  $("html, body").animate({ scrollTop: 0 }, "slow");  
  return false;
});

// $("scroll-top").click(function() {  
//   $("html, body").animate({ scrollTop: 0 }, "slow");  
//   return false;  
// });