<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   
    String nom = "";
    String cognom = "";
    String email = "";
    String dataNaixement = "";
    String sexe = "";
    String tipus = "pelicules";
    String[] generes = new String[0];
    String pass1 = "";
    String pass2 = "";
    String errorNom = "";
    String errorCognom = "";
    String errorEmail = "";
    String errorContrasenya = "";
    boolean hiHaErrors = false;

   
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        
        // Recollim tots els paràmetres del formulari
        nom = request.getParameter("nom");
        cognom = request.getParameter("cognom");
        email = request.getParameter("email");
        dataNaixement = request.getParameter("data_naixement");
        sexe = request.getParameter("sexe");
        tipus = request.getParameter("tipus");
        
        String[] generesParams = request.getParameterValues("generes");
        if (generesParams != null) {
            generes = generesParams;
        }
        
        pass1 = request.getParameter("contrasenya1");
        pass2 = request.getParameter("contrasenya2");

        // Si un camp falla, s'esborra NOMÉS el seu valor
        if (nom == null || nom.trim().isEmpty()) {
            errorNom = "El nom no pot estar buit.";
            nom = "";
            hiHaErrors = true;
        }
        if (cognom == null || cognom.trim().isEmpty()) {
            errorCognom = "El cognom no pot estar buit.";
            cognom = "";
            hiHaErrors = true;
        }
        if (email == null || email.trim().isEmpty()) {
            errorEmail = "L'email és obligatori.";
            email = "";
            hiHaErrors = true;
        }
        
        // esborrem les DUES contrasenyes
        if (pass1 == null || pass2 == null || pass1.trim().isEmpty() || pass2.trim().isEmpty()) {
            errorContrasenya = "Les contrasenyes no poden estar buides.";
            pass1 = "";
            pass2 = "";
            hiHaErrors = true;
        } else if (!pass1.equals(pass2)) {
            errorContrasenya = "Les contrasenyes no són iguals.";
            pass1 = "";
            pass2 = "";
            hiHaErrors = true;
        }

        // Netegem els valors nuls de control abans de pintar-los a l'HTML si retornem per errors
        if (nom == null) nom = "";
        if (cognom == null) cognom = "";
        if (email == null) email = "";
        if (dataNaixement == null) dataNaixement = "";
        if (sexe == null) sexe = "";
        if (tipus == null) tipus = "pelicules";

        
        if (!hiHaErrors) {
            response.setContentType("application/xml; charset=UTF-8");
            
            out.clear(); 
            out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            out.println("<registre>");
            out.println("   <nom>" + nom + "</nom>");
            out.println("   <cognom>" + cognom + "</cognom>");
            out.println("   <email>" + email + "</email>");
            out.println("   <data_naixement>" + dataNaixement + "</data_naixement>");
            out.println("   <sexe>" + sexe + "</sexe>");
            out.println("   <tipus>" + tipus + "</tipus>");
            out.println("   <generes>");
            for (String g : generes) {
                out.println("       <genere>" + g + "</genere>");
            }
            out.println("   </generes>");
            out.println("   <contrasenya>" + pass1 + "</contrasenya>");
            out.println("</registre>");
            return; 
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulari de registre</title>
</head>
<body>

    <h2>Formulari de registre</h2>

    <form action="" method="POST">
        
        <p>
            <label for="nom">Nom:</label>
            <input type="text" id="nom" name="nom" value="<%= nom %>">
            <span style="color:red;"><%= errorNom %></span>
        </p>
        
        <p>
            <label for="cognom">Cognom:</label>
            <input type="text" id="cognom" name="cognom" value="<%= cognom %>">
            <span style="color:red;"><%= errorCognom %></span>
        </p>
        
        <p>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= email %>">
            <span style="color:red;"><%= errorEmail %></span>
        </p>
        
        <p>
            <label for="data_naixement">Data naixement:</label>
            <input type="date" id="data_naixement" name="data_naixement" value="<%= dataNaixement %>">
        </p>
        
        <p>
            <label for="sexe">Sexe:</label>
            <select id="sexe" name="sexe">
                <option value="" disabled <% if (sexe.equals("")) { out.print("selected"); } %>>Selecciona una opció</option>
                <option value="home" <% if (sexe.equals("home")) { out.print("selected"); } %>>Home</option>
                <option value="dona" <% if (sexe.equals("dona")) { out.print("selected"); } %>>Dona</option>
                <option value="no_declarat" <% if (sexe.equals("no_declarat")) { out.print("selected"); } %>>No declarat</option>
            </select>
        </p>
        
        <p>
            Tipus:<br>
            <input type="radio" id="pelicules" name="tipus" value="pelicules" <% if (tipus.equals("pelicules")) { out.print("checked"); } %>>
            <label for="pelicules">Pel·lícules</label><br>
            
            <input type="radio" id="series" name="tipus" value="series" <% if (tipus.equals("series")) { out.print("checked"); } %>>
            <label for="series">Sèries</label>
        </p>
        
        <p>
            Gèneres:<br>
            <input type="checkbox" id="accio" name="generes" value="accio" <% if (java.util.Arrays.asList(generes).contains("accio")) { out.print("checked"); } %>>
            <label for="accio">Acció</label><br>
            
            <input type="checkbox" id="ciencia_ficcio" name="generes" value="ciencia_ficcio" <% if (java.util.Arrays.asList(generes).contains("ciencia_ficcio")) { out.print("checked"); } %>>
            <label for="ciencia_ficcio">Ciència i ficció</label><br>
            
            <input type="checkbox" id="historica" name="generes" value="historica" <% if (java.util.Arrays.asList(generes).contains("historica")) { out.print("checked"); } %>>
            <label for="historica">Històrica</label><br>
            
            <input type="checkbox" id="drama" name="generes" value="drama" <% if (java.util.Arrays.asList(generes).contains("drama")) { out.print("checked"); } %>>
            <label for="drama">Drama</label><br>
            
            <input type="checkbox" id="comedia" name="generes" value="comedia" <% if (java.util.Arrays.asList(generes).contains("comedia")) { out.print("checked"); } %>>
            <label for="comedia">Comèdia</label>
        </p>
        
        <p>
            <label for="contrasenya1">Contrasenya:</label>
            <input type="password" id="contrasenya1" name="contrasenya1" value="<%= pass1 %>">
            <span style="color:red;"><%= errorContrasenya %></span>
        </p>
        
        <p>
            <label for="contrasenya2">Repetir contrasenya:</label>
            <input type="password" id="contrasenya2" name="contrasenya2" value="<%= pass2 %>">
        </p>
        
        <p>
            <input type="submit" value="Enviar">
        </p>
        
    </form>

</body>
</html>
