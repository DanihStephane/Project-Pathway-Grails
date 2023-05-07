package projet_itu_mbds_22_23

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.expression.AccessException
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*

@Secured('isFullyAuthenticated()')
class PoiController {

    PoiService poiService
    MyPoiService myPoiService
    SpringSecurityService springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond poiService.list(params), model:[poiCount: poiService.count()]
    }

    def show(Long id) {
        respond poiService.get(id)
    }

    def create() {
        respond new Poi(params)
    }

    def save(Poi poi) {
        if (poi == null) {
            notFound()
            return
        }
        try {
            User connectedUser = ((User)springSecurityService.getCurrentUser());
            myPoiService.save(poi, request.getFiles("illus"), connectedUser.getId())
        } catch (ValidationException e) {
            respond poi.errors, view:'create'
            return
        }
        catch (AccessException e){
            flash.message = message(code: 'poi.pathway', message: "Vous ne pouvez pas ajouter un poi pour ce pathway")
            render(view: 'create', model: [poi: poi])
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'poi.label', default: 'Poi'), poi.id])
                redirect poi
            }
            '*' { respond poi, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond poiService.get(id)
    }

    def update(Poi poi) {
        if (poi == null) {
            notFound()
            return
        }
        try {
            User connectedUser = ((User)springSecurityService.getCurrentUser());
            myPoiService.updateAllFields(poi, request.getFiles("illus"), connectedUser.getId());
        } catch (ValidationException e) {
            respond poi.errors, view:'edit'
            return
        }
        catch (AccessException e){
            flash.message = message(code: 'poi.pathway', message: "Vous ne pouvez modifier un poi pour ce pathway")
            render(view: 'edit', model: [poi: poi])
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'poi.label', default: 'Poi'), poi.id])
                redirect poi
            }
            '*'{ respond poi, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        poiService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'poi.label', default: 'Poi'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'poi.label', default: 'Poi'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
