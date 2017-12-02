<%-- 
    Document   : home
    Created on : 07/11/2017, 19:53:57
    Author     : APS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="angular">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Ministério do Meio Ambiente</title>
        <link href="<%= request.getContextPath()%>/res/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="<%= request.getContextPath()%>/res/css/style-pages.css" rel="stylesheet" type="text/css">
<!--        <script src="<%= request.getContextPath()%>/res/scripts/tracking-min.js"></script>
        <script src="<%= request.getContextPath()%>/res/scripts/data/face-min.js"></script>-->
        <link rel="manifest" href="/manifest.manifest">
        <!--<script src="<%= request.getContextPath()%>/res/node_modules/dat.gui/build/dat.gui.min.js"></script>-->
    </head>
    <body>             
        <%@include file="/WEB-INF/jspf/header.jspf" %>        
        <div class="container" ng-controller='firstPageController'>
            
            <h1 class="text-center">Bem vindo ao sistema</h1>
            <div class="row">                
                <div class="text-center">
                    <br>
                    <div class="col-sm-4"></div>                    
                    <%if(session.getAttribute("level") == null || session.getAttribute("level") == "undefined"){%>
                    <div class="col-sm-4 jumbotron">
                        <form>
                            <ng-form>
                                <div class="alert alert-danger" ng-show="!!erro" ng-cloak><span>{{erro}}</span></div>
                                <label>Login</label>
                                <input class="form-control" type="text" maxlength="24" ng-model='acc' />
                                <label>Password</label>
                                <input class="form-control" type="password" maxlength="36" ng-model='pass'/>                            
                                <br>                           
                                <button class="text-center btn btn-block btn-primary" ng-click="login()">Logar-se</button>
                                
                            </ng-form>
                        </form>
                    </div>
                    <%}else{%>
                     <div class="col-sm-4 jumbotron">
                         <h3>Você já está logado.</h3>
                         <br>
                         <br>
                         <%if(session.getAttribute("level").toString().equals("1")){%>                         
                         <a class="btn btn-block btn-info" href="<%=request.getContextPath()%>/restrict/areaNivel1.jsp">Ir para Área</a>
                         <%}else if(session.getAttribute("level").toString().equals("2")){%>
                         <a class="btn btn-block btn-info" href="<%=request.getContextPath()%>/restrict/areaNivel2.jsp">Ir para Área</a>
                         <%}else{%>
                         <a class="btn btn-block btn-info" href="<%=request.getContextPath()%>/restrict/areaNivel3.jsp">Ir para Área</a>
                         <%}%>
                         <a class="btn btn-block btn-danger" href="<%=request.getContextPath()%>/data/logout.jsp">Sair</a>
                    </div>
                     <%}%>
                    <div class="col-sm-4"></div>
                </div>                
            </div>
                <%@include file="/WEB-INF/jspf/faceConfirmation.jspf" %> 
        </div>
        <script src="<%=request.getContextPath()%>/res/scripts/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/res/scripts/angular.min.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/res/scripts/bootstrap.min.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/res/scripts/ng-file-upload.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/res/scripts/controllers/firstPageController.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/res/scripts/blob-util.min.js" type="text/javascript"></script>
    </body>
</html>

