<html>
<head>
    <meta name="layout" content="${gspLayout ?: 'main'}"/>
    <title><g:message code='springSecurity.login.title'/></title>
</head>

<body>
<div id="login">
    <div class="inner">
        <g:if test='${flash.message}'>
            <div class="login_message text-center">${flash.message}</div>
        </g:if>
        <div class="container-fluid p-0">
            <div class="banner position-relative login-form">
                <div class="presentation position-absolute top-0 end-0 bottom-0 start-0 m-auto text-center">
                    <h1 class="fs-30 fw-800"> bienvenue <br/><span class="text-danger">chez nous cher</span> client</h1>
                    <div class="fheader"><g:message code='springSecurity.login.header'/></div>
                    <div class="p-5 shadow-sm border rounded-5 shadow-sm bg-white">
                        <h2 class="text-center mb-4 text-primary  text-uppercase">Login</h2>
                        <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="cssform" autocomplete="off">
                            <div class="mb-3">
                                <input type="text" class="text_ form-control border" name="${usernameParameter ?: 'username'}" id="username" autocapitalize="none" aria-describedby="emailHelp" placeholder="<g:message code='springSecurity.login.username.label'/>">
                            </div>
                            <div class="mb-3">
                                <div style="position: relative;">
                                    <input name="${passwordParameter ?: 'password'}" type="password" class="text_ form-control border" id="password" placeholder="*********">
                                    <i id="passwordToggler" title="toggle password display" onclick="passwordDisplayToggle()" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%);">&#128065;</i>
                                </div>
                            </div>
                            <div class="d-flex align-items-center justify-content-center">
                                <input class="btn btn-lg  bg-primary my-2 text-white px-5" type="submit" id="submit" value="${message(code: 'springSecurity.login.button')}"/>
                            </div>
                            <div class="mt-3">
                                <p class="mb-0  text-center fs-20 text-normal" id="remember_me_holder">
                                    <input type="checkbox" class="chk" name="${rememberMeParameter ?: 'remember-me'}" id="remember_me" <g:if test='${hasCookie}'>checked="checked"</g:if>/>
                                    <label for="remember_me"><g:message code='springSecurity.login.remember.me.label'/></label>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function(event) {
        document.forms['loginForm'].elements['username'].focus();
    });

    function passwordDisplayToggle() {
        var toggleEl = document.getElementById("passwordToggler");
        var eyeIcon = '\u{1F441}';
        var xIcon = '\u{2715}';
        var passEl = document.getElementById("password");

        if (passEl.type === "password") {
            toggleEl.innerHTML = xIcon;
            passEl.type = "text";
        } else {
            toggleEl.innerHTML = eyeIcon;
            passEl.type = "password";
        }
    }
</script>
</body>
</html>