numVisible=3;
numActive=undefined;
numPrevious=undefined;
numDir=1;
refreshIntervalId = 0;

// maxWidth is the maximum width of the content in the window, this is hard coded
// TODO: Dynamically access the max width of the document by querying the CSS
var maxWidth = 1024;

// Toggle slides gets called based on a timer, when it is called it rotates
// the carousel by 1 slide
function toggleSlides(d) 
{
  //console.log(d);

  var slides = $('.slide');
  var lastSlide = slides.length - 1;
  var legend = $('.legend');
  //console.log(numActive);

  if ( d === 'interval' ) 
  { 
    d = numDir 
  } 
  else 
  { 
    //clearInterval(refreshIntervalId); 
  }

  var skip = false;
  if (( d === -1 ) && (numActive === 0)) 
  { 
    numDir = 1; 
    skip = true; 
  }
  if (( d === 1 ) && (numActive === (lastSlide-numVisible-1))) 
  { 
    numDir = -1; 
    skip=true; 
  }
  if (skip === true) 
  { 
    numPrevious = numActive; 
    return; 
  }
  numActive += d;
  var show = numActive+numVisible-1;
  var hide = numActive-1;
  if (numPrevious > numActive) 
  {
    hide = numActive+numVisible;
    show = numActive;
  }
  //console.log("hide: " + hide + " show: " + show);

  // This switch scales the carousel width based on the number of slides in it 
  switch(numVisible){
    case 1:
      slides[hide].className = "slide dn center w-100 w-100-ns w-50-m pa2";
      slides[show].className = "slide active center w-100 w-100-ns w-50-m pa2";
      break;
    case 2:
      slides[hide].className = "slide dn fl w-100 w-50-ns w-50-m pa2";
      slides[show].className = "slide active fl w-100 w-50-ns w-50-m pa2";
      break;
    case 3:
      slides[hide].className = "slide dn fl w-100 w-third-ns w-50-m pa2";
      slides[show].className = "slide active fl w-100 w-third-ns w-50-m pa2";
      break;
    default:
      console.log("ERROR: toggleSlides: numVisible must be 1, 2 or 3, it is: " + numVisible);
      break;
  }

  legend[numPrevious].className = "legend o-100";
  legend[numActive].className = "legend o-20";

  // Alternatively, use switchClass from jQueryUI?
  document.getElementById('btn-left').className = ( numActive === 0 ) ? "not-active o-20" : "o-100";
  document.getElementById('btn-right').className = ( numActive === (lastSlide-numVisible-1) ) ? "not-active o-20" : "o-100";
  numPrevious = numActive;
}
//toggleSlides('interval');

// Taken from https://www.caveofprogramming.com/javascript-tutorial/javascript-html-generating-html-and-embedding-javascript-in-html.html
// This function takes the formatted HTML
// and inserts it into the document as
// 'child' HTML of the specified element.
function insertHTML(id, html) {
  var el = document.getElementById(id);
    
  if(!el) {
    alert('Element with id ' + id + ' not found.');
  }
    
  el.innerHTML = html;
}

// Init is called when the page is loaded, it sets up the carousel and sets a 
// 5 second refresh period
function init()
{
  setUpCarousel();
  refreshIntervalId = setInterval(function(){ toggleSlides('interval'); }, 5000);
}

// Everytime the window changes size we need to recalculate everything for the carousel
function resizeDetect()
{
  setUpCarousel()
}

// setUpCarousel initializes the content carousel in the middle of the page
// it calculates how many slides will be presented at a time based on the width
// of the page. 
// This function is called on init and whenever the window is resized
function setUpCarousel()
{
  // Find the width of the document when it is loaded.
  var element = document.getElementById('slideshow'),
    style = window.getComputedStyle(element),
    loadWidth = style.getPropertyValue('width');
  
  // Calculate the number of visible slides based on window width
  numVisible = Math.floor(parseInt(loadWidth)/(maxWidth/3));
  if(numVisible < 1)
  {
    numVisible = 1;
  }

  // Set the width of each frame accordingly
  var slides = $('.slide');
  var html = "<label role=\"button\" id=\"btn-left\"  class=\"\" type=\"button\" onclick=\"toggleSlides(-1);\">&#9664;</label>\n";

  // Generate the carousel legend
  for(var i = 0; i < slides.length-numVisible-1; i++){
    html += "<label class=\"legend\">&#9679;</label>\n";
  }
  html += "<label role=\"button\" id=\"btn-right\" class=\"\" type=\"button\" onclick=\"toggleSlides(1);\">&#9654;</label>\n";
  insertHTML('carousel-legend', html);

  var legend = $('.legend');

  // initialze all slides
  for (var i = 0; i < slides.length; i++) 
  {
    switch(numVisible){
      case 1:
        slides[i].className = "slide dn center w-100 w-100-ns w-50-m pa2";
        break;
      case 2:
        slides[i].className = "slide dn fl w-100 w-50-ns w-50-m pa2";
        break;
      case 3:
        slides[i].className = "slide dn fl w-100 w-third-ns w-50-m pa2";
        break;
      default:
        console.log("ERROR: init: numVisible must be 1, 2 or 3, it is: " + numVisible);
        break;
    }
  }

  // Initialize the visible slides
  for (var i = 0; i < numVisible; i++) 
  {
    switch(numVisible){
      case 1:
        slides[i].className = "slide dn active center dib w-100 w-100-ns w-50-m pa2";
        break;
      case 2:
        slides[i].className = "slide dn active fl dib w-100 w-50-ns w-50-m pa2";
        break;
      case 3:
        slides[i].className = "slide dn active fl dib w-100 w-third-ns w-50-m pa2";
        break;
      default:
        console.log("ERROR: init: numVisible must be 1, 2 or 3, it is: " + numVisible);
        break;
    }
  }

  // Set up the legend at the bottom
  numActive = 0;
  numPrevious = 0;
  legend[0].className = "legend o-20";

}
