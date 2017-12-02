var angular = angular.module("angular", ["ngFileUpload"]);
var video;
var canvas;
var image;
var localstream;
var framRec = "#faceConfirmationModal";

//Função que recebe um dataURL e transforma em blob, que é aceito pela API
function makeblob(dataURL) {
    var BASE64_MARKER = ';base64,';
    if (dataURL.indexOf(BASE64_MARKER) == -1) {
        var parts = dataURL.split(',');
        var contentType = parts[0].split(':')[1];
        var raw = decodeURIComponent(parts[1]);
        return new Blob([raw], {type: contentType});
    }
    var parts = dataURL.split(BASE64_MARKER);
    var contentType = parts[0].split(':')[1];
    var raw = window.atob(parts[1]);
    var rawLength = raw.length;

    var uInt8Array = new Uint8Array(rawLength);

    for (var i = 0; i < rawLength; ++i) {
        uInt8Array[i] = raw.charCodeAt(i);
    }

    return new Blob([uInt8Array], {type: contentType});
}
;
//FUNÇÃO QUE ABRE O VIDEO, RETIRADA DA DOCUMENTAÇÃO DO BROWSER FIREFOX;
function videoStart() {
    //   // Older browsers might not implement mediaDevices at all, so we set an empty object first
    if (navigator.mediaDevices === undefined) {
        navigator.mediaDevices = {};
    }
// Some browsers partially implement mediaDevices. We can't just assign an object
// with getUserMedia as it would overwrite existing properties.
// Here, we will just add the getUserMedia property if it's missing.
    if (navigator.mediaDevices.getUserMedia === undefined) {
        var constraints = {audio: false, video: {facingMode: "user"}};
        navigator.mediaDevices.getUserMedia = function (constraints) {

            // First get ahold of the legacy getUserMedia, if present
            var getUserMedia = navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

            // Some browsers just don't implement it - return a rejected promise with an error
            // to keep a consistent interface
            if (!getUserMedia) {
                return Promise.reject(new Error('getUserMedia is not implemented in this browser'));
            }

            // Otherwise, wrap the call to the old navigator.getUserMedia with a Promise
            return new Promise(function (resolve, reject) {
                getUserMedia.call(navigator, constraints, resolve, reject);
            });
        }
    }
    navigator.mediaDevices.getUserMedia({video: true})
            .then(function (stream) {
                video = document.querySelector('video');
                // Older browsers may not have srcObject
                if ("srcObject" in video) {
                    video.srcObject = stream;
                    localstream = stream;
                } else {
                    // Avoid using this in new browsers, as it is going away.
                    video.src = window.URL.createObjectURL(stream);
                    localstream = stream;
                }
                video.onloadedmetadata = function (e) {
                    video.play();

                };
            })
            .catch(function (err) {
                console.log(err.name + ": " + err.message);
            });
}
;
//PARA O VIDEO
function videoStop() {
    video.pause();
    video.src = "";
    localstream.getTracks()[0].stop();
}

//CONTROLLER DA PÁGINA PRINCIPAL.
angular.controller('firstPageController', function ($scope, $http, $window, $timeout) {
//    $(framRec).modal("show");    
//    trackFace();
    var CTX = $window.ctx;
    $scope.acc = "";
    $scope.pass = "";
    $scope.loadingFace = false;
    $scope.close = function (modal) {
        $(modal).modal("hide");
        videoStop();
    };
    $scope.login = function () {
        $http.post(CTX + "/data/login.jsp?action=loginUser&acc=" + $scope.acc + "&pass=" + $scope.pass)
                .then(function (response) {
                    if (response.data.cod == 1) {
                        $scope.erro = response.data.erro;
                        $timeout(function () {
                            $scope.erro = "";
                        }, 2000);
                    } else if (response.data.cod == 2) {
                        $(framRec).modal("show");
                        videoStart();
                    }
                });
    };
    //Chama uma função do reconhecimento, que faz a requisição no servidor e devolve a resposta.
    $scope.recognition = function () {
        var canvas = document.getElementById('canvas');
        var ctx = canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);        
        $scope.result = "";
        $('#loading').show();
        $('#video').hide();
        $('#canvas').show();
        videoStop();
        //BLOB JPG
        var blob = makeblob(canvas.toDataURL("image/jpg"));
        //PARA ENVIAR COMO MULTIPART/FORM-DATA PRECISO CRIAR UM FORM
        var fd = new FormData();
        fd.append('fname', 'imageToRec');
        fd.append('data', blob);
        // AJAX QUE FAZ A REQUISIÇÃO DO SERVIDOR, ENVIO O FORM COMO PARAMETRO
        $.ajax({
            method: 'POST',
            url: CTX + '/data/recognition_api.jsp?action=getFace', data: fd, processData: false,
            contentType: false})
                .done(function (data) {
                    $('#loading').hide(); 
                    $scope.result = data.response;
                    console.log($scope.result == 'true');
                    if ($scope.result == 'true') {
                                              
                        //ESSE TIMEOUT CHAMA UMA PAGINA DEPOIS DE 200 MS
                        $('#successFace').show();
                        $timeout(function () {
                            window.location.replace(CTX + data.link);
                        }, 2000);
                    } else {''                        
                        $('#errorFace').show();
                        $timeout(function () {
                            $('#errorFace').hide();
                            videoStart();
                            $('#video').show();
                            $('#canvas').hide();
                        }, 2000);
                    }
                    console.log(data.response);
                });
    };
});