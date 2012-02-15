$(document).ready(function() {
   $('body').addClass('advanced');
   var contents = $('div#content section');
   buildMatrix(contents);
   $(window).resize(function(){
      buildMatrix(contents);
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