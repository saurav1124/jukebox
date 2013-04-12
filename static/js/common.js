var jkCommon = new (function() {
  this.hashLeftNavLoaded = false;
  this.hashTrackLoaded = false;
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
  };
  this.setPageTitle = function(title) {
  	document.title = title + " - Miliea";
  };
  this.addHash = function(idx, str) {
  	var currHash = location.hash.split('!');
  	var newHash = new Array();
  	for (i=0;i<=idx; i++) {
  		if (i == idx) {
  			newHash[i] = str;
  		} else if (currHash[i+1] != undefined) {
  			newHash[i] = currHash[i+1];
  		} else {
  			newHash[i] = "";
  		}
  	}
  	if (currHash.length-1 > idx+1) {
  		for (i=idx+1;i<currHash.length-1;i++) {
  			newHash[i] = currHash[i+1];
  		}
  	}
  	var h = "";
  	for (var i=0;i<newHash.length;i++) {
    	h += "!" + newHash[i];
  	}
  	window.location.hash = h;
  };
  this.applyHash = function() {
  	if (!this.hashLeftNavLoaded) {
	  	var hashes = location.hash.split('!');
	  	for (var i=1;i<hashes.length;i++) {
	  		if (i == 1 && hashes[i].substring(1) != "") {
	  			$("#ln" + hashes[i].substring(1)).click();
	  		} else if (i == 2 && hashes[i] != "") {
	  			$("#tk" + hashes[i]).click();
	  		}
	  	}
  	}
  	this.hashLeftNavLoaded = true;
  };
  this.loadHashLeftNav = function() {
    if (!this.hashLeftNavLoaded) {
      var hashes = location.hash.split('!');
      if (hashes.length > 1) {
        if (hashes[1] != "") {
          jkCommon.loadLeftNavBody($("#ln" + hashes[1]));
        }
      }
    }
    this.hashLeftNavLoaded = true;
  };
  this.playHashTrack = function() {
    if (!this.hashTrackLoaded) {
      var hashes = location.hash.split('!');
      if (hashes.length > 2) {
        this.playTrack(hashes[2]);
      }
    }
    this.hashTrackLoaded = true;
  };
  this.playTrack = function(id) {
    this.destroyTrackPopover();
  	var track = $("#tk" + id);
    if (track != undefined) {
      if (track.attr("data-playing") == undefined) {
        var id = track.attr("data-id");
        var detailUrl = track.attr("data-url");
        $.ajax({
          url: detailUrl,
          success: function(data) {
            $(".player").attr("data-track", id);
            $(".player .dtls .ttl").text(data.title);
            $(".player .dtls .info").text(data.artist + " - " + data.album);
            $(".player .art img").attr("src", data.artwork.url);
  
            track.closest("ul").find("li").removeClass("playing");
            track.closest("li").addClass("playing");
            $(".play-track").removeAttr("data-playing");
            track.attr("data-playing", "1");
            track.closest("li").find(".play-count").text(data.play_count);
            track.closest("li").find(".play-count").show();
            jkCommon.addHash(1, id);
            jkCommon.setPageTitle(track.attr("data-title"));
  
            var url = data.media.mp3;
            $(".ml-no-play").fadeOut("fast");
            $(".ml-play").fadeIn("fast");
            $("#player_1").jPlayer("setMedia", {
              mp3: url
            });
            $("#player_1").jPlayer("play");
          }
        });
      } else {
        $(".play-track").removeAttr("data-playing");
        track.closest("ul").find("li").removeClass("playing");
        $("#player_1").jPlayer("stop");
      }
    }
  };
  this.loadLeftNavBody = function(lnav) {
    var url = lnav.attr("href");
    $(".ltnav .active").removeClass("active");
    lnav.closest("li").addClass("active");
    $.ajax({
      url: url,
      success: function(data) {
        $("#lib_content").html(data);
        jkCommon.addHash(0, lnav.attr("data-id"));
        jkCommon.playHashTrack();
      }
    });
  }
});
