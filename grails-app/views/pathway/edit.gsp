<%@ page import="projet_itu_mbds_22_23.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'pathway.label', default: 'Pathway')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="container-fluid p-0">
    <div class="main-content">
        <div class="presentation top-0 end-0 bottom-0 start-0 m-auto text-center">
            <div class="p-5 shadow-sm border rounded-5 shadow-sm bg-white">
                <section class="row">
                    <a href="#edit-pathway" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
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
                        <g:hasErrors bean="${this.pathway}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${this.pathway}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                            error="${error}"/></li>
                                </g:eachError>
                            </ul>
                        </g:hasErrors>
                        <g:form resource="${this.pathway}" method="PUT" enctype="multipart/form-data">
                            <fieldset class="form">
                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <label for="title" class="d-flex text-start">Titre
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <input type="text" class="form-control border" name="title"
                                               value="${pathway.title}" required=""
                                               maxlength="55" id="title" placeholder="Texte">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <label for="description" class="d-flex text-start">Description
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <input type="text" class="form-control border" name="description"
                                               value="${pathway.description}"
                                               required="" id="description" placeholder="Texte">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <label for="Moderateurs" class="d-flex text-start">Moderateurs
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <g:select name="moderateurs" class="form-control border" optionKey="id"
                                                  multiple="true"
                                                  optionValue="username" from="${projet_itu_mbds_22_23.User.list()}"
                                                  value="${this.pathway.moderateurs}"
                                        />
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
                                        <g:link class="create white-text" action="create" controller="user"
                                                params="['pathway.id': pathway.id]">
                                            <g:message code="default.add.label" args="${['User']}"/>
                                        </g:link>
                                    </button>
                                </div>


                                <div class="mb-3">
                                    <div class="fieldcontain text-start">
                                        <label for="Pois" class="d-flex">Pois</label>
                                        <ul>
                                            <g:each in="${pathway.pois}" var="poi">
                                                <li>
                                                    <a href="/poi/show/${poi.id}">${poi.id} : ${poi.title} - ${poi.description}</a>
                                                </li>
                                            </g:each>
                                        </ul>
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
                                        <g:link class="create white-text" action="create" controller="poi"
                                                params="['pathway.id': pathway.id]">
                                            <g:message code="default.add.label" args="${['Poi']}"/>
                                        </g:link>
                                    </button>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain text-start">
                                        <label for="illustrations" class="d-flex">Illustrations</label>
                                        <g:each in="${pathway.illustrations}" var="illu">
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
                                                params="['pathway.id': pathway.id]">
                                            <g:message code="default.add.label" args="${['Illustration']}"/>
                                        </g:link>
                                    </button>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <label for="author" class="d-flex text-start">Author
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <g:select name="author" class="form-control border" optionKey="id"
                                                  optionValue="username" from="${projet_itu_mbds_22_23.User.list()}"
                                                  value="${this.pathway.author.id}"
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
