package projet_itu_mbds_22_23

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import static org.springframework.http.HttpStatus.*

@Secured('isFullyAuthenticated()')
class PathwayController {

    PathwayService pathwayService

    MyPahtwayService myPahtwayService

    SpringSecurityService springSecurityService


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond pathwayService.list(params), model:[pathwayCount: pathwayService.count()]
    }

    def show(Long id) {
        respond pathwayService.get(id)
    }

    def create() {
        respond new Pathway(params)
    }

    def save(Pathway pathway) {
        if (pathway == null) {
            notFound()
            return
        }

        pathway.author = ((User)springSecurityService.getCurrentUser())

        try {
            myPahtwayService.savePathway(pathway, request.getFiles("illus"))
        } catch (ValidationException e) {
            respond pathway.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pathway.label', default: 'Pathway'), pathway.id])
                redirect pathway
            }
            '*' { respond pathway, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond pathwayService.get(id)
    }

    def update(Pathway pathway) {
        if (pathway == null) {
            notFound()
            return
        }

        try {
            myPahtwayService.savePathway(pathway, request.getFiles("illus"))
        } catch (ValidationException e) {
            respond pathway.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'pathway.label', default: 'Pathway'), pathway.id])
                redirect pathway
            }
            '*'{ respond pathway, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        pathwayService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'pathway.label', default: 'Pathway'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pathway.label', default: 'Pathway'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
