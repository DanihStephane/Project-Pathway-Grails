package projet_itu_mbds_22_23

import org.springframework.web.multipart.MultipartFile

class MyPahtwayService {

    PathwayService pathwayService

    FileService fileService

    def savePathway(Pathway pathway, List<MultipartFile> files){
        if(pathway.moderateurs != null && pathway.moderateurs.contains(null)) throw new IllegalStateException("Erreur concernant les modérateurs")
        for(MultipartFile file : files){
            if(!file.isEmpty()){
                String fileName = fileService.saveFile(file)
                pathway.addToIllustrations(new Illustration(filename: fileName))
            }
        }
        pathwayService.save(pathway)
    }

    def deletePathway(Pathway pathWay, User connectedUser){
        if(!pathWay.isAllowedToModifyPathway(connectedUser)) throw new IllegalAccessException("Un parcours ne peut être  supprimé ou modifié que par son propriétaire ou ses modérateurs")
        pathwayService.delete(pathWay.getId())
    }

    def updatePathway(Pathway pathway , User connectedUser){
        if(!pathway.isAllowedToModifyPathway(connectedUser))
            throw new IllegalAccessException("Un parcours ne peut être supprimé ou modifié que par son propriétaire ou ses modérateurs")
        pathwayService.save(pathway)
    }

    def fullUpdatePathway(Pathway pathway, User connectedUser, List<MultipartFile> illustrations, String[] moderateurs){
        if(!pathway.isAllowedToModifyPathway(connectedUser))
            throw new IllegalAccessException("Un parcours ne peut être  supprimé ou modifié que par son propriétaire ou ses modérateurs")
        pathway.moderateurs = User.getAll(Arrays.asList(moderateurs)) as Set
        if(pathway.pois.contains(null)) throw new IllegalStateException("Erreur concernant les pois")
        pathway.illustrations.clear();
        return savePathway(pathway, illustrations)
    }

}
