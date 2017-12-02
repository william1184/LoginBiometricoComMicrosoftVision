<%-- 
    Document   : newjsp
    Created on : 08/11/2017, 16:42:04
    Author     : frank.inova
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Detect Faces Sample</title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
        <script src="https://wzrd.in/standalone/blob-util@latest"></script>
        <!--    <script src="/res/scripts/tracking-min.js"></script>
            <script src="res/scripts/data/face-min.js"></script>-->
    </head>
    <body>

        
        <video autoplay></video>
        <h1>Detect Faces:</h1>
        Enter the URL to an image that includes a face or faces, then click the <strong>Analyze face</strong> button.
        <br><br>
       
        Image to analyze: <input type="file" name="inputImage" id="inputImage" />
        <button onclick="clickk()">OK</button>
        <button onclick="processImage()">Analyze face</button>
        <br><br>
        <div id="wrapper" style="width:1020px; display:table;">
            <div id="jsonOutput" style="width:600px; display:table-cell;">
                Response:
                <br><br>
            </div>            
        </div>
        <script>

             var video = document.querySelector("video");
//            var canvas = document.getElementById('canvas');
//            var context = canvas.getContext('2d');
            if(false){
            // Get access to the camera!
            if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                // Not adding `{ audio: true }` since we only want video now
                navigator.mediaDevices.getUserMedia({video: true}).then(function (stream) {
                   
                    video.src = window.URL.createObjectURL(stream);
                    
                });
            }}
            // Trigger photo take
            document.getElementById("snap").addEventListener("click", function () {
                context.drawImage(video, 0, 0, 640, 480);
            });
            var imageSource;
            function clickk() {
                console.log("Entrou");
                var file = $('#inputImage')[0].files[0];
                var fileReader = new FileReader();
                fileReader.onloadend = function (e) {
                    var arrayBuffer = e.target.result;
                    var fileType = 'image/jpg';
                    blobUtil.arrayBufferToBlob(arrayBuffer, fileType).then(function (blob) {
                        imageSource = blob;
                        console.log(imageSource);
                        console.log('here is a blob', blob);
                    }).catch(console.log.bind(console));
                };
                fileReader.readAsArrayBuffer(file);
            };

            
        </script>
    </body>
</html>