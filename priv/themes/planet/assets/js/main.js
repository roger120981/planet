(function($) {
"use strict";

/*------------------------------------------------------------------
[Table of contents]

1. mega navigation menu init
2. back to top
3. twitter api init
4. map popups
5. single banner slider
6. single banner slider version 2
7. single banner slider version 3
8. single banner slider version 4
9. single banner slider version 5
10. single banner slider version 6
11. xs tab slider
12. xs tab slider 6 col
13. xs deal of the day
14. xs product slider 1
15. xs product slider 2
16. xs product slider 3
17. deal of the day
18. product slider 4
19. product slider 5
20. product slider 6
21. product slider 7
22. organic product slider 8
23. organic product slider 9
24. organic product slider 10
25. product slider 11
26. product slider 12
27. product slider 13
28. seven column slider
29. produt block slider
30. xs progress
31. input number increase
32. echo init
33. pulse effect
34. countdown timer
35 .ajax chimp init
36. xs popover
37. number percentage
38. number counter up
39. social tigger add class
40. sync product preview slider
41. sync banner nav slider
42. insta feed
43. jquery slider range
44. contact form init
45. Minicart dropdown remove close on body click
46. Search form open by click
47. Side Offset cart menu open
48. Recent view slider
49. vertical menu dropdown tigger on click overlay active init
50. promo popup open when window is load
51. video popup init
52. Post gallery slider
53. XpeedStudio Maps


-------------------------------------------------------------------*/

// my oel function
$.fn.myOwl = function(options) {

	var settings = $.extend({
		items: 1,
		dots: false,
		loop: true,
		mouseDrag: true,
		touchDrag: true,
		nav: false,
		autoplay: true,
		navText: ['',''],
		margin: 0,
		stagePadding: 0,
		autoplayTimeout: 5000,
		autoplayHoverPause: true,
		animateOut: 'fadeOut',
		animateIn: 'fadeIn',
		navRewind:false,
		responsive: {}
	}, options);

    return this.owlCarousel( {
		items: settings.items,
		loop: settings.loop,
		mouseDrag: settings.mouseDrag,
		touchDrag: settings.touchDrag,
		nav: settings.nav,
		navText: settings.navText,
		dots: settings.dots,
		margin: settings.margin,
		stagePadding: settings.stagePadding,
		autoplay: settings.autoplay,
		autoplayTimeout: settings.autoplayTimeout,
		autoplayHoverPause: settings.autoplayHoverPause,
		animateOut: settings.animateOut,
		animateIn: settings.animateIn,
		responsive: settings.responsive,
		navRewind: settings.navRewind,
		onTranslate : function(){
			echo.render();
		}
	});
};

// function get height
let getHeight = () => {
	let themeThumb = $('.xs-single-team .team-thumb'),
		thumbH = themeThumb.outerHeight(),
		hiringInfo = $('.xs-single-team.team-hiring-info');
	
	hiringInfo.css('min-height', thumbH);
}

//  email patern 
function email_pattern(email) {
	var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	return regex.test(email);
}

// menu vertical open and close when cross break point 
function menuVertical() {
	var window_width = $(window).width(),
		breakPoint = 991,
		dropDonw_tigger = $('.v-menu-is-active .cd-dropdown-trigger'),
		dropdown = $('.v-menu-is-active .cd-dropdown'),
		activeClass = 'dropdown-is-active';

	if (window_width <= breakPoint) {
		if (dropDonw_tigger.hasClass(activeClass)) {
			dropDonw_tigger.removeClass(activeClass);
		}
		if (dropdown.hasClass(activeClass)) {
			dropdown.removeClass(activeClass);
		}
	} else {
		dropDonw_tigger.addClass(activeClass);
		dropdown.addClass(activeClass);
	}
}

// nav cover add remoe
let navCover = () => {
	$(window).width() <= 1023 ? $('.nav-cover').remove() : $('.xs-header').append('<div class="nav-cover"></div>');
};


$(window).on('load', function() {
	// menu vertical open and close when cross break point 
	menuVertical();

	// nav cover init
	navCover();

	// theme thumb equal height
	getHeight();

	/* banner slider verison 5 push bootstrap markup */ 
	$('.xs-banner-slider-5 .owl-dots').wrap('<div class="container container-fullwidth"><div class="row"><div class="col-lg-9 offset-lg-3"></div></div></div>');

}); // END load Function 

$(document).ready(function() {

	// menu vertical open and close when cross break point 
	menuVertical();

	// theme thumb equal height
	getHeight();

	/*==========================================================
			1. mega navigation menu init
	======================================================================*/
	if ($('.xs-menus').length > 0) {
		$('.xs-menus').xs_nav({
			mobileBreakpoint: 992,
		});
	}

	/*==========================================================
			2. back to top
	======================================================================*/ 
	$(document).on('click', '.xs-back-to-top', function(event) {
		event.preventDefault();
		/* Act on the event */

		$('html, body').animate({
			scrollTop: 0,
		}, 1000);
	});

	/*==========================================================
			3. twitter api init
	======================================================================*/
	if ($('.xs-tweet').length > 0) {
		$('.xs-tweet').twittie({
			dateFormat: '%b. %d, %Y',
			template: '{{tweet}} <div class="date">{{date}}</div> <a href="{{url}}" target="_blank">Details</a>',
			count: 2,
			username: 'xpeedstudio',
			loadingText: 'Loading!',
		});
	}

	/*==========================================================
			4. map popups
	======================================================================*/
	if ($('.xs-map-popup').length > 0) {
		$('.xs-map-popup').magnificPopup({
			disableOn: 700,
			type: 'iframe',
			mainClass: 'mfp-fade',
			removalDelay: 160,
			preloader: false,
			fixedContentPos: false
		});
	}

	/*==========================================================
				5. single banner slider
	======================================================================*/
	if ( $( '.xs-banner-slider' ).length > 0 ) {
		$( ".xs-banner-slider" ).myOwl({
			items: 1,
			loop: false,
			navText: ['<i class="icon icon-arrow-left xs-simple-arrow"></i>','<i class="icon icon-arrow-right xs-simple-arrow"></i>'],
			dots: true,
			nav: true,
			autoplay: false,
			responsive: {
				// breakpoint from 0 up
				0 : {
					dots: false,
					nav: false,
				},
				// breakpoint from 768 up
				768 : {
					dots: true,
					nav: true,
				}
			},
			afterAction: function(){
				if ( this.itemsAmount > this.visibleItems.length ) {
				  $('.owl-next').removeClass('disabled');
				  $('.owl-prev').removeClass('disabled');
				  if ( this.currentItem == 0 ) {
					$('.owl-prev').addClass('disabled');
				  }
				  if ( this.currentItem == this.maximumItem ) {
					$('.owl-next').addClass('disabled');
				  }
				}
			  }
		})
	}

	/*==========================================================
				6. single banner slider version 2
	======================================================================*/
	if ( $( '.xs-banner-slider-2' ).length > 0 ) {
		$( ".xs-banner-slider-2" ).myOwl({
			dots: true
		})
	}

	/*==========================================================
				7. single banner slider version 3
	======================================================================*/
	if ( $( '.xs-banner-slider-3' ).length > 0 ) {
		$( ".xs-banner-slider-3" ).myOwl({
			dots: true,
			responsive : {
				// breakpoint from 0 up
				0 : {
					dots: false,
				},
				// breakpoint from 768 up
				768 : {
					dots: true,
				}
			}
		})
	}

	

	/*==========================================================
				8. single banner slider version 4
	======================================================================*/
	if ( $( '.xs-banner-slider-4' ).length > 0 ) {
		$( ".xs-banner-slider-4" ).myOwl({
			dots: true,
			autoplay: false,
			responsive : {
				// breakpoint from 0 up
				0 : {
					dots: false,
				},
				// breakpoint from 768 up
				768 : {
					dots: true,
				}
			}
		})
	}

	
	/*==========================================================
				9. single banner slider version 5
	======================================================================*/
	if ( $( '.xs-banner-slider-5' ).length > 0 ) {
		$( ".xs-banner-slider-5" ).myOwl({
			dots: true,
			responsive: {
				0: {
					dots: false
				},
				768: {
					dots: true,
				}
			}
		})
	}

	/*==========================================================
				10. single banner slider version 6
	======================================================================*/
	if ( $( '.xs-banner-slider-6' ).length > 0 ) {
		$( ".xs-banner-slider-6" ).myOwl({
			dots: true
		})
	}


	/*==========================================================
				11. xs tab slider
	======================================================================*/
	var tabSlider = $( ".xs-tab-slider" );
	tabSlider.on( 'initialized.owl.carousel translated.owl.carousel', function() {
		var $this = $(this);
		$this.find( '.owl-item.last-child' ).each( function() {
			$(this).removeClass( 'last-child' );
		});
		$(this).find( '.owl-item.active' ).last().addClass( 'last-child' );
	});
	if ( $( '.xs-tab-slider' ).length > 0 ) {
		$( ".xs-tab-slider" ).myOwl({
			items: 3,
			margin: 30,
			stagePadding: 10,
			dots: true,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 3,
				}
			}
		})
	}

	/*==========================================================
				12. xs tab slider 6 col
	======================================================================*/
	var tabSixColSlider = $( ".xs-tab-slider-6-col" );
	tabSixColSlider.on( 'initialized.owl.carousel translated.owl.carousel', function() {
		var $this = $(this);
		$this.find( '.owl-item.last-child' ).each( function() {
			$(this).removeClass( 'last-child' );
		});
		$(this).find( '.owl-item.active' ).last().addClass( 'last-child' );
	});
	if ( $( '.xs-tab-slider-6-col' ).length > 0 ) {
		$( ".xs-tab-slider-6-col" ).myOwl({
			items: 6,
			dots: true,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 480 up
				480 : {
					items: 2,
				},
				// breakpoint from 768 up
				768 : {
					items: 4,
				},
				1024: {
					items: 6,
				}
			}
		});
	}

	/*==========================================================
				13. xs deal of the day
	======================================================================*/
	if ( $( '.xs-slider-highlight' ).length > 0 ) {
		$( ".xs-slider-highlight" ).myOwl({
			navText: ['<i class="icon icon-arrow-left xs-simple-arrow"></i>','<i class="icon icon-arrow-right xs-simple-arrow"></i>'],
			nav: true,
		});
	}

	/*==========================================================
			14. xs product slider 1
	======================================================================*/
	if ( $( '.xs-product-slider-1' ).length > 0 ) {
		var xsProuctSliderOne = $( ".xs-product-slider-1" );
		xsProuctSliderOne.myOwl({
			responsive : {
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 1,
				}
			}
		});
		$("#prev-1").on('click',function () {
			xsProuctSliderOne.trigger('prev.owl.carousel');
		});

		$("#next-1").on('click',function () {
			xsProuctSliderOne.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				15. xs product slider 2
	======================================================================*/
	if ( $( '.xs-product-slider-2' ).length > 0 ) {
		var xsProuctSliderTwo = $( ".xs-product-slider-2" );
		xsProuctSliderTwo.myOwl({
			responsive : {
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 1,
				}
			}
		});
		$("#prev-2").on('click',function () {
			xsProuctSliderTwo.trigger('prev.owl.carousel');
		});

		$("#next-2").on('click',function () {
			xsProuctSliderTwo.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				16. xs product slider 3
	======================================================================*/
	if ( $( '.xs-product-slider-3' ).length > 0 ) {
		var xsProuctSliderThree = $( ".xs-product-slider-3" );
		xsProuctSliderThree.myOwl({
			responsive : {
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 1,
				}
			}
		});
		$("#prev-3").on('click',function () {
			xsProuctSliderThree.trigger('prev.owl.carousel');
		});

		$("#next-3").on('click',function () {
			xsProuctSliderThree.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				17. deal of the day
	======================================================================*/
	if($('.xs-deal-of-the-week').length > 0) {
		var dealOfTheWeek = $('.xs-deal-of-the-week');
		dealOfTheWeek.myOwl({
			responsive: {
				0: {
					items: 1
				},
				768: {
					items: 2,
				},
				1024: {
					items: 1
				}
			}
		});
		$("#prev-4").on('click',function () {
			dealOfTheWeek.trigger('prev.owl.carousel');
		});

		$("#next-4").on('click',function () {
			dealOfTheWeek.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				18. product slider 4
	======================================================================*/
	if($('.xs-product-slider-4').length > 0) {
		var productSliderFour = $('.xs-product-slider-4');
		productSliderFour.myOwl({
			items: 2,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 2,
				}
			}
		});
		$("#prev-5").on('click',function () {
			productSliderFour.trigger('prev.owl.carousel');
		});

		$("#next-5").on('click',function () {
			productSliderFour.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				19. product slider 5
	======================================================================*/
	if($('.xs-product-slider-5').length > 0) {
		var productSliderFive = $('.xs-product-slider-5');
		productSliderFive.myOwl({
			items: 2,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 1,
				},
				1024: {
					items: 2,
				}
			}
		});
		$("#prev-6").on('click',function () {
			productSliderFive.trigger('prev.owl.carousel');
		});

		$("#next-6").on('click',function () {
			productSliderFive.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				20. product slider 6
	======================================================================*/
	if($('.xs-product-slider-6').length > 0) {
		var productSliderSix = $('.xs-product-slider-6');
		productSliderSix.myOwl({
			items: 2,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 1,
				},
				1024: {
					items: 2,
				}
			}
		});
		$("#prev-7").on('click',function () {
			productSliderSix.trigger('prev.owl.carousel');
		});

		$("#next-7").on('click',function () {
			productSliderSix.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				21. product slider 7
	======================================================================*/
	if($('.xs-product-slider-7').length > 0) {
		var productSliderSeven = $('.xs-product-slider-7');
		productSliderSeven.myOwl({
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 1,
				}
			}
		});
		$("#prev-8").on('click',function () {
			productSliderSeven.trigger('prev.owl.carousel');
		});

		$("#next-8").on('click',function () {
			productSliderSeven.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				22. organic product slider 8
	======================================================================*/
	if($('.xs-product-slider-8').length > 0) {
		var productSliderEight = $('.xs-product-slider-8');
		productSliderEight.myOwl({
			responsive: {
				0: {
					items: 1
				},
				768: {
					items: 2,
					margin: 15
				},
				1024: {
					items: 1,
					margin: 0
				}
			}
		});
		$("#prev-9").on('click',function () {
			productSliderEight.trigger('prev.owl.carousel');
		});

		$("#next-9").on('click',function () {
			productSliderEight.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				23. organic product slider 9
	======================================================================*/
	if($('.xs-product-slider-9').length > 0) {
		var productSliderNine = $('.xs-product-slider-9');
		productSliderNine.myOwl({
			responsive: {
				0: {
					items: 1
				},
				768: {
					items: 2,
					margin: 15
				},
				1024: {
					items: 1,
					margin: 0
				}
			}
		});
		$("#prev-10").on('click',function () {
			productSliderNine.trigger('prev.owl.carousel');
		});

		$("#next-10").on('click',function () {
			productSliderNine.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				24. organic product slider 10
	======================================================================*/
	if($('.xs-product-slider-10').length > 0) {
		var productSliderTen = $('.xs-product-slider-10');
		productSliderTen.myOwl({
			responsive: {
				0: {
					items: 1
				},
				768: {
					items: 2,
					margin: 15
				},
				1024: {
					items: 1,
					margin: 0
				}
			}
		});
		$("#prev-11").on('click',function () {
			productSliderTen.trigger('prev.owl.carousel');
		});

		$("#next-11").on('click',function () {
			productSliderTen.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				25. product slider 11
	======================================================================*/
	if($('.xs-product-slider-11').length > 0) {
		var productSliderEleven = $('.xs-product-slider-11');
		productSliderEleven.myOwl({
			items: 3,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 3,
				}
			}
		});
		$("#prev-12").on('click',function () {
			productSliderEleven.trigger('prev.owl.carousel');
		});
		$("#next-12").on('click',function () {
			productSliderEleven.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
					26. product slider 12
	======================================================================*/
	if($('.xs-product-slider-12').length > 0) {
		var productSliderTwelve = $('.xs-product-slider-12');
		productSliderTwelve.myOwl({
			items: 3,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 3,
				}
			}
		});
		$("#prev-13").on('click',function () {
			productSliderTwelve.trigger('prev.owl.carousel');
		});
		$("#next-13").on('click',function () {
			productSliderTwelve.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				27. product slider 13
	======================================================================*/
	if($('.xs-product-slider-13').length > 0) {
		var productSliderThirteen = $('.xs-product-slider-13');
		productSliderThirteen.myOwl({
			items: 3,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 2,
				},
				1024: {
					items: 3,
				}
			}
		});
		$("#prev-14").on('click',function () {
			productSliderThirteen.trigger('prev.owl.carousel');
		});
		$("#next-14").on('click',function () {
			productSliderThirteen.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				28. seven column slider
	======================================================================*/
	if ($( ".xs-slider-7-col" ).length > 0) {
		var sevenColSlider = $( ".xs-slider-7-col" );
		sevenColSlider.on( 'initialized.owl.carousel translated.owl.carousel', function() {
			var $this = $(this);
			$this.find( '.owl-item.last-child' ).each( function() {
				$(this).removeClass( 'last-child' );
			});
			$this.find( '.owl-item.first-child' ).each( function() {
				$(this).removeClass( 'first-child' );
			});
			$(this).find( '.owl-item.active' ).last().addClass( 'last-child' );
			$(this).find( '.owl-item.active' ).first().prev().addClass( 'first-child' );
		});
		var sevenColSlider = $('.xs-slider-7-col');
		sevenColSlider.myOwl({
			items: 7,
			autoplay: true,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 1,
				},
				// breakpoint from 768 up
				768 : {
					items: 3,
				},
				1024: {
					items: 7,
				}
			}
		})
		$("#prev-15").on('click',function () {
			sevenColSlider.trigger('prev.owl.carousel');
		});
		$("#next-15").on('click',function () {
			sevenColSlider.trigger('next.owl.carousel');
		});
	}

	/*==========================================================
				29. produt block slider
	======================================================================*/
	if($('.product-block-slider').length > 0) {
		$('.product-block-slider').myOwl({
			items: 1,
			dots: true
		});
	}

	/*==========================================================
				30. xs progress
	======================================================================*/
	if($('.xs-progress').length > 0) {
		$('.xs-progress').each(function() {
			$(this).find('.progress-bar').css({
				width: $(this).find('.progress-bar').attr('aria-valuenow') + '%',
			});
		});
	}

	$('.rate-graph').each(function() {
		if ($(this).find('.rate-graph-bar').attr('data-percent') <= 100) {
			$(this).find('.rate-graph-bar').css({
				width: $(this).find('.rate-graph-bar').attr('data-percent') + '%',
			});
		} else {
			$(this).find('.rate-graph-bar').css({
				width: 100+'%',
			});
		}
	});

  	/*=============================================================
			 31. input number increase
	=========================================================================*/

	var $this = $( '.xs_input_number' );
	$this.append( '<span class="sub"><img src="assets/images/minus.png" alt="" /></span>' );
	$this.append( '<span class="add"><img src="assets/images/plus.png" alt="" /></span>' );
	$( '.xs_input_number' ).each( function( ) {
		var spinner = $(this),
		input = spinner.find( 'input[type="number"]' ),
		add = spinner.find( '.add' ),
		sub = spinner.find( '.sub' );
		input.parent().on( 'click', '.sub', function( event ) {
			event.preventDefault();
			/* Act on the event */
			if ( input.val() > parseInt( input.attr( 'min' ) ) )
			input.val( function( i, oldval ) { return --oldval; } );
		});
		input.parent().on( 'click', '.add', function ( ) {
			event.preventDefault( );
			if ( input.val() < parseInt( input.attr( 'max' ) ) )
			input.val( function( i, oldval ) { return ++oldval; } );
		});
	});

	/*==========================================================
				32. echo init
	======================================================================*/
	echo.init({
        offset: 100,
		throttle: 100,
		unload: false,
	});
	
	if($('.xs-nav-tab li a').length > 0) {
		$('.xs-nav-tab li a').on('click', function() {
			echo.render();
		});
	}

	/*----------------------------------------------------------------------
				33. pulse effect
	-------------------------------------------------------------------*/
	if($('.add_to_wishlist').length > 0) {
		$('.add_to_wishlist').hover(function(){
			var $this = $(this).addClass('pulse_effect');
			setTimeout(() => {
				$this.removeClass('pulse_effect');
			}, 500);
		});
	}

	/*==========================================================
			34. countdown timer
	======================================================================*/
	$('.xs-countdown-timer[data-countdown]').each(function() {
		var $this = $(this), 
			finalDate = $(this).data('countdown');

			$this.countdown(finalDate, function(event) {
			var $this = $(this).html(event.strftime(' ' 
			+ '<div class="xs-timer-container"><span class="timer-count">%-D </span><span class="timer-title">Days</span></div>'
			+ '<div class="xs-timer-container"><span class="timer-count">%H </span><span class="timer-title">Hours</span></div>' 
			+ '<div class="xs-timer-container"><span class="timer-count">%M </span><span class="timer-title">Minutes</span></div>' 
			+ '<div class="xs-timer-container"><span class="timer-count">%S </span><span class="timer-title">Secods</span></div>'));
		});
	});

	/*==========================================================
			35 .ajax chimp init
	======================================================================*/
	if($('.xs-newsletter').length > 0) {
		$('.xs-newsletter').ajaxChimp({
			url: 'https://facebook.us8.list-manage.com/subscribe/post?u=85f515a08b87483d03fee7755&amp;id=66389dc38b'
		});
	}

	/*==========================================================
			36. xs popover
	======================================================================*/
	if ($('.btn[data-toggle="popover"]').length > 0) {
		// popover init
		$('.btn[data-toggle="popover"]').popover();
		// popover add class
		$('.btn[data-toggle="popover"]').on('click', function(e) {
			e.preventDefault();
			if ($(this).hasClass('is-active')) {
				$(this).removeClass('is-active');
			} else {
				$(this).addClass('is-active')
			}
		});
	}

	/*==========================================================
			37. number percentage
	=======================================================================*/
	var number_percentage = $(".number-percentage");
	function animateProgressBar(){
		number_percentage.each(function() {
			$(this).animateNumbers($(this).attr("data-value"), true, parseInt($(this).attr("data-animation-duration"), 10));
		});
	}

	if ($('.waypoint-tigger').length > 0) {
		var waypoint = new Waypoint({
			element: document.getElementsByClassName('waypoint-tigger'),
			handler: function(direction) {
				animateProgressBar();
			}
		});
	}

	/*==========================================================
			38. number counter up
	=======================================================================*/
	$.fn.animateNumbers = function(stop, commas, duration, ease) {
		return this.each(function() {
			var $this = $(this);
			var start = parseInt($this.text().replace(/,/g, ""), 10);
			commas = (commas === undefined) ? true : commas;
			$({
				value: start
			}).animate({
				value: stop
			}, {
				duration: duration == undefined ? 500 : duration,
				easing: ease == undefined ? "swing" : ease,
				step: function() {
					$this.text(Math.floor(this.value));
					if (commas) {
						$this.text($this.text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
					}
				},
				complete: function() {
					if (parseInt($this.text(), 10) !== stop) {
						$this.text(stop);
						if (commas) {
							$this.text($this.text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
						}
					}
				}
			});
		});
	};

	/*=============================================================
		 39. social tigger add class
	=========================================================================*/
	if ($('.tigger-icon').length > 0) {
		$( '.tigger-icon' ).on( 'click', function( event ) {
			event.preventDefault( );
			/* Act on the event */
			var this_item = $( '.xs-social-tigger' );
			if ( this_item.hasClass( 'active' ) ) {
				this_item.removeClass( 'active' );
			} else {
				this_item.addClass( 'active' );
			}
		});
	}

	/*=============================================================
		 40. sync product preview slider
	=========================================================================*/

	if ( ( $( '.sync-slider-preview' ).length > 0 ) && ( $( '.sync-slider-thumb' ).length > 0 ) ) {
	var sync1 = $( ".sync-slider-preview" ),
		sync2 = $( ".sync-slider-thumb" ),
		slidesPerPage = 3,
		syncedSecondary = true;
		sync1.owlCarousel( {
		items: 1,
			slideSpeed: 2000,
			nav: false,
			autoplay: true,
			dots: false,
			loop: true,
			responsiveRefreshRate: 200,
			navText: [''],
		} ).on( 'changed.owl.carousel', syncPosition );
		sync2
		.on( 'initialized.owl.carousel', function( ) {
		sync2.find( ".owl-item" ).eq( 0 ).addClass( "current" );
		} )
		.owlCarousel( {
		items: slidesPerPage,
			dots: false,
			nav: false,
			smartSpeed: 200,
			slideSpeed: 500,
			margin: 30,
			slideBy: slidesPerPage, //alternatively you can slide by 1, this way the active slide will stick to the first item in the second carousel
			responsiveRefreshRate: 100,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 2,
				},
				1024: {
					items: 3,
				}
			}
		} ).on( 'changed.owl.carousel', syncPosition2 );
		function syncPosition( el ) {
		//if you set loop to false, you have to restore this next line
		//var current = el.item.index;

		//if you disable loop you have to comment this block
		var count = el.item.count - 1;
			var current = Math.round( el.item.index - ( el.item.count / 2 ) - .5 );
			if ( current < 0 ) {
			current = count;
		}
		if ( current > count )  {
			current = 0;
		}
	
				//end block
	
		sync2
			.find( ".owl-item" )
			.removeClass( "current" )
			.eq( current )
			.addClass( "current" );
			var onscreen = sync2.find( '.owl-item.active' ).length - 1;
			var start = sync2.find( '.owl-item.active' ).first( ).index( );
			var end = sync2.find( '.owl-item.active' ).last( ).index( );
			if ( current > end ) {
			sync2.data( 'owl.carousel' ).to( current, 100, true );
		}
			if ( current < start ) {
				sync2.data( 'owl.carousel' ).to( current - onscreen, 100, true );
			}
		}
	
		function syncPosition2( el ) {
			if ( syncedSecondary ) {
			var number = el.item.index;
				sync1.data( 'owl.carousel' ).to( number, 100, true );
			}
		}
	
		sync2.on( "click", ".owl-item", function( e ) {
		e.preventDefault( );
			var number = $( this ).index( );
			sync1.data( 'owl.carousel' ).to( number, 300, true );
		});
	}


	/*=============================================================
		 	41. sync banner nav slider
	=========================================================================*/
	if ($('.nav-slider-content').length > 0 && $('.xs-slider-nav').length > 0) {
		var sync1 = $(".nav-slider-content");
		var sync2 = $(".xs-slider-nav");
		var slidesPerPage = 9; //globaly define number of elements per page
		var syncedSecondary = true;
		
		sync1.owlCarousel({
			items : 1,
			slideSpeed : 2000,
			nav: true,
			autoplay: true,
			dots: false,
			loop: true,
			responsiveRefreshRate : 200,
			navText: ['<i class="icon icon-arrow-left"></i>','<i class="icon icon-arrow-right"></i>'],
			responsive : {
				// breakpoint from 0 up
				0 : {
					nav: false
				},
				1024: {
					nav: true
				}
			}
		}).on('changed.owl.carousel', syncPosition);
		
		sync2
			.on('initialized.owl.carousel', function () {
			sync2.find(".owl-item").eq(0).addClass("current");
			})
			.owlCarousel({
			items : slidesPerPage,
			dots: false,
			nav: false,
			smartSpeed: 200,
			slideSpeed : 500,
			slideBy: slidesPerPage, //alternatively you can slide by 1, this way the active slide will stick to the first item in the second carousel
			responsiveRefreshRate : 100,
			responsive : {
				// breakpoint from 0 up
				0 : {
					items: 3,
				},
				1024: {
					items: 9,
				}
			}
		}).on('changed.owl.carousel', syncPosition2);
		
		function syncPosition(el) {
			//if you set loop to false, you have to restore this next line
			//var current = el.item.index;
			
			//if you disable loop you have to comment this block
			var count = el.item.count-1;
			var current = Math.round(el.item.index - (el.item.count/2) - .5);
			
			if(current < 0) {
			current = count;
			}
			if(current > count) {
			current = 0;
			}
			
			//end block
		
			sync2
			.find(".owl-item")
			.removeClass("current")
			.eq(current)
			.addClass("current");
			var onscreen = sync2.find('.owl-item.active').length - 1;
			var start = sync2.find('.owl-item.active').first().index();
			var end = sync2.find('.owl-item.active').last().index();
			
			if (current > end) {
			sync2.data('owl.carousel').to(current, 100, true);
			}
			if (current < start) {
			sync2.data('owl.carousel').to(current - onscreen, 100, true);
			}
		}
		
		function syncPosition2(el) {
			if(syncedSecondary) {
			var number = el.item.index;
			sync1.data('owl.carousel').to(number, 100, true);
			}
		}
		
		sync2.on("click", ".owl-item", function(e){
			e.preventDefault();
			var number = $(this).index();
			sync1.data('owl.carousel').to(number, 300, true);
		});
	}

	/*=============================================================
					42. insta feed
	=========================================================================*/
	$.fn.spectragram.accessData = {
		accessToken: '623597756.02b47e1.3dbf3cb6dc3f4dccbc5b1b5ae8c74a72',
		clientID: '02b47e1b98ce4f04adc271ffbd26611d'
	};
	$('.xs-demoFeed').spectragram('getUserFeed',{
		max: 9,
		size: 'small',
	});

	/*==========================================================
				43. jquery slider range
	======================================================================*/
	if ($('#slider-range').length > 0) {
		$( "#slider-range" ).slider({
			range: true,
			min: 0,
			max: 500,
			values: [ 0, 300 ],
			slide: function( event, ui ) {
			  $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
			}
		  });
		$( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
			" - $" + $( "#slider-range" ).slider("values", 1));
	}


	/*==========================================================
				44. contact form init
	======================================================================*/

	$(document).on('submit', '#xs-contact-form', function(event) {
		event.preventDefault();
		/* Act on the event */

		var xs_contact_name = $('#xs_contact_name'),
			xs_contact_email = $('#xs_contact_email'),
			xs_contact_subject = $('#xs_contact_subject'),
			x_contact_massage = $('#x_contact_massage'),
			xs_contact_submit = $('#xs_contact_submit'),
			xs_contact_error = false;

		$('.xpeedStudio_success_message').remove();

		if (xs_contact_name.val() === '') {
			xs_contact_name.addClass('invaild');
			xs_contact_error = true;
			xs_contact_name.focus();
			return false;
		} else {
			xs_contact_name.removeClass('invaild');
		}
		if (xs_contact_email.val() === '') {
			xs_contact_email.addClass('invaild');
			xs_contact_error = true;
			xs_contact_email.focus();
			return false;
		} else if (!email_pattern(xs_contact_email.val().toLowerCase())){
			xs_contact_email.addClass('invaild');
			xs_contact_error = true;
			xs_contact_email.focus();
			return false;
		} else {
			xs_contact_email.removeClass('invaild');
		}
		if (xs_contact_subject.val() === '') {
			xs_contact_subject.addClass('invaild');
			xs_contact_error = true;
			xs_contact_subject.focus();
			return false;
		} else {
			xs_contact_subject.removeClass('invaild');
		}
		if (x_contact_massage.val() === '') {
			x_contact_massage.addClass('invaild');
			xs_contact_error = true;
			x_contact_massage.focus();
			return false;
		} else {
			x_contact_massage.removeClass('invaild');
		}

		if (xs_contact_error === false) {
			xs_contact_submit.before().hide().fadeIn();
			$.ajax({
					type: "POST",
					url: "assets/php/contact-form.php",
					data: {
					'xs_contact_name' : xs_contact_name.val(),
					'xs_contact_email' : xs_contact_email.val(),
					'xs_contact_subject' : xs_contact_subject.val(),
					'x_contact_massage' : x_contact_massage.val(),
				},
				success: function(result){
					xs_contact_submit.after('<span class="xpeedStudio_success_message">' + result + '</span>').hide().fadeIn();

					// $(".xpeedStudio_loader").fadeOut("normal", function() {
					// 	$(this).remove();
					// });

					$('#xs-contact-form')[0].reset();
				}
			});
		}
	});

	/*==========================================================
			45. Minicart dropdown remove close on body click
	======================================================================*/
	if ($('.xs-miniCart-dropdown .dropdown-menu').length > 0) {
		$('.xs-miniCart-dropdown .dropdown-menu').on('click', function (e) {
			event.stopPropagation();
		});	
	}

	/*==========================================================
			46. Search form open by click
	======================================================================*/
	if ($('.navsearch-button').length > 0) {
		$('.navsearch-button').on('click', function (e) {
			e.preventDefault();
	
			if (!($('.navsearch-form')).is(":visible")) {
				$(this).find('i').removeClass('icon-search').addClass('icon-search-minus');
			} else {
				$(this).find('i').removeClass('icon-search-minus').addClass('icon-search');
			}
			$(this).parent().parent().find('.navsearch-form').slideToggle(300);
		});
	}

	/*==========================================================
			47. Side Offset cart menu open
	======================================================================*/
	if ($('.offset-cart-menu').length > 0) {
		$('.offset-cart-menu').on('click', function (e){
			e.preventDefault();
			$('.xs-sidebar-group').addClass('isActive');
		});
	}
	if ($('.close-side-widget').length > 0) {
		$('.close-side-widget').on('click', function (e){
			e.preventDefault();
			$('.xs-sidebar-group').removeClass('isActive');
		});
	}

	/*==========================================================
			48. Recent view slider
	======================================================================*/
	if ($('.recent-view-slider').length > 0) {
		$('.recent-view-slider').myOwl({
			items: 6,
			margin: 20,
			nav: false,
			dots: false,
			responsive: {
				0: {
					items: 1
				},
				768: {
					items: 3
				},
				1024: {
					items: 6
				}
			}
		});
	}

	/*==========================================================
			49. vertical menu dropdown tigger on click overlay active init
	======================================================================*/
	if ($(window).width() >= 1024) {
		if ($('.cd-dropdown-trigger').length > 0) {
			$('.cd-dropdown-trigger').on('click', function() {
				if ($('body').hasClass('isOverlayActive')) {
					$('body').removeClass('isOverlayActive');
				} else {
					$('body').addClass('isOverlayActive');
				}
			});
		}
	}

	/*==========================================================
			50. promo popup open when window is load
	======================================================================*/
	var now, time, lastTimePopup, repeatAfter;
		
		now = new Date();
		time = now.getTime();
		repeatAfter = 100 * 60 * 1000;//First number 100 is after number of minutes the popup should be showed.
	
    if (localStorage.getItem('lastTimePopup') !== null) {
        lastTimePopup = localStorage.getItem('lastTimePopup');
    }

    if (((now - lastTimePopup) >= repeatAfter) || !lastTimePopup) {
        setTimeout(function() {
			if ($('.xs-promoPopup').length) {
				if ($(window).width() >= 991) {
					$.magnificPopup.open({
						items: {
							src: '.xs-promoPopup' 
						},
						type: 'inline',
						fixedContentPos: false,
						fixedBgPos: true,
						overflowY: 'auto',
						closeBtnInside: true,
						preloader: true,
						midClick: true,
						removalDelay: 300,
						callbacks:{
							beforeOpen: function() {
								this.st.mainClass = "my-mfp-zoom-in xs-promo-popup";
							}
						}
					});	
				}
			}
		}, 1000);

        localStorage.setItem('lastTimePopup', now.getTime());
	}
	
	/*==========================================================
			51. video popup init
	======================================================================*/
	if ($('.xs-video-popup').length > 0) {
		$('.xs-video-popup').magnificPopup({
			disableOn: 700,
			type: 'iframe',
			mainClass: 'mfp-fade',
			removalDelay: 160,
			preloader: false,

			fixedContentPos: false
		});
	}

	/*==========================================================
			52. Post gallery slider
	======================================================================*/
	if ($('.post-gallery-slider').length > 0) {
		$('.post-gallery-slider').myOwl({
			nav: true,
			navText: ['<i class="icon icon-arrow-right round-nav"></i>','<i class="icon icon-arrow-left round-nav"></i>'],
			responsive: {
				0: {
					nav: false
				},
				768: {
					nav: true
				}
			}
		});
	}

	$('.cd-dropdown-trigger').on('click', function (e) {
		e.stopPropagation();
	});

	$('body').on('click', function () {
		if ($('body').hasClass('isOverlayActive')) {
			$('body').removeClass('isOverlayActive')
			$('.cd-dropdown-trigger').removeClass('dropdown-is-active');
			$('.cd-dropdown').removeClass('dropdown-is-active');
		}
	});

}); // end ready function

$(window).on('scroll', function() {

}); // END Scroll Function 

$(window).on('resize', function() {

	// menu vertical open and close when cross break point 
	menuVertical();

	// nav cover init
	// navCover();

	// theme thumb equal height
	getHeight();
}); // End Resize

/*==========================================================
			53. XpeedStudio Maps
======================================================================*/

if ($('#xs-maps').length > 0) {
	// When the window has finished loading create our google map below
	google.maps.event.addDomListener(window, 'load', init);

		function init() {
		// Basic options for a simple Google Map
		// For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
		var mapOptions = {
			// How zoomed in you want the map to start at (always required)
			zoom: 11,
			scrollwheel: false,
			navigationControl: false,
			mapTypeControl: true,
			scaleControl: false,
			draggable: true,
			disableDefaultUI: true,

			// The latitude and longitude to center the map (always required)
			center: new google.maps.LatLng(40.6700, -73.9400), // New York

			// How you would like to style the map. 
			// This is where you would paste any style found on Snazzy Maps.
			styles: [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#a0d6d1"},{"lightness":17}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#dedede"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#dedede"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#dedede"},{"lightness":18}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":16}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#f1f1f1"},{"lightness":21}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"on"},{"color":"#ffffff"},{"lightness":16}]},{"elementType":"labels.text.fill","stylers":[{"saturation":36},{"color":"#333333"},{"lightness":40}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#f2f2f2"},{"lightness":19}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#fefefe"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#fefefe"},{"lightness":17},{"weight":1.2}]}]
			};

			// Get the HTML DOM element that will contain your map 
			// We are using a div with id="map" seen below in the <body>
			var mapElement = document.getElementById('xs-maps');

			// Create the Google Map using our element and options defined above
			var map = new google.maps.Map(mapElement, mapOptions);

			// Let's also add a marker while we're at it
			var marker = new google.maps.Marker({
			position: new google.maps.LatLng(40.6700, -73.9400),
			map: map,
			title: 'XspeedStudio',
			icon: 'assets/images/map-marker.svg',
		});
	}
}

})(jQuery);