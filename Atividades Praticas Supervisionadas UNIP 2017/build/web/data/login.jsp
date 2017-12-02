<%-- 
    Document   : login
    Created on : 07/11/2017, 22:00:04
    Author     : APS
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    String method = request.getMethod();
    String action = request.getParameter("action");
    String erro = "";
    String msg = "";   
    System.out.println(method.equalsIgnoreCase("post"));
    if (method.equalsIgnoreCase("post")) {
        if (action != null && action.equals("loginUser")) {
            String acc = request.getParameter("acc").trim();
            String pass = request.getParameter("pass").trim();
            if (acc.trim().equals("frank.william") && pass.trim().equals("123")) {
                session.setAttribute("whatLevel", 1);
                session.setAttribute("link", "/restrict/areaNivel1.jsp");
                session.setAttribute("personID", "51a456f2-82ea-4f5f-bd4f-48eede32b9e5");
            } else if (acc.trim().equals("nivel2") && pass.trim().equals("123")) {
                session.setAttribute("whatLevel", 2);
                session.setAttribute("link", "/restrict/areaNivel2.jsp");
                session.setAttribute("personID", "51a456f2-82ea-4f5f-bd4f-48eede32b9e5");
            } else if (acc.trim().equals("nivel3") && pass.trim().equals("123")) {
                session.setAttribute("whatLevel", 3);
                session.setAttribute("link", "/restrict/areaNivel3.jsp");
                session.setAttribute("personID", "51a456f2-82ea-4f5f-bd4f-48eede32b9e5");
            } else {
                erro = "dados não conferem";

            }
        }
    };
    if (erro != null && erro != "") {
%>
{"cod":1,"erro":"<%=erro%>"}
<%} else {%>
{"cod":2,"responsemsg":"<%=msg%>"}
<%}%>

<%%>