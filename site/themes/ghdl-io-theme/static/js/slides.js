numVisible=2;
numActive=undefined;
numPrevious=undefined;
numDir=1;
function toggleSlides(d) {
  console.log('Toggle');

  var slides = $('.slide');
  var lastSlide = slides.length - 1;
  var legend = $('.legend');

  if ( numActive === undefined ) {
    for (var i = 0; i < 3; i++) {
      slides[i].className = "slide active fl dib w-100 w-third-ns w-50-m pa2";
    }
    numActive = 0;
  } else {
    if ( d === 'interval' ) { d = numDir } else { clearInterval(refreshIntervalId); }
    var skip = false;
    if (( d === -1 ) && (numActive === 0)) { numDir = 1; skip=true; }
    if (( d === 1 ) && (numActive === (lastSlide-numVisible))) { numDir = -1; skip=true; }
    if (skip === true) { numPrevious = numActive; return; }
    numActive += d;
    var show = numActive+2;
    var hide = numActive-1;
    if (numPrevious > numActive) {
      hide = numActive+3;
      show = numActive;
    }
    slides[hide].className = "slide dn fl w-100 w-third-ns w-50-m pa2";
    slides[show].className = "slide active fl w-100 w-third-ns w-50-m pa2";
    legend[numPrevious].className = "legend o-100";
  }
  legend[numActive].className = "legend o-20";

  // Alternatively, use switchClass from jQueryUI?
  document.getElementById('btn-left').className = ( numActive === 0 ) ? "not-active o-20" : "o-100";
  document.getElementById('btn-right').className = ( numActive === (lastSlide-numVisible) ) ? "not-active o-20" : "o-100";
  numPrevious = numActive;
}
toggleSlides('interval');
var refreshIntervalId =setInterval(function(){ toggleSlides('interval'); }, 2250);
