<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login</title>

        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">

                    <div class="card mt-3">
                        
                        <div class="container text-center mt-3 mb-3">
                                <img src="img/login_form.png" style="max-width: 100px;" class="img-fluid">
                            </div>

                        <div class="card-header custom-bg text-center">
                            <h3>Login here</h3>
                        </div>

                        <div class="card-body">

                            <%@include file="components/message.jsp" %>

                            <form action="LoginServlet" method="post">
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <input name="password" type="password" class="form-control" id="exampleInputPassword1">
                                </div>
                                <a style="text-decoration: none;" href="register.jsp" class="text-center d-block mb-2"> If not registered click here </a>

                                <div class="container text-center">
                                    <button type="submit" class="btn custom-bg">Submit</button>
                                    <button type="reset" class="btn custom-bg">Reset</button>
                                </div>
                            </form>

                        </div>

                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
