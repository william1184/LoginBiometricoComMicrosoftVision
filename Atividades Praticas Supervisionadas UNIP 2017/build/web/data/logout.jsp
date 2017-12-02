<%-- 
    Document   : login
    Created on : 07/11/2017, 22:00:04
    Author     : APS
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    session.invalidate(); 
    response.sendRedirect(request.getContextPath()+"/home.jsp");
    
    
%>