<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'poi.label', default: 'Poi')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="container-fluid p-0">
    <div class="main-content">
        <div class="presentation top-0 end-0 bottom-0 start-0 m-auto text-center">
            <div class="p-5 shadow-sm border rounded-5 shadow-sm bg-white">
                <section class="row">
                    <a href="#edit-poi" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                              default="Skip to content&hellip;"/></a>
                </section>

                <div class="d-flex justify-content-end mb-3">
                    <button type="button" class="btn btn-success">
                        <span class="svg-icon svg-icon-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none">
                                <rect opacity="0.5" x="11.364" y="20.364" width="16" height="2" rx="1"
                                      transform="rotate(-90 11.364 20.364)" fill="white"></rect>
                                <rect x="4.36396" y="11.364" width="16" height="2" rx="1" fill="white"></rect>
                            </svg>
                        </span>
                        <g:link class="create white-text" action="create"><g:message code="default.new.label"
                                                                                     args="[entityName]"/></g:link>
                    </button>
                </div>

                <section class="row">
                    <div id="create-pathway" class="col-12 content scaffold-create" role="main">
                        <h2 class="text-center mb-4 text-primary  text-uppercase"><g:message code="default.edit.label"
                                                                                             args="[entityName]"/></h2>

                        <g:if test="${flash.message}">
                            <div class="message text-center" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${this.poi}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${this.poi}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                            error="${error}"/></li>
                                </g:eachError>
                            </ul>
                        </g:hasErrors>
                        <g:form resource="${this.poi}" method="PUT" enctype="multipart/form-data" class="cssform" autocomplete="off">
                            <g:hiddenField name="version" value="${this.poi?.version}" />
                            <fieldset class="form">
                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <label for="title" class="d-flex text-start">Titre
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <input type="text" class="form-control border" name="title" value="${this.poi.title}" required="" maxlength="55" id="title" placeholder="Texte">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <label for="description" class="d-flex text-start">Description
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <input type="text" class="form-control border" name="description" value="${this.poi.description}" required="" id="description" placeholder="Texte">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain">
                                        <label for="lat" class="d-flex text-start">Lat</label>
                                        <input type="number" class="form-control border" name="lat" value="${this.poi.lat}" id="lat" placeholder="Chiffre numérique">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain">
                                        <label for="lng" class="d-flex text-start">Lng</label>
                                        <input type="number" class="form-control border" name="lng" value="${this.poi.lng}" id="lng" placeholder="Chiffre numérique">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain">
                                        <label for="illustrations" class="d-flex text-start">Illustrations</label>
                                        <g:each in="${poi.illustrations}" var="illu">
                                            <img src="${grailsApplication.config.config.illustrations.baseUrl+illu.filename}" />
                                        </g:each>
                                        <input type="file" class="form-control border" accept="image/*" name="illus" multiple/>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end mb-3">
                                    <button type="button" class="btn btn-success">
                                        <span class="svg-icon svg-icon-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none">
                                                <rect opacity="0.5" x="11.364" y="20.364" width="16" height="2" rx="1"
                                                      transform="rotate(-90 11.364 20.364)" fill="white"></rect>
                                                <rect x="4.36396" y="11.364" width="16" height="2" rx="1"
                                                      fill="white"></rect>
                                            </svg>
                                        </span>
                                        <g:link class="create white-text" action="create" controller="illustration"
                                                params="['poi.id': poi.id]">
                                            <g:message code="default.add.label" args="${['Illustration']}"/>
                                        </g:link>
                                    </button>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <label for="pathway" class="d-flex text-start">Pathway
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <g:select name="pathway.id" class="form-control border" optionKey="id" optionValue="title" from="${projet_itu_mbds_22_23.Pathway.list()}"
                                                  value="${this.poi.pathwayId}"
                                        />
                                    </div>
                                </div>

                            </fieldset>


                            <fieldset class="">
                                <g:submitButton name="update" class="save btn btn-lg  bg-primary my-2 text-white px-5"
                                                value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                            </fieldset>
                        </g:form>
                    </div>
                </section>
            </div>
        </div>
    </div>
</div>
</body>
</html>
