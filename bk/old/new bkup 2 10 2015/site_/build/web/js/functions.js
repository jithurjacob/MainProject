
// If JavaScript is enabled remove 'no-js' class and give 'js' class
jQuery('html').removeClass('no-js').addClass('js');

// Add .osx class to html if on Os/x
if (navigator.appVersion.indexOf("Mac") !== -1) {
	jQuery('html').addClass('osx');
}

// When DOM is fully loaded
jQuery(document).ready(function($) {
  "use strict";

$(window).load(function() {
    
     $("#help_link").click(function(){alert(0);
      window.location=("./help.jsp");
  // window.open("./login_page.jsp");
});
     $("#statistics_link").click(function(){
      window.location=("./statistics.jsp");
  // window.open("./login_page.jsp");
});
     $("#changepwd_link").click(function(){
      window.location=("./changepwd.jsp");
  // window.open("./login_page.jsp");
});
     $("#dash_link").click(function(){
      window.location=("./dashboard.jsp");
  // window.open("./login_page.jsp");
});
     $("#securitylevel_link").click(function(){
      window.location=("./login_page.jsp");
  // window.open("./login_page.jsp");
});
  $("#login_link").click(function(){
      window.location=("./login_page.jsp");
  // window.open("./login_page.jsp");
});
$("#logout_link").click(function(){
      window.location=("./logout.jsp");
  // window.open("./login_page.jsp");
});
  $("#register_link").click(function(){
      window.location=("./users_pages/register_page.jsp");
  // window.open("./register_page.jsp");
});
  $("#services_link").click(function(){
       window.location=("./index.jsp#services");
//   window.open("./index.jsp#services");
});
 $("#demo_link").click(function(){
      window.location=("./index.jsp#demo");
//   window.open("./index.jsp#demo");
});
 $("#about_link").click(function(){
      window.location=("./index.jsp#about");
//   window.open("./index.jsp#about");
});
 $("#team_link").click(function(){
     window.location=("./index.jsp#team");
//   window.open("./index.jsp#team");
});
 $("#job_link").click(function(){
      window.location=("./index.jsp#job");
//   window.open("./index.jsp#job");
});
 $("#services_link").click(function(){
      window.location=("./index.jsp#services");
//   window.open("./index.jsp#services");
});
 $("#home_link").click(function(){
      window.location=("./index.jsp#home");
  // window.open("./index.jsp#home");
});
 $("#contact_link").click(function(){
     window.location=("./index.jsp#contact");
//   window.open("./index.jsp#contact");
});
$("#contact_link").click(function(){
     window.location=("./index.jsp#contact");
//   window.open("./index.jsp#contact");
});

});
  

// youtube video player
$(window).load(function() {
  $(".player").mb_YTPlayer();
 
});

// Fitvids 
$(window).load(function() {
  $("section").fitVids();
});  


// superslides for fullwidth video
  $('#slides').superslides();
	
     

// External links   
	$(window).load(function() {
			$('a[rel=external]').attr('target','_blank');	
	});

// Tooltips		
    $('body').tooltip({
        delay: { show: 300, hide: 0 },
        selector: '[data-toggle=tooltip]:not([disabled])'
    });
    



 
   //Images portfolio

  // magnific popoup 
  $('.popup-link').magnificPopup({
  		type: 'image'
  	});
    
    

   // magnific popoup for video 
   $('.popup-youtube, .popup-vimeo').magnificPopup({
		disableOn: 700,
		type: 'iframe',
		mainClass: 'mfp-fade',
		removalDelay: 160,
		preloader: false,

		fixedContentPos: false
	});
  
  // portfolio
 
  $('.ajax-popup-link').magnificPopup({
      type: 'ajax'
});
  

// image gallery
  
 $('.gallery').each(function() { // the containers for all your galleries
    $(this).magnificPopup({
        delegate: 'a', // the selector for gallery item
        type: 'image',
        gallery: {
          enabled:true
        }
    });
}); 

  
 // scroll body to 0px on click
    $(function() {
		$('.back-to-top').bind('click', function(event) {
			$('html, body').stop().animate({
				scrollTop: 0
			}, 1200, 'easeInOutExpo');
			event.preventDefault();
		});
	});
  	
$(function() {
		$('.down').bind('click', function(event) {
			var $tag = $(this);
			var navbar = $('.navbar').outerHeight();
			$('html, body').stop().animate({
				scrollTop : $($tag.attr('href')).offset().top - navbar + "px"
			}, 1200, 'easeInOutExpo');

			event.preventDefault();
		});
	});


// sticky for navbar
$('.navbar').sticky({topSpacing:0});

 

// One page navigation 

$('.navbar').onePageNav({
   currentClass: 'active',
	 changeHash: false,
	 scrollSpeed: 750,
	 scrollOffset: 100,
	 scrollThreshold: 0.1,
	 filter: ':not(.ext)',
	 easing: 'swing',
});



//	 Select navigation for small screens 


	$("<option />", {
	   "selected": "selected",
	   "value"   : "",
	   "text"    : "Navigation"
	}).appendTo(".select-menu");


	$(".nav a").each(function() {
	 var select = $(this);
	 $("<option />", {
	     "value"   : select.attr("href"),
	     "text"    : select.attr("title")
	 }).appendTo(".select-menu");
	});


  $(".select-menu").change(function() {        
    $('html, body').animate({
      scrollTop: $($(this).find("option:selected").val()).offset().top -60 }, 750);
  });







// detect mobile devices

   var detectmob = false;	
   if(navigator.userAgent.match(/Android/i)
    || navigator.userAgent.match(/webOS/i)
    || navigator.userAgent.match(/iPhone/i)
    || navigator.userAgent.match(/iPad/i)
    || navigator.userAgent.match(/iPod/i)
    || navigator.userAgent.match(/BlackBerry/i)
    || navigator.userAgent.match(/Windows Phone/i)) {							
      detectmob = true;
	}
  

  if (detectmob === false) {
      $('*[data-ani]').addClass('animated');
  }
  
 $('.animated').appear(function() {
  $(this).each(function(){ 
    $(this).css('visibility','visible');
    $(this).addClass($(this).data('type'));
  });
},{accY: -100});



$('.skill-shortcode').appear(function() {
  $('.progress').each(function(){ 
    $('.progress-bar').css('width',  function(){ return ($(this).attr('data-percentage')+'%')});
  });
},{accY: -100}); 




// Parallax   
	if (detectmob === true) {
    $( '.parallax' ).each(function(){
				$(this).addClass('parallax-mobile');
		});
  }
  else {
  
  	//.parallax(xPosition, speedFactor, outerHeight) options:
	//xPosition - Horizontal position of the element
	//inertia - speed to move relative to vertical scroll. Example: 0.1 is one tenth the speed of scrolling, 2 is twice the speed of scrolling
	//outerHeight (true/false) - Whether or not jQuery should use it's outerHeight option to determine when a section is in the viewport
      $( '#parallax-home' ).parallax("100%", 0.5,true);
      $( '#parallax-one' ).parallax("100%", 0.5,true);
      $( '#parallax-two' ).parallax("100%", 2,false); // Add more
      $( '#parallax-three' ).parallax("100%", 0.5,true); // Add more
      $( '#parallax-four' ).parallax("100%", 0.5,false); // Add more
      $( '#parallax-five' ).parallax("100%", 0.5,false); // Add more
    }


// animated counter 

$('.timer').countTo();

$('.counter-item').appear(function() {
    $('.timer').countTo();
},{accY: -100}); 

   
 

   
// 	Portfolio - isotope		
  
  (function() {
   
    $(window).load(function(){
    	// container
    	var $container = $('#portfolio-items');
    	function filter_projects(tag)
    	{
    	  // filter projects
    	  $container.isotope({ filter: tag });
    	  // clear active class
    	  $('li.act').removeClass('act');
    	  // add active class to filter selector
    	  $('#portfolio-filter').find("[data-filter='" + tag + "']").parent().addClass('act');
    	}
    	if ($container.length) {
    		// conver data-tags to classes
    		$('.project').each(function(){
    			var $this = $(this);
    			var tags = $this.data('tags');
    			if (tags) {
    				var classes = tags.split(',');
    				for (var i = classes.length - 1; i >= 0; i--) {
    					$this.addClass(classes[i]);
    				};
    			}
    		})
    		// initialize isotope
    		$container.isotope({
    		  // options...
    		  itemSelector : '.project',
    		  layoutMode   : 'fitRows'
    		});
    		// filter items
    		$('#portfolio-filter li a').click(function(){
    			var selector = $(this).attr('data-filter');
    			filter_projects(selector);
    			return false;
    		});
    		// filter tags if location.has is available. e.g. http://example.com/work.html#design will filter projects within this category
    		if (window.location.hash!='')
    		{
    			filter_projects( '.' + window.location.hash.replace('#','') );
    		}
    	}
    })

	})();




// FlexSlider  
   
  $(window).load(function() {
 
  
 // home page slider for parallax
  $('.main-slider').flexslider({
    animation: "slide",
    slideshow: true,
    useCSS : false,
    prevText: "",
    nextText: "",    
    animationLoop: true 	
  });
  
 // for fullscreen video 
  $('.main-slider-video').flexslider({
    animation: "slide",
    slideshow: true,
    useCSS : false,
    prevText: "",
    nextText: "",    
    animationLoop: true 	
  });  



 // projects slider
  $('.projects-slider').flexslider({
    animation: "slide",
    slideshow: false,
    useCSS : false,
    prevText: "",
    nextText: "",    
    animationLoop: true 	
  });   


  //testimonal slider
  $('.testimonal-slider').flexslider({
    animation: "slide",
    slideshow: false,
    useCSS : false,
    prevText: "",
    nextText: "",    
    animationLoop: true 	
  }); 
  
  //laptop slider
  $('.laptop-slider').flexslider({
    animation: "slide",
    slideshow: false,
    useCSS : false,
    prevText: "",
    nextText: "",    
    animationLoop: true 	
  }); 
  //laptop slider
  $('.phone_-slider').flexslider({
    animation: "slide",
    slideshow: false,
    useCSS : false,
    prevText: "",
    nextText: "",    
    animationLoop: true 	
  });


  //thumbanil slider
  $('.thumbnail-slider').flexslider({
    animation: "slide",
    slideshow: false,
    controlNav: "thumbnails"
  });
     
   
 });
 

    // LayerSlider 
    $('#layerslider').layerSlider({
            pauseOnHover: false,
            firstLayer: 1,
            skin: 'v5',
            skinsPath: 'layerslider/skins/'

    });


// Contact Form 		
	$('#send').click(function(){ // when the button is clicked the code executes
		$('.error').fadeOut('slow'); // reset the error messages (hides them)

		var error = false; // we will set this true if the form isn't valid

		var name = $('input#name2').val(); // get the value of the input field
		if(name == "" || name == " " || name == "Name") {
    $('#err-name').show(500);
    $('#err-name').delay(4000);
    $('#err-name').animate({
      height: 'toggle'  
    }, 500, function() {
      // Animation complete.
    }); 
      error = true; // change the error state to true
		}

		var email_compare = /^([a-z0-9_.-]+)@([da-z.-]+).([a-z.]{2,6})$/; // Syntax to compare against input
		var email = $('input#email2').val().toLowerCase(); // get the value of the input field
		if (email == "" || email == " " || email == "E-mail") { // check if the field is empty
			$('#err-email').fadeIn('slow'); // error - empty
			error = true;
		}else if (!email_compare.test(email)) { // if it's not empty check the format against our email_compare variable

    $('#err-emailvld').show(500);
    $('#err-emailvld').delay(4000);
    $('#err-emailvld').animate({
      height: 'toggle'  
    }, 500, function() {
      // Animation complete.
    });         
			error = true;
		}
    
		var message = $('textarea#message2').val(); // get the value of the input field
		if(message == "" || message == " " || message == "Message") {

      
    $('#err-message').show(500);
    $('#err-message').delay(4000);
    $('#err-message').animate({
      height: 'toggle'  
    }, 500, function() {
      // Animation complete.
    });            
			error = true; // change the error state to true
		} 

		if(error == true) {

    $('#err-form').show(500);
    $('#err-form').delay(4000);
    $('#err-form').animate({
      height: 'toggle'  
    }, 500, function() {
      // Animation complete.
    });         
			return false;
		}

		var data_string = $('#ajax-form').serialize(); // Collect data from form
		//alert(data_string);

		$.ajax({
			type: "POST",
			url: $('#ajax-form').attr('action'),
			data: data_string,
			timeout: 6000,
			error: function(request,error) {
				if (error == "timeout") {
					$('#err-timedout').slideDown('slow');
				}
				else {
					$('#err-state').slideDown('slow');
					$("#err-state").html('An error occurred: ' + error + '');
				}
			},
			success: function() {

        
    $('#ajaxsuccess').show(500);
    $('#ajaxsuccess').delay(4000);
    $('#ajaxsuccess').animate({
      height: 'toggle'  
    }, 500, function() {
    });           

        $("#name").val('');
        $("#email").val('');
        $("#message").val('');
			}
		});

		return false; // stops user browser being directed to the php file
	}); // end click function
     





});

