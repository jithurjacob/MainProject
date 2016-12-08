   
    
  <footer id="contact"> <!-- footer begings -->

    <div class="container">
      <div class="row">
          <div class="top">
        <div class="top-line"></div>
      <a class="back-to-top"><i class="fa fa-angle-up"></i></a>    
    </div>
        <div class="col-md-12 text-center">
          <h2 class="section-title">contact us</h2>         
        </div>
      </div>
      <div class="row spacer40"></div>    
      <div class="row">
          <form role="form" name="ajax-form" id="ajax-form" action="php/mail-it.php" method="post" class="form-main">
          <div class="col-xs-12">
            
            <div class="row">            
              <div class="form-group col-xs-6">
                <label for="name2">name</label>
                <input class="form-control" id="name2" name="name" onblur="if(this.value == '') this.value='Name'" onfocus="if(this.value == 'Name') this.value=''" type="text" value="Name">
                <div class="error" id="err-name">Please enter name</div>
              </div>
              <div class="form-group col-xs-6">
                <label for="email2">email</label>
                <input  class="form-control" id="email2" name="email"  type="text"  onfocus="if(this.value == 'E-mail') this.value='';" onblur="if(this.value == '') this.value='E-mail';" value="E-mail">
                <div class="error" id="err-emailvld">E-mail is not a valid format</div> 
              </div>
            </div>
            
            <div class="row">            
              <div class="form-group col-xs-12">
                <label for="message2">message</label>
                <textarea  class="form-control" id="message2" name="message" onblur="if(this.value == '') this.value='Message'" onfocus="if(this.value == 'Message') this.value=''">Message</textarea>
                <div class="error" id="err-message">Please enter message</div>

              </div>
            </div> 
            <div class="row spacer30"></div>
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
                <p class="text-center">We will get back to you soon.</p>
              </div>
            </div>
            <div class="row spacer10"></div>
            <div class="row">            
              <div class="col-xs-12 text-center">
            <div id="ajaxsuccess">E-mail was successfully sent.</div>
            <div class="error" id="err-form">There was a problem validating the form please check!</div>
            <div class="error" id="err-timedout">The connection to the server timed out!</div>
            <div class="error" id="err-state"></div>
              
                <button type="submit" class="btn btn-default" id="send">Submit</button>
              </div>
            </div>
          </div>  
          </form>       
      </div>      
    </div>
    <div class="top">
        <div class="top-line"></div>
      <a class="back-to-top"><i class="fa fa-angle-up"></i></a>    
    </div>      
    <div class="container">    
      <div class="row">
        <div class="col-xs-12 col-sm-4 col-md-4">
          <h4>KEEP IN TOUCH</h4>
          <div class="footer-socials">
              <a href="#"><i class="fa fa-facebook"></i></a>
              <a href="#"><i class="fa fa-google-plus"></i></a>
              <a href="#"><i class="fa fa-twitter"></i></a>
              <a href="#"><i class="fa fa-pinterest"></i></a>
            </div>
        </div>
        
      
        
        <div class="col-xs-12 col-sm-4 col-md-4">
          <h4>ADDRESS</h4>
          <p>CS-8<br>
          College of Engineering,Poonjar</p>
          <p>+1 123-587-8421<br>
          <a href="#">www.sequoro.com</a><br>
          info@sequoro.com</p>
        </div>
        <div class="col-xs-12 col-sm-4 col-md-4">
          <h4>SUPPORT</h4>
          <p>You need support? Visit our support forum and open tickets for you questions.</p>
          <p><button type="button" class="btn btn-primary">forum</button></p>
        </div>        
      </div>
    </div>
    <div class="spacer100"></div>
  </footer> <!-- Footer ends -->
      
        
        
        
        
        
        
<!--        starting js tags-->
  <script src="js/jquery.js"></script>  
  <script src="js/bootstrap.min.js"></script>   
  <script src="js/jquery.scrollTo.js"></script>
  <script src="js/jquery.nav.js"></script>   
  <script src="js/jquery.easing.js"></script>    
  <script src="js/jquery.flexslider-min.js"></script>
  <script src="js/jquery.isotope.min.js"></script>   
  <script src="js/jquery.fitvids.js"></script>
  <script src="js/jquery.appear.js"></script>  
  <script src="js/retina.js"></script>
  <script src="js/respond.min.js"></script>  
  <script src="js/jquery.parallax-1.1.3.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/jquery.sticky.js"></script>
  <script src="js/jquery.countTo.js"></script>
  <script src="js/jquery.mb.YTPlayer.js"></script>
  <script src="js/jquery.superslides.js"></script>
  <script src="js/functions.js"></script>
  <script src="layerslider/js/greensock.js"></script>
  <script src="layerslider/js/layerslider.transitions.js"></script>
  <script src="layerslider/js/layerslider.kreaturamedia.jquery.js"></script>  