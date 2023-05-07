package projet_itu_mbds_22_23

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "/about"(view:"/about")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
