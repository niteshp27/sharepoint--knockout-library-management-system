$(document).ready(function () {
            !function ($) {
                $(function () {

				   
				    if($('#startdt1')) $('#startdt1').datepicker({format: 'dd-mm-yyyy'});
				    if($('#startdt2')) $('#startdt2').datepicker({format: 'dd-mm-yyyy'});
				    if($('#enddt1')) $('#enddt1').datepicker({format: 'dd-mm-yyyy'});
				    if($('#enddt2')) $('#enddt2').datepicker({format: 'dd-mm-yyyy'});

					//animating menus on hover
					$('.nav>li>a').hover(function(){
						$(this).animate({'margin-left':'+=5'},300);
					},
					function(){
						$(this).animate({'margin-left':'-=5'},300);
					});


				});

            }(window.jQuery)

        });

