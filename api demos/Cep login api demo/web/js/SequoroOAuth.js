window.addEventListener("message", function(e) {alert(e.data);
    // If we get a message from the child, and the message is asking for
    // us to send the info...
    //if (e.origin === "http://url.of.child.window" && e.data === "send-info") {
        // ...send it
       // e.source.postMessage("info", JSON.stringify({/*...data goes here...*/}));
    //}
    var result=e.data;
         if (result == "invalid") {
        alert("Invalid request refresh the login page....");
      window.location.reload(true);
          //    window.location=location.href+"?attempt="+$.now();
    }else {
        result=JSON.parse(result);
        if(result.status=="ok"){
            window.location="<%=sequoroOAuth.getRedirectUrl()%>?provider=sequoro&requestcode="+result.requestcode;
        }else{
            alert("Invalid Login attempt");
        }
    }
}, false);
function HandlePopupResult(result) {
alert(result);
    alert("result of popup is: " + result);
    if (result == "invalid") {
        alert("Invalid request refresh the login page....");
      window.location.reload(true);
          //    window.location=location.href+"?attempt="+$.now();
    }else {
        result=JSON.parse(result);
        if(result.status=="ok"){
            window.location="<%=sequoroOAuth.getRedirectUrl()%>?provider=sequoro&requestcode="+result.requestcode;
        }else{
            alert("Invalid Login attempt");
        }
    }
}

function sequoro() {

    var a = $('#sequoro_btn').popupWindow({
        windowURL: '<%=sequoroOAuth.getRequestUrl()%>',
        windowName: 'swip',
        centerScreen: 1,
        scrollbars: 1


    });
  console.log(a);
}