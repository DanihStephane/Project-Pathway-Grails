package projet_itu_mbds_22_23

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.expression.AccessException
import grails.validation.ValidationException

@Secured('isFullyAuthenticated()')
class ApiController {

    MyPoiService myPoiService

    MyPahtwayService myPahtwayService

    SpringSecurityService springSecurityService


    private static final String INTERNAL_ERROR = "Une erreur interne s'est produite";

    /**
     * Ressource Singleton
     * GET, PUT, PATCH, DELETE*/
    def poi() {
        switch (request.getMethod()) {
            case "GET":
                // On vérifie que l'id soit bien fourni
                if (!params.id) return response.sendError(400, "L'id du poi est requis")
                def poiInstance = Poi.get(params.id)
                // On vérifie que l'instance correspondante à l'id soit bien définie
                if (!poiInstance) return response.status = 404
                // On sérialise le contenu dans le format demandé
                serializeThis(poiInstance, request.getHeader("Accept"))
                break
            case "PUT":
                if (!params.id) return response.sendError(400, "L'id du poi est requis")
                def poiInstance = Poi.get(params.id)
                if (!poiInstance) return response.status = 404
                Pathway pathwayInstance = Pathway.get(request.parameterMap.get("pathwayId"))
                if (!pathwayInstance) return response.sendError(400, "Veuillez spécifier un pathway valide")
                Map map = request.parameterMap;
                map.put("pathway", pathwayInstance);
                try {
                    myPoiService.allowModifyPathway(springSecurityService.getCurrentUserId(), poiInstance.getPathway())
                    poiInstance.setProperties(map)
                    if (poiInstance.validate()) {
                        poiInstance = myPoiService.updateAllFields(poiInstance, request.getFiles("illustrations"), springSecurityService.getCurrentUserId())
                        return serializeThis(poiInstance, request.getHeader("Accept"))
                    }
                    return response.sendError(400, "Un ou plusieurs champs invalides")
                } catch (AccessException e) {
                    return response.sendError(403, "Vous n'êtes pas autorisé à modifier un poi pour ce parcours")
                }
                break
            case "PATCH":
                if (!params.id) return response.sendError(400, "L'id du poi est requis")
                def poiInstance = Poi.get(params.id)
                if (!poiInstance) return response.status = 404
                poiInstance.title = request.getParameter("title")
                poiInstance.description = request.getParameter("description")
                try {
                    if (poiInstance.validate()) {
                        poiInstance = myPoiService.update(poiInstance, springSecurityService.getCurrentUserId())
                        return serializeThis(poiInstance, request.getHeader("Accept"))
                    }
                    return response.sendError(400, "Titre ou description non valide")
                } catch (AccessException e) {
                    return response.sendError(403, "Vous n'êtes pas autorisé à modifier un poi pour ce parcours")
                }
                break
            case "DELETE":
                if (!params.id) return response.sendError(400, "L'id du poi est requis")
                def poiInstance = Poi.get(params.id)
                if (!poiInstance) return response.status = 404
                try {
                    myPoiService.delete(poiInstance, springSecurityService.getCurrentUserId())
                    return response.status = 204
                } catch (AccessException e) {
                    return response.sendError(403, "Vous n'êtes pas autorisé à supprimer ce poi")
                }
                response.status = 500
                render("Une erreur interne s'est produite")
                break
            default:
                break
        }
    }

