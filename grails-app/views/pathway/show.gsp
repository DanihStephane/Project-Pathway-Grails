<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pathway.label', default: 'Pathway')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div class="main-content">
        <div role="main">
            <div class="container">
                <section class="row">
                    <a href="#list-poi" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                              default="Skip to content&hellip;"/></a>
                </section>
                <div class="container-fluid p-0 services">
                    <div class="card-profile">
                        <div class=" d-flex w-100 card-profile-content">
                            <div class="d-flex profile-items p-5">
                                <div class="d-flex align-items-center">
                                    <div class="w-100">
                                        <h2 class="after text-center mb-4 text-primary text-uppercase"><g:message code="default.show.label" args="[entityName]" /></h2>
                                        <div class="d-flex justify-content-end mb-3">
                                            <button type="button" class="btn btn-success">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                                        <rect opacity="0.5" x="11.364" y="20.364" width="16" height="2" rx="1" transform="rotate(-90 11.364 20.364)" fill="white"></rect>
                                                        <rect x="4.36396" y="11.364" width="16" height="2" rx="1" fill="white"></rect>
                                                    </svg>
                                                </span>
                                                <g:link class="create white-text" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                                            </button>
                                        </div>
                                        <g:if test="${flash.message}">
                                            <div class="message text-center" role="status">${flash.message}</div>
                                        </g:if>
                                        <table class="table table-light table-bordered table-rounded mb-5">
                                            <thead>
                                            <tr>

                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <th class="text-end">
                                                    <span id="title-label" class="property-label">Title</span>
                                                </th>
                                                <td>
                                                    <div class="property-value" aria-labelledby="title-label">${pathway.title}</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="text-end">
                                                    <span id="description-label" class="property-label">Description</span>
                                                </th>
                                                <td>
                                                    <div class="property-value" aria-labelledby="description-label">${pathway.description}</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="text-end">
                                                    <span id="moderateurs-label" class="property-label">Moderateurs</span>
                                                </th>
                                                <td>
                                                    <div class="property-value" aria-labelledby="moderateurs-label">
                                                        <ul>
                                                            <g:each in="${pathway.moderateurs}" var="moderateur">
                                                                <li>
                                                                    ${moderateur.username}
                                                                </li>
                                                            </g:each>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="text-end">
                                                    <span id="pois-label" class="property-label">Pois</span>
                                                </th>
                                                <td>
                                                    <div class="property-value" aria-labelledby="pois-label">
                                                        <ul>
                                                            <g:each in="${pathway.pois}" var="poi">
                                                                <li>
                                                                    <a href="/poi/show/${poi.id}">${poi.id} : ${poi.title} - ${poi.description}</a>
                                                                </li>
                                                            </g:each>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="text-end">
                                                    <span id="illustrations-label" class="property-label">Illustrations</span>
                                                </th>
                                                <td>
                                                    <div class="property-value" aria-labelledby="illustrations-label">
                                                        <g:each in="${pathway.illustrations}" var="illu">
                                                            <img src="${grailsApplication.config.config.illustrations.baseUrl+illu.filename}" />
                                                        </g:each>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="text-end">
                                                    <span id="author-label" class="property-label">Author</span>
                                                </th>
                                                <td>
                                                    <div class="property-value" aria-labelledby="author-label">${pathway.author.username}</div>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                        <g:form resource="${this.pathway}" method="DELETE">
                                            <fieldset class="buttons text-center">
                                                <g:link class="save btn btn-lg  bg-primary my-2 text-white px-5" action="edit" resource="${this.pathway}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                                                <input class="save btn btn-lg  bg-primary my-2 text-white px-5" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                            </fieldset>
                                        </g:form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
