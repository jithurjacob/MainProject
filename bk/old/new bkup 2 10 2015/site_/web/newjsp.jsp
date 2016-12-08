<%-- 
    Document   : newjsp
    Created on : Nov 24, 2014, 10:54:00 AM
    Author     : Radhika
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="./scripts/jquery.js"></script>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%="hi radh"%>
        <br><br><br>
        <button type="button" class="example4demo" result="allow" onclick="CloseMySelf(this);">Login using Sequoro</button>

    </body>
    <script>

        function CloseMySelf(sender) {
           
            try {
                 window.opener.document.body.style.backgroundColor="grren";
                window.opener.HandlePopupResult(sender.getAttribute("result"));
               
            }
            catch (err) {
            }
            setConfirmUnload(false);
            window.close();
            return false;
        }

        // Prevent accidental navigation away
        $(':input').bind(
                'change', function () {
                    setConfirmUnload(true);
                });
        $('.noprompt-required').click(
                function () {
                    setConfirmUnload(false);
                });

        function setConfirmUnload(on)
        {
            window.onbeforeunload = on ? unloadMessage : null;
        }
        function unloadMessage()
        {
            return(
                    'If you navigate away from this page ' +
                    'you will not be logged in to this page.');

        }

        window.onerror = UnspecifiedErrorHandler;
        function UnspecifiedErrorHandler()
        {
            return true;
        }


        setConfirmUnload(true);
    </script>
</html>
