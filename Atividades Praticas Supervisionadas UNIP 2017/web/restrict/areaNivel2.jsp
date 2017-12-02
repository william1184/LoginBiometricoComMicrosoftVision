<%-- 
    Document   : areaNivel1
    Created on : 07/11/2017, 22:09:42
    Author     : APS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Nivel 2</title>
        <link href="<%= request.getContextPath()%>/res/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="<%= request.getContextPath()%>/res/css/style-pages.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <div class="container">
            <h1 class="text-center">Area do Nivel 2</h1>
        
        <table class="table table-hover table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Propriedade Rural</th>
                        <th>Quantidade de Funcionários</th>
                        <th>Área de Atuação</th>
                        <th>Poluentes</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="item in arrayItems" ng-repeat="prop in arrayQtdFunc" >
                        <td >{{item.prop}}</td>
                        <td>{{item.qtd}}</td>
                        <td>Plantação de alimentos</td>
                        <td>{{item.pol}}</td>
                    </tr>
                </tbody>
            </table>
            </div>
        <%@include file="../../WEB-INF/jspf/footer.jspf" %>
        <script src="<%=request.getContextPath()%>/res/scripts/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/res/scripts/angular.min.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/res/scripts/bootstrap.min.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/res/scripts/controllers/levelTwoController.js" type="text/javascript"></script>
    </body>
</html>
