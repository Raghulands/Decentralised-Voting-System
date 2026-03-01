<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Apply for Voter ID - Secure Online Voting</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --success: #2ecc71;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
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
            position: relative;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
            z-index: -1;
        }
        
        .back-button-container {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 100;
        }
        
        .btn-back {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 12px 25px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            backdrop-filter: blur(10px);
            cursor: pointer;
            font-size: 0.95rem;
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .application-container {
            display: flex;
            width: 100%;
            max-width: 600px;
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            min-height: 700px;
            margin-top: 40px;
        }
        
        .illustration-section {
            flex: 1;
            background: var(--gradient);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .illustration-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
        }
        
        .illustration-content {
            z-index: 1;
            max-width: 400px;
        }
        
        .illustration-section img {
            max-width: 100%;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        
        .illustration-section h2 {
            font-size: 1.8rem;
            margin-bottom: 15px;
        }
        
        .illustration-section p {
            font-size: 1rem;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 25px;
        }
        
        .benefits-list {
            list-style: none;
            text-align: left;
            margin-top: 20px;
        }
        
        .benefits-list li {
            margin-bottom: 15px;
            display: flex;
            align-items: flex-start;
        }
        
        .benefits-list i {
            color: var(--light);
            margin-right: 10px;
            margin-top: 3px;
        }
        
        .form-section {
            flex: 1;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-header h1 {
            color: var(--primary);
            font-size: 2.2rem;
            margin-bottom: 10px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .form-header h1:after {
            content: '';
            position: absolute;
            width: 70px;
            height: 4px;
            background: var(--secondary);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }
        
        .form-header p {
            color: #666;
            font-size: 1rem;
        }
        
        .alert {
            padding: 12px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 500;
        }
        
        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            border-left: 4px solid var(--accent);
            color: #c0392b;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-weight: 500;
            font-size: 0.95rem;
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .form-control {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5ee;
            border-radius: 10px;
            font-size: 1rem;
            transition: var(--transition);
            background: white;
            color: var(--dark);
        }
        
        .readonly-field {
            background-color: #f8f9fa;
            color: #6c757d;
            border-color: #e1e5ee;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        .error-message {
            color: var(--accent);
            font-size: 0.85rem;
            margin-top: 5px;
            display: none;
        }
        
        .file-upload-container {
            border: 2px dashed #e1e5ee;
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            transition: var(--transition);
            cursor: pointer;
            position: relative;
        }
        
        .file-upload-container:hover {
            border-color: var(--secondary);
            background: rgba(52, 152, 219, 0.05);
        }
        
        .file-upload-container.dragover {
            border-color: var(--success);
            background: rgba(46, 204, 113, 0.1);
        }
        
        .file-upload-icon {
            font-size: 2.5rem;
            color: var(--secondary);
            margin-bottom: 15px;
        }
        
        .file-upload-text h4 {
            color: var(--primary);
            margin-bottom: 8px;
        }
        
        .file-upload-text p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .file-input {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        
        #output_image {
            width: 100%;
            max-height: 200px;
            object-fit: contain;
            display: none;
            margin-top: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #e1e5ee;
        }
        
        .btn-submit {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 16px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 10px;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            width: 100%;
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.6);
        }
        
        .btn-submit i {
            margin-left: 10px;
            transition: var(--transition);
        }
        
        .btn-submit:hover i {
            transform: translateX(5px);
        }
        
        .progress-bar {
            height: 6px;
            background: #e1e5ee;
            border-radius: 3px;
            margin-top: 10px;
            overflow: hidden;
            display: none;
        }
        
        .progress-fill {
            height: 100%;
            background: var(--success);
            width: 0%;
            transition: width 0.3s ease;
        }
        
       
        @media (max-width: 768px) {
            .application-container {
                flex-direction: column;
                margin-top: 60px;
            }
            
            .back-button-container {
                top: 10px;
                left: 10px;
            }
            
            .btn-back {
                padding: 10px 20px;
                font-size: 0.9rem;
            }
            
            .illustration-section {
                padding: 30px 20px;
            }
            
            .illustration-section img {
                max-width: 200px;
            }
            
            .form-section {
                padding: 40px 30px;
            }
            
            .form-header h1 {
                font-size: 1.8rem;
            }
        }
        
        @media (max-width: 480px) {
            .back-button-container {
                position: relative;
                top: 0;
                left: 0;
                margin-bottom: 20px;
                text-align: center;
            }
            
            .application-container {
                margin-top: 20px;
            }
            
            body {
                padding: 10px;
            }
        }
    </style>
</head>

<%
    String name = session.getAttribute("studentName").toString(); 
    String email = session.getAttribute("studentEmail").toString();
    String scourse = session.getAttribute("studentcourse").toString();
    String ssub = session.getAttribute("studentsubject").toString();
%>

<body>
  
    <div class="back-button-container">
       <a href="votermain.jsp" class="btn-back">
    <i class="fas fa-arrow-left"></i>
    Go Back
</a>

    </div>
    
    <div class="application-container">
        <div class="form-section">
            <div class="form-header">
                <h1>Voter ID Application</h1>
                <p>Fill in your details to complete the registration process</p>
            </div>
            
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <form method="post" action="voterapply" enctype="multipart/form-data" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="district">Voter District</label>
                    <input type="text" class="form-control readonly-field" id="district" value="<%= name %>" name="name" readonly>
                </div>


                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" class="form-control" id="email" value="<%= email %>" name="email" required>
                </div>
                
                   <div class="form-group">
                    <label for="assembly">  Student course</label>
                    <input type="text" class="form-control readonly-field" id="assembly" value="<%= scourse %>" name="course" readonly>
                </div>
                <div class="form-group">
                    <label for="mobile">Student sub </label>
                    <div class="input-with-icon">
                        <input type="text" class="form-control" id="mobile" name="sub" value="<%= ssub %>" placeholder="Enter sub">
                    </div>
                </div>

                <div class="form-group">
                    <label>Upload Voter ID Photo</label>
                    <div class="file-upload-container" id="fileUploadContainer">
                        <div class="file-upload-icon">
                            <i class="fas fa-cloud-upload-alt"></i>
                        </div>
                        <div class="file-upload-text">
                            <h4>Upload Your Photo</h4>
                            <p>JPG, PNG files only Max size 1MB</p>
                            <span class="btn btn-secondary" style="padding: 8px 20px; background: var(--secondary); color: white; border-radius: 5px;">Choose File</span>
                        </div>
                        <input type="file" class="file-input" name="file" accept="image/*" onchange="previewImage(event)" required>
                    </div>
                    <div class="progress-bar" id="progressBar">
                        <div class="progress-fill" id="progressFill"></div>
                    </div>
                    <img id="output_image" />
                </div>

                <button type="submit" class="btn-submit">
                    Submit Application
                    <i class="fas fa-paper-plane"></i>
                </button>
            </form>
        </div>
    </div>

    <script>
       
        function goBack() {
            window.history.back();
        }
        function previewImage(event) {
            var file = event.target.files[0];
            if (!file) return;
            
            
            var progressBar = document.getElementById('progressBar');
            var progressFill = document.getElementById('progressFill');
            progressBar.style.display = 'block';
            
            
            var progress = 0;
            var interval = setInterval(function() {
                progress += 10;
                progressFill.style.width = progress + '%';
                
                if (progress >= 100) {
                    clearInterval(interval);
                    progressBar.style.display = 'none';
                    
                    var reader = new FileReader();
                    reader.onload = function () {
                        var output = document.getElementById('output_image');
                        output.src = reader.result;
                        output.style.display = "block";
                        
                       
                        var container = document.getElementById('fileUploadContainer');
                        container.innerHTML = '<i class="fas fa-check-circle" style="color: var(--success); font-size: 2.5rem; margin-bottom: 15px;"></i><h4 style="color: var(--success);">Photo Uploaded Successfully</h4><p>Click to change photo</p>';
                        container.appendChild(event.target.cloneNode(true));
                        container.querySelector('input[type="file"]').addEventListener('change', previewImage);
                    }
                    reader.readAsDataURL(file);
                }
            }, 50);
        }

        
        const fileUploadContainer = document.getElementById('fileUploadContainer');
        const fileInput = fileUploadContainer.querySelector('input[type="file"]');
        
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            fileUploadContainer.addEventListener(eventName, preventDefaults, false);
        });
        
        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }
        
        ['dragenter', 'dragover'].forEach(eventName => {
            fileUploadContainer.addEventListener(eventName, highlight, false);
        });
        
        ['dragleave', 'drop'].forEach(eventName => {
            fileUploadContainer.addEventListener(eventName, unhighlight, false);
        });
        
        function highlight() {
            fileUploadContainer.classList.add('dragover');
        }
        
        function unhighlight() {
            fileUploadContainer.classList.remove('dragover');
        }
        
        fileUploadContainer.addEventListener('drop', handleDrop, false);
        
        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;
            fileInput.files = files;
            previewImage({ target: fileInput });
        }

        
        function validateForm() {
           
            var fileInput = document.querySelector('input[type="file"]');

            if (!fileInput.files || fileInput.files.length === 0) {
                alert("Please upload your photo.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>