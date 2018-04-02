


var defaultparams = {
    rate: 1,
    pitch: 1,
    volume: 1,
    text: "",
    voice: 'Spanish Latin American Female'
};

/**
 * Comment
 */
function reproducir(texto) {
    responsiveVoice.speak(texto,'Spanish Latin American Female');
}

function stop() {
    responsiveVoice.cancel();
}





