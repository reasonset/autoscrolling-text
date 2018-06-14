var scrollMode = false
var scrollRepeat = 50
const scrollSizeDefault = 1
var scrollSize = scrollSizeDefault

var scrolling = function() {
  scrollBy(0,scrollSize)
  if (scrollMode)
    setTimeout(scrolling, scrollRepeat)
}

document.addEventListener('keydown', (event) => {
  const keyName = event.key
  
  //alert(event.code)
  
  if (event.code == "Space") {
    scrollMode = !scrollMode
    if (scrollMode)
      scrolling()
      
    event.preventDefault()
  }
  
  if (event.code == "ArrowUp") {
    if (scrollRepeat >= 10) {
      scrollRepeat = scrollRepeat - 5
    }
    else if (scrollRepeat == 1) {
        scrollSize = scrollSize + 1
    }
    else if (scrollRepeat > 1) {
        scrollRepeat = scrollRepeat - 1
    }
      
    event.preventDefault()
  }
  
  if (event.code == "ArrowDown") {
      if (scrollSize > scrollSizeDefault) {
          scrollSize = scrollSize - 1
      }
      else if (scrollRepeat < 5) {
          scrollRepeat = scrollRepeat + 1
      }
      else {
          scrollRepeat = scrollRepeat + 5
      }
    
    event.preventDefault()
  }
}, false);

document.addEventListener('contextmenu', (event) => {
 scrollMode = !scrollMode
 if (scrollMode)
   scrolling()
   event.preventDefault()
}, false);
