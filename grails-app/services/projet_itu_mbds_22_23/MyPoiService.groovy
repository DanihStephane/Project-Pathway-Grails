package projet_itu_mbds_22_23

import org.springframework.expression.AccessException
import org.springframework.web.multipart.MultipartFile


class MyPoiService {
    PoiService poiService
    FileService fileService

    def save(Poi poi, ArrayList<MultipartFile> files, Long idUser){
        allowModifyPathway(idUser, poi.getPathway())
        addIllustrationToPoi(poi, files)
        poiService.save(poi)
    }

    def addIllustrationToPoi(Poi poi, ArrayList<MultipartFile> files){
        for(MultipartFile file : files) {
            if(!file.isEmpty()){
                String filename = fileService.saveFile(file)
                poi.addToIllustrations(new Illustration(filename: filename))
            }
        }
    }

    void allowModifyPathway(Long idUser, Pathway pathway){
        if(pathway.getAuthor().getId() == idUser)
            return
        Set<User> moderateurs = pathway.getModerateurs()
        for(User moderateur: moderateurs){
            if(moderateur.getId() == idUser)
                return
        }
        throw new AccessException("Vous n'avez pas le droit de modifier ce pathway")
    }

    def delete(Poi poi, Long idUser) {
        allowModifyPathway(idUser, poi.getPathway())
        poiService.delete(poi.getId())
    }

    def updateAllFields(Poi poi, ArrayList<MultipartFile> files, Long idUser){
        allowModifyPathway(idUser, poi.getPathway())
        Poi oldPoi = Poi.get(poi.getId())
        allowModifyPathway(idUser, oldPoi.getPathway())
        poi.getIllustrations().clear()
        addIllustrationToPoi(poi, files)
        poiService.save(poi)
    }

    def update(Poi poi, Long idUser){
        allowModifyPathway(idUser, poi.getPathway())
        poiService.save(poi)
    }

}
