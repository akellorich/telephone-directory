<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/all.min.css">
    <title>Sign Up Account</title>
</head>
<body>
        <div class="container-fluid col-4 offset-4">
            <div class="card mt-3">
                <div class="card-header">
                    <h6>Sign Up Details</h6>
                </div>
                <div class="card-body">
                    <div id="notifications"></div>
                    <div class="from-group">
                        <div class="row mb-2">
                            <div class="col">
                                <label for="firstname">Firstname</label>
                                <input type="text" name="firstname" id="firstname" class="form-control form-control-sm">
                            </div>
                            <div class="col">
                                <label for="lastname">Lastname</label>
                                <input type="text" name="lastname" id="lastname" class="form-control form-control-sm">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" name="username" id="username" class="form-control form-control-sm">
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select name="gender" id="gender" class="form-control form-control-sm">
                                    <option value="">&lt;Choose One&gt;</option>
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                        </div>
                    </div>
                   
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" name="password" id="password" class="form-control form-control-sm">
                    </div>
                    <div class="form-group">
                        <label for="confirmpassword">Confirm Password</label>
                        <input type="password" name="confirmpassword" id="confirmpassword" class="form-control form-control-sm">
                    </div>
                    <div class="form-group">
                        <label for="mobile">Mobile</label>
                        <input type="number" name="mobile" id="mobile" class="form-control form-control-sm">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" name="email" id="email" class="form-control form-control-sm">
                    </div>

                    <div>
                        <button id="saveuser" class="btn btn-success btn-lg w-100">Register Account</button>
                    </div>
                   
                </div>
            </div>
        </div>
       
</body>
<script src="js/jquery-3.6.0.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/signup.js"></script>
</html>