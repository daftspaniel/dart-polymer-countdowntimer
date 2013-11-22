library DaftHtmlUtil;

/***
 * Oddball collection of handy HTML functions.
 */

/**
 * Utility functions for hiding/showing elements. Anthropomorphised!
 */
hideMe(var element){
  element.style.visibility = "hidden";
}
showMe(var element){
  element.style.visibility = "visible";
}

youCanSeeMe(var element){
  return element.style.visibility == "visible";
}

/**
 * Convert CSS px measures.
 */
int intFromPx(var element) => int.parse(element.style.top.replaceFirst("px", ""));

String pxFromInt(int i ) => i.toString() + "px";

/**
 * Utility function to track assignment of members to fields.
 */
fromId(var Parent, String ID)
{
  var hel = Parent.shadowRoot.querySelector(ID);
  if (hel==null)
  {
    print('DANGER - did not find $ID in the HTML!');
  }

  return hel;
}
