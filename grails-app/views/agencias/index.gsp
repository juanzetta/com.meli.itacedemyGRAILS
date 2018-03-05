<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Ejercicio GRAILS</title>
    <asset:javascript src="agencias.js"></asset:javascript>

</head>
<body>
<div class="row">
    <div class="page-header text-center">
        <h1>Buscador de Agencias de Pago</h1>
    </div>
</div>
<div>
    <g:form name="createForm" controller="agencias" action="searchAgencias">
        <label for="direccion"> Direccion: </label>
        <g:textField name="direccion" value="${direccion}">  </g:textField><br>
        <label for="mediosPago"> Direccion: </label>
        <select name="mediosPago" id="mediosPago" >
            <g:each in="${mediosPago}">
                <option value="${it.id}">${it.name}</option>
            </g:each>
        </select><br>
        <label for="radio"> Radio de distancia en metros: </label>
        <g:textField name="radio" value="${radio}">  </g:textField><br>

        <g:actionSubmit value="Buscar" action="searchAgencias"/>

    </g:form>

</div>

</body>
</html>



