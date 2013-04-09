var jkCommon = new (function() {
  this.init = function() {
    $('.tipt').tooltip( {placement: "top", html: true, container: 'body' });
    $('.tipr').tooltip( {placement: "right", html: true, container: 'body'});
    $('.tipb').tooltip( {placement: "bottom", html: true, container: 'body'});
    $('.tipl').tooltip( {placement: "left", html: true, container: 'body'});
    $('.tipno').removeAttr('title');
    $(".topm .sch input").focus(function() {
      $(this).animate({ width: "200px" })
    })
  };
  this.initAjax = function() {
    $(".topfsh .close").click(function() {
      $(".topfsh").slideUp();
      return false;
    });
  };
  this.playFirstTrack = function() {
    $(".trkcont li:first-child .play-track").click();
  };
  this.destroyTrackPopover = function() {
    $("ul.trklst > li > div .mre").popover('destroy');
    //$(".popover").hide();
    $("ul.trklst > li > div .mre").removeClass("ppo");
  };
  this.showTopFlash = function(msg) {
    $(".topfsh").text(msg);
    $(".topfsh").slideDown();
    setTimeout(function() { $(".topfsh").slideUp(); }, 5000 );
  }
});
