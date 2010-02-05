$(document).ready(function() {
   $('body').addClass('advanced');
   var contents = $('div#content section');
   buildMatrix(contents);
   $(window).resize(function(){
      buildMatrix(contents)
   });
   contents.click(function() {
      var next = $(this).next().get(0);
      if(next) {
         $('body').scrollTo(next,800);
      } else {
         $('body').scrollTo($(this).siblings().get(0),800);
      }
   });
});

function buildMatrix (contents) {
   var matrix = {
      cellHeight: $(window).height(),
      cellWidth: $(window).width(),
      size: contents.size()
   }
   
   contents.each(function(index) {
      $(this).css('left',index*matrix.cellWidth);
   });
}