    /**
     * Ressource Collection
     * GET, POST*/
    def pois() {
        switch (request.getMethod()) {
            case "POST":
                Pathway pathwayInstance = Pathway.get(request.parameterMap.get("pathwayId"))
                if (!pathwayInstance) return response.sendError(400, "Veuillez spécifier un pathway valide")
                Map map = request.parameterMap;
                map.put("pathway", pathwayInstance);
                Poi poiInstance = new Poi(map)
                try {
                    if (poiInstance.validate()) {
                        poiInstance = myPoiService.save(poiInstance, request.getFiles("illustrations"), springSecurityService.getCurrentUserId())
                        return serializeThis(poiInstance, request.getHeader("Accept"))
                    }
                    return response.sendError(400, "Un ou plusieurs champs invalides")
                } catch (AccessException e) {
                    return response.sendError(403, "Vous n'êtes pas autorisé à créer un poi pour ce parcours")
                }
                break
            case "GET":
                int page = 1
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    if (page <= 0) page = 1
                } catch (NumberFormatException e) {
                }
                List pois = Poi.list(max: 10, offset: (page - 1) * 10)
                serializeThis(pois, request.getHeader("Accept"))
                break
            default:
                break
        }
    }

    /**
     * Ressource Singleton
     * GET , PUT, PATCH , DELETE*/
    def parcour() {
        switch (request.getMethod()) {
            case "GET":
                if (!params.id) {
                    return response.sendError(400, "Id du parcours requis pour cette opération")
                }
                def pathwayInstance = Pathway.get(params.id)
                if (!pathwayInstance) return response.status = 404
                serializeThis(pathwayInstance, request.getHeader("Accept"))
                break
            case "PUT":
                if (!params.id) {
                    return response.sendError(400, "Id du parcours à modifier requis")
                }
                try {
                    def pathway = Pathway.get(params.id)
                    if (!pathway) return response.status = 404
                    Map parameter = request.parameterMap
                    pathway.setProperties(parameter);
                    String[] moderateurs = request.getParameter("moderateur").split(",")
                    String[] pois = request.getParameter("poi").split(",")
                    pathway.changePois(pois)
                    pathway = myPahtwayService.fullUpdatePathway(pathway, (User) springSecurityService.getCurrentUser(), request.getFiles("illus"), moderateurs)
                    return serializeThis(pathway, request.getHeader("Accept"))
                } catch (IllegalAccessException | IllegalStateException exception) {
                    return response.sendError(400, exception.getMessage())
                } catch (Exception exception) {
                    return response.sendError(500, INTERNAL_ERROR)
                }
                break
            case "PATCH":
                if (!params.id) {
                    return response.sendError(400, "Id du parcours à modifier requis")
                }
                def pathwayInstance = Pathway.get(params.id)
                if (!pathwayInstance) return response.status = 404
                try {
                    pathwayInstance.title = request.getParameter("title")
                    pathwayInstance.description = request.getParameter("description")
                    myPahtwayService.updatePathway(pathwayInstance, (User) springSecurityService.getCurrentUser())
                    return serializeThis(pathwayInstance, request.getHeader("Accept"))
                } catch (ValidationException e) {
                    return response.sendError(400, "Titre ou description non valide")
                } catch (IllegalAccessException e) {
                    return response.sendError(400, e.getMessage())
                } catch (Exception ex) {
                    return response.sendError(500, INTERNAL_ERROR)
                }
                break
            case "DELETE":
                if (!params.id) {
                    return response.sendError(400, "Id du parcours à supprimer est requis")
                }
                try {
                    Pathway pathway = Pathway.get(params.id)
                    if (!pathway) return response.status = 404;
                    myPahtwayService.deletePathway(pathway, (User) springSecurityService.getCurrentUser())
                    return 204
                } catch (IllegalAccessException e) {
                    return response.sendError(400, e.getMessage());
                } catch (Exception e) {
                    return response.sendError(500, INTERNAL_ERROR)
                }
                break
            default:
                break
        }

    }

    /**
     * Ressource Collection
     * GET , POST*/
    def parcours() {
        switch (request.getMethod()) {
            case "GET":
                Integer page = parseInt(params.page, 1)
                Integer size = parseInt(params.size, 10)
                List parcours = Pathway.list(max: size, offset: (page - 1) * size)
                serializeThis(parcours, request.getHeader("Accept"))
                break
            case "POST":
                Map map = request.parameterMap
                int code = 400;
                String message = "Une erreur interne s'est produite";
                try {
                    Pathway pathway = new Pathway(map);
                    pathway.author = ((User) springSecurityService.getCurrentUser())
                    String[] moderateurs = request.getParameter("moderateur").split(",")
                    pathway.moderateurs = User.getAll(Arrays.asList(moderateurs)) as Set
                    myPahtwayService.savePathway(pathway, request.getFiles("illus"));
                    return serializeThis(pathway, request.getHeader("Accept"))
                } catch (IllegalStateException e) {
                    message = "La valeur pour modérateur est incorrecte"
                } catch (ValidationException e) {
                    message = "Contrainte de valeur non respecté sur la description ou la titre du parcours"
                } catch (Exception e) {
                    message = INTERNAL_ERROR;
                    code = 500;
                }
                return response.sendError(code, message)
                break
            default:
                break
        }
    }

    def serializeThis(Object object, String accept) {
        switch (accept) {
            case "text/json":
            case "application/json":
            case "json":
                render object as JSON
                break
            case "text/xml":
            case "application/xml":
            case "xml":
                render object as XML
                break
            default:
                return response.status = 406
                break
        }
    }

    private def parseInt(String nbr, int valParDefaut) {
        try {
            return Integer.parseInt(nbr);
        } catch (NumberFormatException nfe) {
            return valParDefaut;
        }
    }
}
