package com.meli


import grails.testing.web.controllers.ControllerUnitTest
import spock.lang.Specification



class AgenciasControllerSpec extends Specification implements ControllerUnitTest<AgenciasController> {

    def setup() {
    }

    def cleanup() {
    }


    def "AgenciasController.index accepts GET requests"() {
        when:
        request.method = 'GET'
        controller.index()

        then:
        response.status == 200
    }


    def "AgenciasController.searchAgencias respond OK to POST request"() {
        given:
        controller.agenciasService = Mock(AgenciasService) {
            getLocation(_) >> [lat: -31.416431, lng: -31.416431]
        }


        when:
        request.method = 'POST'
        params.mediosPago = 'rapipago'
        params.direccion = '9 de Julio 145, Cordoba'
        params.radio = 500

        controller.searchAgencias()


        then:
        response.status == 200
    }


}
