var jkCommon = new (function() {
  this.init = function() {
    $('.tipt').tooltip( {placement: "top", html: true});
    $('.tipr').tooltip( {placement: "right", html: true});
    $('.tipb').tooltip( {placement: "bottom", html: true});
    $('.tipl').tooltip( {placement: "left", html: true});
    $('.tipno').removeAttr('title');
  };
});
