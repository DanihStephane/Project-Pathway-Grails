<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'pathway.label', default: 'Pathway')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="main-content">
    <div role="main">
        <div class="container">
            <section class="row">
                <a href="#list-pathway" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                              default="Skip to content&hellip;"/></a>
            </section>
            <div class="container-fluid p-0 services">
                <div class="card-profile">
                    <div class=" d-flex w-100 card-profile-content">
                        <div class="d-flex profile-items p-5">
                            <div class="d-flex align-items-center">
                                <div class="w-100">
                                    <h2 class="after text-center mb-4 text-primary text-uppercase"><g:message code="default.list.label" args="[entityName]"/></h2>
                                    <div class="d-flex justify-content-end mb-3">
                                        <button type="button" class="btn btn-success">
                                            <span class="svg-icon svg-icon-2">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                                    <rect opacity="0.5" x="11.364" y="20.364" width="16" height="2" rx="1" transform="rotate(-90 11.364 20.364)" fill="white"></rect>
                                                    <rect x="4.36396" y="11.364" width="16" height="2" rx="1" fill="white"></rect>
                                                </svg>
                                            </span>
                                            <g:link class="create white-text" action="create"><g:message code="default.new.label"
                                                                                                         args="[entityName]"/></g:link>
                                        </button>
                                    </div>
                                    <g:if test="${flash.message}">
                                        <div class="message text-center" role="status">${flash.message}</div>
                                    </g:if>
                                    <table class="table table-light table-bordered table-rounded mb-5">
                                        <thead>
                                        <tr>
                                            <th class="sortable"><a href="/pathway/index?sort=title&amp;max=10&amp;order=asc">Title</a>
                                            </th>
                                            <th class="sortable"><a
                                                    href="/pathway/index?sort=description&amp;max=10&amp;order=asc">Description</a></th>

                                            <th class="sortable"><a href="/pathway/index?sort=pois&amp;max=10&amp;order=asc">Pois</a>
                                            </th>
                                            <th class="sortable text-end"><a
                                                    href="/pathway/index?sort=illustrations&amp;max=10&amp;order=asc">Illustrations</a>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${pathwayList}" var="pathway">
                                            <tr class="even">
                                                <td><a href="/pathway/show/${pathway.id}">${pathway.title}</a></td>
                                                <td>${pathway.description}</td>
                                                <td>
                                                    <ul>
                                                        <g:each in="${pathway.pois}" var="poi">
                                                            <li>
                                                                <a href="/poi/show/${poi.id}">${poi.id} : ${poi.title} - ${poi.description}</a>
                                                            </li>
                                                        </g:each>
                                                    </ul>
                                                </td>

                                                <td class="text-end">
                                                    <g:each in="${pathway.illustrations}" var="illu">
                                                        <img src="${grailsApplication.config.config.illustrations.baseUrl + illu.filename}"/>
                                                    </g:each>
                                                </td>

                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                    <g:if test="${pathwayCount > params.int('max')}">
                                        <div class="pagination text-center">
                                            <g:paginate next="Suivant" prev="Précédent" total="${pathwayCount ?: 0}"/>
                                        </div>
                                    </g:if>
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