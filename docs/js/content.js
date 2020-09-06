


function tabMap(){
    let containerDiv=document.getElementById("ratRates"),
    // url="https://public.tableau.com/views/over_150_ppp/Dashboard1?:language=en&:display_count=y&publish=yes&:origin=viz_share_link"
    
    url='https://public.tableau.com/shared/PZ36XNTJP?:display_count=y&:origin=viz_share_link'
    let viz = new tableau.Viz(containerDiv, url);
    
}
$(document).ready(function(){
       
        tabMap()
        });



// initViz()
// $( window ).load(function() {
//     initViz()
//   });
// $(document).ready(function(){
//     	$('.content').css({
//           'margin-top':$('.jumbotron').outerHeight()
          
//       });
//     });

// document.getElementById("demo").innerHTML = "Hello World!";






// initViz()
// $( window ).load(function() {
//     initViz()
//   });
// $(document).ready(function(){
//     	$('.content').css({
//       	'margin-top':$('.jumbotron').outerHeight()
//       });
//     });

// document.getElementById("demo").innerHTML = "Hello World!";