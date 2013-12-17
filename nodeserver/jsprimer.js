function js_log(link)
{
    var iFrame = document.createElement("IFRAME");
    iFrame.setAttribute("src", "jsLog://" + link);
    document.body.appendChild(iFrame);
    iFrame.parentNode.removeChild(iFrame);
    iFrame = null;
}

function overlayImages()
{
    var images = document.getElementsByTagName('img');
    var numimages = images.length;
    js_log("Found " + numimages + " images on page");
    // Let's cap this for efficiency
    if (numimages > 30) numimages = 30;
    for (var i=0; i<numimages; i++){
        addOverlay(images[i]);
    }
    return "Javascript overlayImages complete!"
}

function addOnclick()
{
    var images = document.getElementsByTagName('img');
    var numimages = images.length;
    js_log("Found " + numimages + " images on page");
    for (var i=0; i<numimages; i++){
        images[i].onclick=handleOnclick;
    }
    return "Javascript addOnclick complete!"
}

function handleOnclick()
{
    js_log("Handle On Click");
}

function addOverlay(link) {
        
    var div = document.createElement('div');
    div.innerHTML = "<div  " +
      "style='position: absolute; " +
      "top: " + link.offsetTop + "px; " +
      "left: " + link.offsetLeft + "px; " +
      "width: " + link.clientWidth + "px; " +
      "height: " + link.clientHeight + "px; " +
      "z-index: 999999; pointer-events: none;" +
      "text-align: center; opacity:0.7;'>" +
      "<img style='display: inline; " +
      "width: 100%; height:100%'" +
      "src='http://localhost:3000/solstice-logo-color.png'/>" +
      "</div>";

    link.offsetParent.appendChild(div);
}

js_log("Top Stuffs JS Files Loaded into Webview");

