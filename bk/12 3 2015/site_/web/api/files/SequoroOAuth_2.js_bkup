
function HandlePopupResult(result) {

   // alert("result of popup is: " + result);
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

}