<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Candidate Login | Student Voting System</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
:root {
	--primary: #1e3c72;
	--secondary: #2a5298;
	--accent: #e74c3c;
	--success: #2ecc71;
	--shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	--gradient: linear-gradient(135deg, #1e3c72, #2a5298);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background: var(--gradient);
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.login-container {
	background: #fff;
	display: flex;
	max-width: 1000px;
	width: 100%;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: var(--shadow);
}

/* LEFT PANEL */
.info-section {
	flex: 1;
	background: var(--gradient);
	color: #fff;
	padding: 50px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.info-section h2 {
	font-size: 2rem;
	margin-bottom: 15px;
}

.info-section p {
	opacity: 0.9;
	line-height: 1.6;
}

.info-list {
	list-style: none;
	margin-top: 30px;
}

.info-list li {
	margin-bottom: 15px;
	display: flex;
	align-items: center;
}

.info-list i {
	margin-right: 10px;
	font-size: 1.2rem;
}

/* RIGHT PANEL */
.form-section {
	flex: 1;
	padding: 50px 40px;
}

.form-header {
	text-align: center;
	margin-bottom: 30px;
}

.form-header h1 {
	color: var(--primary);
	margin-bottom: 10px;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 6px;
	font-weight: 500;
}

.input-with-icon {
	position: relative;
}

.form-control {
	width: 100%;
	padding: 14px 20px 14px 45px;
	border-radius: 10px;
	border: 2px solid #e1e5ee;
	font-size: 1rem;
}

.input-icon {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: #888;
}

.btn-submit {
	width: 100%;
	padding: 15px;
	background: var(--gradient);
	color: #fff;
	border: none;
	border-radius: 10px;
	font-size: 1.1rem;
	font-weight: 600;
	cursor: pointer;
	margin-top: 10px;
}

.btn-submit:hover {
	opacity: 0.9;
}

.register-link {
	margin-top: 20px;
	text-align: center;
}

.register-link a {
	color: var(--secondary);
	font-weight: 600;
	text-decoration: none;
}

.alert {
	background: rgba(231, 76, 60, 0.1);
	color: #c0392b;
	padding: 12px;
	border-radius: 8px;
	margin-bottom: 20px;
	text-align: center;
}

@media ( max-width : 768px) {
	.login-container {
		flex-direction: column;
	}
}
</style>
</head>

<body>

	<div class="login-container">

		<!-- LEFT INFO -->
		<div class="info-section">
			<h2>Candidate Login</h2>
			<p>Access your student candidate dashboard and manage your
				election profile.</p>

			<ul class="info-list">
				<li><i class="fas fa-user-check"></i> Verified Candidate Access</li>
				<li><i class="fas fa-poll"></i> View Voting Status</li>
				<li><i class="fas fa-chart-bar"></i> Live Result Updates</li>
				<li><i class="fas fa-shield-alt"></i> Secure Login</li>
			</ul>
		</div>

		<!-- RIGHT FORM -->
		<div class="form-section">
			<div class="form-header">
				<h1>Candidate Login</h1>
				<p>Student Voting System</p>
			</div>

			<%-- Error message from servlet --%>
			<%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
        %>
			<div class="alert">
				<i class="fas fa-exclamation-circle"></i>
				<%= error %>
			</div>
			<%
            }
        %>

			<form action="candidatelog" method="post">

				<
				<div class="form-group">
					<label>Register Number or Email</label>
					<div class="input-with-icon">
						<input type="text" name="userInput" class="form-control" required>
						<i class="fas fa-user input-icon"></i>
					</div>
				</div>

				<div class="form-group">
					<label>Password</label>
					<div class="input-with-icon">
						<input type="password" name="password" class="form-control"
							required> <i class="fas fa-lock input-icon"></i>
					</div>
				</div>


				<button type="submit" class="btn-submit">
					Login <i class="fas fa-sign-in-alt"></i>
				</button>

				<div class="register-link">
					New candidate? <a href="cadidatereg.jsp">Register here</a>
				</div>

			</form>
		</div>

	</div>

</body>
</html>
