<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>
</head>
<body>
<content tag="nav">
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Application Status <span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li class="dropdown-item"><a href="#">Environment: ${grails.util.Environment.current.name}</a></li>
            <li class="dropdown-item"><a href="#">App profile: ${grailsApplication.config.getProperty('grails.profile')}</a></li>
            <li class="dropdown-item"><a href="#">App version:
                <g:meta name="info.app.version"/></a>
            </li>
            <li role="separator" class="dropdown-divider"></li>
            <li class="dropdown-item"><a href="#">Grails version:
                <g:meta name="info.app.grailsVersion"/></a>
            </li>
            <li class="dropdown-item"><a href="#">Groovy version: ${GroovySystem.getVersion()}</a></li>
            <li class="dropdown-item"><a href="#">JVM version: ${System.getProperty('java.version')}</a></li>
            <li role="separator" class="dropdown-divider"></li>
            <li class="dropdown-item"><a href="#">Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</a></li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Artefacts <span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li class="dropdown-item"><a href="#">Controllers: ${grailsApplication.controllerClasses.size()}</a></li>
            <li class="dropdown-item"><a href="#">Domains: ${grailsApplication.domainClasses.size()}</a></li>
            <li class="dropdown-item"><a href="#">Services: ${grailsApplication.serviceClasses.size()}</a></li>
            <li class="dropdown-item"><a href="#">Tag Libraries: ${grailsApplication.tagLibClasses.size()}</a></li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Installed Plugins <span class="caret"></span></a>
        <ul class="dropdown-menu dropdown-menu-right">
            <g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
                <li class="dropdown-item"><a href="#">${plugin.name} - ${plugin.version}</a></li>
            </g:each>
        </ul>
    </li>
</content>


<div class="banner" >
    <div class="container mt-5 mb-5">
        <section class="bg-success p-4 fw-600 py-5">
            <div class="container ">
                <div class="profile d-flex  justify-content-between gap-4">
                    <div class="card bg-transparent">
                        <a href="#" title="link to profile" class="link"></a>
                        <div class="img">
                            <asset:image src="pathways.png" alt="Parcours Logo"/>
                        </div>
                        <div class="card-body">
                            <h3 class="card-title text-white">Parcours</h3>
                            <p class="card-text">
                                Itinéraire qui permet de découvrir des attractions touristiques dans une région ou une ville donnée.
                            </p>
                        </div>
                    </div>
                    <div class="card bg-transparent">
                        <a href="#" title="link to profile" class="link"></a>
                        <div class="img">
                            <asset:image src="pois.png" alt="Pois Logo"/>
                        </div>
                        <div class="card-body">
                            <h3 class="card-title text-white">Points d'intérêt</h3>
                            <p class="card-text">
                                Description d'un lieu avec coordonnées pour la carte.
                            </p>
                        </div>
                    </div>

                    <div class="card bg-transparent">
                        <a href="#" title="link to profile" class="link"></a>
                        <div class="img">
                            <asset:image src="illustrations.png" alt="illustrations Logo"/>
                        </div>
                        <div class="card-body">
                            <h3 class="card-title text-white">Illustrations</h3>
                            <p class="card-text">
                                il s'agit d'une représentation visuelle d'un lieu donné.</p>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</div>

</body>
</html>
