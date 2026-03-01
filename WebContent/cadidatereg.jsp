<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Student Candidate Registration</title>

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
	--light: #f4f6f8;
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

.registration-container {
	background: #fff;
	display: flex;
	max-width: 1100px;
	width: 100%;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: var(--shadow);
}

/* LEFT PANEL */
.illustration-section {
	flex: 1;
	background: var(--gradient);
	color: #fff;
	padding: 50px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.illustration-section h2 {
	font-size: 2rem;
	margin-bottom: 15px;
}

.illustration-section p {
	line-height: 1.6;
	opacity: 0.9;
}

.benefits-list {
	margin-top: 30px;
	list-style: none;
}

.benefits-list li {
	margin-bottom: 15px;
	display: flex;
	align-items: center;
}

.benefits-list i {
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

.login-link {
	margin-top: 20px;
	text-align: center;
}

.login-link a {
	color: var(--secondary);
	font-weight: 600;
	text-decoration: none;
}

@media ( max-width : 768px) {
	.registration-container {
		flex-direction: column;
	}
}
</style>
</head>

<body>

	<div class="registration-container">

		<!-- LEFT INFO -->
		<div class="illustration-section">
			<h2>Student Council Elections</h2>
			<p>Register as a candidate and take leadership in shaping your
				campus future.</p>

			<ul class="benefits-list">
				<li><i class="fas fa-user-graduate"></i> Verified Student
					Profile</li>
				<li><i class="fas fa-vote-yea"></i> Secure Online Voting</li>
				<li><i class="fas fa-users"></i> Transparent Election Process</li>
				<li><i class="fas fa-shield-alt"></i> Encrypted Student Data</li>
			</ul>
		</div>

		<!-- FORM -->
		<div class="form-section">
			<div class="form-header">
				<h1>Candidate Registration</h1>
				<p>Student Voting System</p>
			</div>

			<form action="candidatereg" method="post">

				<div class="form-group">
					<label>Student Name</label>
					<div class="input-with-icon">
						<input type="text" name="name" class="form-control" required>
						<i class="fas fa-user input-icon"></i>
					</div>
				</div>

				<div class="form-group">
					<label>Register Number</label>
					<div class="input-with-icon">
						<input type="text" name="regno" class="form-control" required>
						<i class="fas fa-id-card input-icon"></i>
					</div>
				</div>
				<div class="form-group">
					<label>Mobile Number</label>
					<div class="input-with-icon">
						<input type="tel" name="mobile" class="form-control"
							placeholder="Enter 10-digit mobile number" pattern="[0-9]{10}"
							maxlength="10" title="Mobile number must be 10 digits" required>
						<i class="fas fa-phone input-icon"></i>
					</div>
				</div>

				<div class="form-group">
					<label>Email</label>
					<div class="input-with-icon">
						<input type="email" name="email" class="form-control" required>
						<i class="fas fa-envelope input-icon"></i>
					</div>
				</div>

				<div class="form-group">
					<label>Department</label>
					<div class="input-with-icon">
						<select name="department" class="form-control" required>
							<option value="">Select Department</option>
							<option>CSE</option>
							<option>ECE</option>
							<option>EEE</option>
							<option>Mechanical</option>
							<option>Civil</option>
						</select> <i class="fas fa-building input-icon"></i>
					</div>
				</div>
				<div class="form-group">
					<label>Password</label>
					<div class="input-with-icon">
						<input type="password" name="password" class="form-control"
							placeholder="Enter password" minlength="6" required> <i
							class="fas fa-lock input-icon"></i>
					</div>
				</div>

				<div class="form-group">
					<label>Confirm Password</label>
					<div class="input-with-icon">
						<input type="password" name="confirmPassword" class="form-control"
							placeholder="Re-enter password" minlength="6" required> <i
							class="fas fa-lock input-icon"></i>
					</div>
				</div>

				<button type="submit" class="btn-submit">
					Register as Candidate <i class="fas fa-arrow-right"></i>
				</button>

				<div class="login-link">
					Already registered? <a href="candidatelog.jsp">Login</a>
				</div>

			</form>
		</div>

	</div>

</body>
</html>
