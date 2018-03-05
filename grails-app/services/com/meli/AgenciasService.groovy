package com.meli

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.maps.GeoApiContext
import com.google.maps.GeocodingApi
import com.google.maps.model.GeocodingResult
import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper

@Transactional
class AgenciasService {

    def getMediosPagos(){
        def url = new URL('https://api.mercadolibre.com/sites/MLA/payment_methods')
        def connection = (HttpURLConnection)url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def mp = json.parse(connection.getInputStream())
        def mediosPago = []
        for (medio in mp)
        {
            if(medio.payment_type_id=="ticket") {
                mediosPago << [id:medio.id, name:medio.name]
            }
        }
        [mediosPago:mediosPago]
    }

    def getLocation(direccion){
        GeoApiContext context = new GeoApiContext.Builder()
                .apiKey("AIzaSyDwphX8RRM7M-hxDZCfue5C1b32RbWoVTI")
                .build();
        GeocodingResult[] results = GeocodingApi.geocode(context,direccion).await();
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        def lat = gson.toJson(results[0].geometry.location.lat).toString()
        def lng = gson.toJson(results[0].geometry.location.lng).toString()

        return [lat: lat, lng: lng]
    }

    def getAgencias(medioPago, lat, lng, radio){

        def agenciasPago

        def url = new URL('https://api.mercadolibre.com/sites/MLA/payment_methods/'+medioPago+'/agencies?near_to='+lat+','+lng+','+radio+'&limit=10&sort_by=distance,desc')

        def connection = (HttpURLConnection)url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()

        agenciasPago = json.parse(connection.getInputStream())

        println agenciasPago
        [agenciasPago : agenciasPago]
    }
}
