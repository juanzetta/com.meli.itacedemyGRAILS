package com.meli

import groovy.json.JsonSlurper
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.maps.GeoApiContext
import com.google.maps.GeocodingApi
import com.google.maps.model.GeocodingResult
import grails.converters.JSON


class AgenciasController {

    AgenciasService agenciasService
    def index() {
        agenciasService.getMediosPagos()
        render(view:"index", model: agenciasService.getMediosPagos())
    }

    def searchAgencias(){
        def medioPago= params.mediosPago
        def direccion= params.direccion
        def radio= params.radio
        //buscar coordenadas API google
        def location = agenciasService.getLocation(direccion)
        def lat = location.lat.toString()
        def lng = location.lng.toString()


        render (view: "agencias", model: agenciasService.getAgencias(medioPago, lat, lng, radio))


    }




}

