import AjaxSetup from "../lib/ajax_setup";

export default class AdminBaseView {
  mount() {

      AjaxSetup.setup();

      $('#main-sidebar').find('[data-toggle="collapse"]').on('click', function()
          {
              if($(this).find('.icon-chevron-left').length == 1){
                  $(this).find('.icon-chevron-left').removeClass('icon-chevron-left').addClass('icon-chevron-down');
              }
              else {
                  $(this).find('.icon-chevron-down').removeClass('icon-chevron-down').addClass('icon-chevron-left');
              }
          }
      )

    let sidebar_toggle = $('#sidebar-toggle');

    sidebar_toggle.on('click', function () {
      let wrapper = $('#wrapper');
      let main    = $('#main-part');
      let sidebar =$('#main-sidebar');

      let mainWrapperCollapsedClasses = 'col-xs-12 sidebar-collapsed';
      let mainWrapperExpandedClasses = 'col-xs-9 col-xs-offset-3 col-md-10 col-md-offset-2';

      wrapper.toggleClass('sidebar-minimized');
      sidebar.toggleClass('hidden-xs');
      main
          .toggleClass(mainWrapperCollapsedClasses)
          .toggleClass(mainWrapperExpandedClasses);
    });

      $('.sidebar-menu-item').mouseover(function(){
          if($('#wrapper').hasClass('sidebar-minimized')){
              $(this).addClass('menu-active');
              $(this).find('ul.nav').addClass('submenu-active');
          }
      });

      $(".sidebar-menu-item").mouseout(function(){
          if($('#wrapper').hasClass('sidebar-minimized')){
              $(this).removeClass('menu-active');
              $(this).find('ul.nav').removeClass('submenu-active');
          }
      });

      // Main menu active item submenu show
      let active_item = $('#main-sidebar').find('.selected');
      active_item.closest('.nav-pills').addClass('in');
      active_item.closest('.nav-sidebar')
          .find('.icon-chevron-left')
          .removeClass('icon-chevron-left')
          .addClass('icon-chevron-down');

      }
  unmount() {

  }


}
