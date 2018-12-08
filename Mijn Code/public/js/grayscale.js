(function($) {
  "use strict";
  $('a.js-scroll-trigger[href*="#"]:not([href="#"])').click(function() {
    if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      if (target.length) {
        $('html, body').animate({
          scrollTop: (target.offset().top - 70)
        }, 1000, "easeInOutExpo");
        return false;
      }
    }
  });

  $('.js-scroll-trigger').click(function() {
    $('.navbar-collapse').collapse('hide');
  });

  //Activar scrollspy 
  $('body').scrollspy({
    target: '#mainNav',
    offset: 100
  });

  //Navbar
  var navbarCollapse = function() {
    if ($("#mainNav").offset().top > 100) {
      $("#mainNav").addClass("navbar-shrink");
    } else {
      $("#mainNav").removeClass("navbar-shrink");
    }
  };
  
  navbarCollapse();
  $(window).scroll(navbarCollapse);

})(jQuery);

//////////////////////////////////////////
$("#btn-login").click(function(){
    $.ajax({
        url:"/login",
        data:"usuario="+$("#login-usuario").val()+"&contrasena="+$("#login-contrasena").val(),
        method:"POST",
        dataType:"json",
        success:function(respuesta){
            if (respuesta.estatus == 0)
                //alert("Credenciales correctas");    
                window.location.href ="Home.html";
            else
                alert("Credenciales incorrectas");
            console.log(respuesta);
        }
    });
});



