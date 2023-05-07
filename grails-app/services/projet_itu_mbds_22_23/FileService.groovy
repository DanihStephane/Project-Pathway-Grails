package projet_itu_mbds_22_23

import org.springframework.web.multipart.MultipartFile


class FileService {

    def grailsApplication

    String saveFile(MultipartFile file){

        // Vérification que le fichier n'est pas null
        if (file == null) {
            return "Le fichier est null"
        }

        // Vérification que le fichier n'est pas vide
        if (file.empty) {
            return "Le fichier est vide"
        }

        // Vérification de l'extension du fichier
        def allowedExtensions = grailsApplication.config.getProperty("file.extensions").split(",")
        def fileExtension = file.originalFilename.split("\\.").last().toLowerCase()
        if (!allowedExtensions.contains(fileExtension)) {
            return "L'extension de fichier $fileExtension n'est pas autorisée. Extensions autorisées: ${allowedExtensions.join(', ')}"
        }

        // Vérification de la taille maximale autorisée
        def maxSizeInBytes =  Integer.parseInt(grailsApplication.config.getProperty("file.size")) * 1024 * 1024 // 1 MB
        if (file.size > maxSizeInBytes) {
            return "La taille du fichier dépasse la limite maximale de ${maxSizeInBytes/1024} KB"
        }

        // Renommage du fichier en utilisant le nom actuel du fichier plus un UUID
        def newFileName = "${UUID.randomUUID()}_${file.originalFilename}"
        def fileDir = grailsApplication.config.config.illustrations.basePath
        def filePath = "$fileDir/$newFileName"
        def dest = new File(filePath)
        file.transferTo(dest)

        return newFileName
    }

}
