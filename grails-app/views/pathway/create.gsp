<%@ page import="projet_itu_mbds_22_23.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'pathway.label', default: 'Pathway')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="container-fluid p-0">
    <div class="banner position-relative login-form">
        <div class="presentation position-absolute top-0 end-0 bottom-0 start-0 m-auto text-center">
            <div class="p-5 shadow-sm border rounded-5 shadow-sm bg-white">
                <section class="row">
                    <a href="#create-pathway" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                                    default="Skip to content&hellip;"/></a>
                </section>
                <section class="row">
                    <div id="create-pathway" class="col-12 content scaffold-create" role="main">
                        <h2 class="text-center mb-4 text-primary  text-uppercase"><g:message code="default.create.label" args="[entityName]"/></h2>
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
                        <g:form resource="${this.pathway}" method="POST"  enctype="multipart/form-data">
                            <fieldset class="form">
                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <input type="text" class="form-control border" name="title" value="" required=""
                                               maxlength="55" id="title" placeholder="Title *">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <input type="text" class="form-control border" name="description" value=""
                                               required="" id="description" placeholder="Description *">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain required">
                                        <label for="Moderateurs" class="d-flex text-start">Moderateurs
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <g:select name="moderateurs" class="form-control border" optionKey="id" multiple="true"
                                                  optionValue="username" from="${projet_itu_mbds_22_23.User.list()}"/>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="fieldcontain">
                                        <label for="illustrations" class="d-flex text-start">Illustrations</label>
                                        <input type="file" class="form-control border" accept="image/*" name="illus"
                                               multiple/>
                                    </div>
                                </div>


                            </fieldset>
                            <fieldset class="">
                                <g:submitButton name="create" class="save btn btn-lg  bg-primary my-2 text-white px-5"
                                                value="${message(code: 'default.button.create.label', default: 'Create')}"/>
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
