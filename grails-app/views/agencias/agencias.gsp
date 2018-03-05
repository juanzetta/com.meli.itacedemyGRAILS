<!doctype html>
<html>
<head>
    %{--<meta name="layout" content="main"/>--}%
    <title>Ejercicio GRAILS</title>
    <style>

    #map {
        height: 100%;
    }

    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
    }
    </style>
    <asset:javascript src="application.js"/>
    <asset:stylesheet src="application.css"/>
    <script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
</head>
<body>
<div class="row">
    <div class="page-header text-center">
        <h1>Agencias de Pago</h1>
    </div>
</div>
<div>
<table>
    <tr>
        <th>Descripción</th>
        <th>Distancia</th>

    </tr>
        <g:each in = "${agenciasPago.results}" var="a">
            <tr  class="details" name="${a.description}">
                <td>${a.description}</td>
                <td>${a.distance}</td>
            </tr>
        </g:each>


</table>
</div>

<div id="map"></div>

<script>
    var arrayResultados = [];
    <g:each in = "${agenciasPago.results}">
        var s= "${it.address.location}";
        console.log(s);
        var arrayS = s.split(",");
        arrayResultados.push({lat: parseFloat(arrayS[0]), lng: parseFloat(arrayS[1])});
    </g:each>
    var map;
    var markers=[];
    function initMap() {
        centro = arrayResultados[0];
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15,
            center: centro
        });


        for (i in arrayResultados) {
            console.log(arrayResultados[i]);
            addMarker(arrayResultados[i])
        }
    }

    function addMarker(position){
        window.setTimeout(function() {
            markers.push(new google.maps.Marker({
                position: position,
                map: map,
                animation: google.maps.Animation.DROP
            }));
        });
    }
</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD1ZUDttXsM1IfOHKpSeQgElavORd64Wu8&callback=initMap">
</script>

<script>

    $(".details").on("click", function () {
        var name = $(this).attr("name");
        <g:each in="${agenciasPago.results}" var="p">
        if (("${p.description}") == (name)) {
            $.alert({
                title: "<strong>Agencia: </strong>${p.description}",
                content: "<strong>Direccion:</strong> ${p.address.address_line}<br>" +
                "<strong>Ciudad:</strong> ${p.address.city}<br>" +
                "<strong>Pais:</strong> ${p.address.country}<br>" +
                "<strong>Provincia:</strong> ${p.address.state}<br>" +
                "<strong>Codigo Postal:</strong> ${p.address.zip_code}<br>",
            });
        }
        </g:each>
    });

</script>

</body>
</html>