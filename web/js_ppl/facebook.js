//var fbAppId = '139630469982984';
//var fbAppId = '1706508529644202';

function compartir(link, texto, img, titulo){
	window.open('http://www.facebook.com/sharer.php?u='+link, 'ventanacompartir', 'toolbar=0, status=0, width=650, height=450');
}
/*
function compartir(link, texto, img, titulo){
	
   FB.ui({
    method: 'share',
    href: link
  },
  // callback
  function(response) {
    if (response && !response.error_message) {
      alert('Posting completed.');
    } else {
      alert('Error while posting.');
    }
  });
}*/