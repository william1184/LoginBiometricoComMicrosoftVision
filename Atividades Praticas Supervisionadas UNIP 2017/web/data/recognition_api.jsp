<%-- 
    Document   : recognition_api
    Created on : 09/11/2017, 23:52:10
    Author     : William
--%>


<%@page import="sun.misc.BASE64Decoder"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%  //TRUE SE FOR MULTIPART
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    List<FileItem> items = null;
    //Pega a imagem do LIST e cria um objeto InputStream.       
    InputStream inputImage = null;
    String action = request.getParameter("action");
    String apiResponse = "A imagem não está reconhecível ou não possui rostos";
    String image = request.getParameter("image");
    String name = "";
    String personID = session.getAttribute("personID").toString();
    String link = "";
    if (isMultipart) {
        //Pega a imagem e adiciona ao LIST<>
        items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
        Iterator<FileItem> iter = items.iterator();
        while (iter.hasNext()) {
            FileItem item = iter.next();

            if (item.isFormField()) {

                String nm = item.getFieldName();
                switch (nm) {
                    case ("data[fname]"):
                        name = new String(item.get(), "UTF-8").trim();
                        break;
                }

            } else {

                if ("image/jpeg".equals(item.getContentType())) {
                    //PEGO O INPUTSTREAM DO FORMDATA EM FORMATO JPEG SE FOR O CASO
                    inputImage = item.getInputStream();
                } else if ("image/png".equals(item.getContentType())) {
                    // ||        ||                   EM FORMATO PNG SE FOR O CASO
                    inputImage = item.getInputStream();
                }
            }

        }
    }
    if (action != null && action.equalsIgnoreCase("getFace")) {
        //AQUI EU ENVIO O INPUTSTREAM QUE EU RECEBI PARA A MICROSOFT VERIFICAR O ROSTO E ME RETORNAR O FACEID
        apiResponse = recognition_api.microsoftFaceAPi.getFaceDetection(inputImage);
        if (!apiResponse.equals("")) {      
            //AQUI SE O FACEID FOR DIFERENTE DE VAZIO EU COMPARO COM O ROSTO DO PERSONID QUE EU CRIEI NO AZURE
            apiResponse = recognition_api.microsoftFaceAPi.getFaceVerify(apiResponse,personID);
            if (Boolean.valueOf(apiResponse)) {
//                SE FOR POSITIVO  EU CRIO UMA SESSION COM O ATRIBUTO PARA SABER QUE ELE SE LOGOU E QUE ÁREA ELE É.
                session.setAttribute("level", session.getAttribute("whatLevel"));
                link = session.getAttribute("link").toString();
            }else{
                //CASO NÃO, RETORNO QUE É FALSO
                apiResponse = "false";
            };
        }

    } else {
        //CASO ELE NÃO TENHA O PARAMETRO GETFACE
        apiResponse = "false";
    }
    //sempre retorno um application/json para o meu cliente.
%>
{"response":"<%=apiResponse%>","link":"<%=link%>"}
