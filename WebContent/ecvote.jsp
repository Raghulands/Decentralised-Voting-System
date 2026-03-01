<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Assembly - Election Commission</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e3c72;
            --secondary: #2a5298;
            --accent: #4fc3f7;
            --success: #4caf50;
            --light: #e3f2fd;
            --dark: #0d47a1;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            min-height: 100vh;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .main-container {
            max-width: 600px;
            width: 100%;
            margin: 0 auto;
        }
        
        .header-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeInDown 0.8s ease-out;
            text-align: center;
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(45deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .form-container {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .form-title i {
            color: var(--accent);
        }
        
        .form-description {
            opacity: 0.8;
            font-size: 0.95rem;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .form-input {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 15px 20px;
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        
        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(79, 195, 247, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1.1rem;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: space-between;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .btn-submit {
            background: linear-gradient(45deg, var(--accent), #29b6f6);
            border: none;
            padding: 15px 30px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(41, 182, 246, 0.4);
            cursor: pointer;
            flex: 1;
            justify-content: center;
            min-width: 150px;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(41, 182, 246, 0.6);
        }
        
        .btn-back {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 15px 30px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            flex: 1;
            justify-content: center;
            min-width: 150px;
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            color: white;
        }
        
        .info-section {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 20px;
            margin-top: 25px;
            border-left: 4px solid var(--accent);
        }
        
        .info-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .info-title i {
            color: var(--accent);
        }
        
        .info-content {
            font-size: 0.9rem;
            opacity: 0.8;
            line-height: 1.5;
        }
        
       
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
       
        @media (max-width: 768px) {
            .main-container {
                max-width: 100%;
                padding: 10px;
            }
            
            .header-section {
                padding: 25px 20px;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .form-container {
                padding: 30px 25px;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .btn-submit, .btn-back {
                width: 100%;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .page-title {
                font-size: 1.8rem;
            }
            
            .form-container {
                padding: 25px 20px;
            }
            
            .form-title {
                font-size: 1.3rem;
            }
        }
    </style>
</head>

<body>
    <div class="main-container">
        
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-landmark"></i>
                Assembly Entry
            </h1>
            <p class="page-subtitle">Enter assembly details to view constituency information</p>
        </div>

       
        <div class="form-container">
            <div class="form-header">
                <h2 class="form-title">
                    <i class="fas fa-edit"></i>
                    Assembly Information
                </h2>
                <p class="form-description">Please enter the assembly ward name to proceed</p>
            </div>

            <form action="eccount.jsp" method="post">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-map-marker-alt"></i>
                        Assembly Ward Name
                    </label>
                    <div class="input-with-icon">
                        <input type="text" 
                               class="form-input" 
                               placeholder="Enter assembly ward name" 
                               name="ass" 
                               required
                               autocomplete="off">
                        <i class="fas fa-building input-icon"></i>
                    </div>
                </div>

                <div class="info-section">
                    <h4 class="info-title">
                        <i class="fas fa-info-circle"></i>
                        Important Information
                    </h4>
                    <p class="info-content">
                        Enter the exact assembly ward name as registered in the system. 
                        This will help retrieve accurate constituency data and voting statistics.
                    </p>
                </div>

                <div class="form-actions">
                    <a href="ecmain.jsp" class="btn-back">
                        <i class="fas fa-arrow-left"></i>
                        Back
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-search"></i>
                        Search Assembly
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
       
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
        
       
        document.querySelector('form').addEventListener('submit', function(e) {
            const assemblyInput = document.querySelector('input[name="ass"]');
            if (!assemblyInput.value.trim()) {
                e.preventDefault();
                assemblyInput.focus();
                assemblyInput.style.borderColor = 'var(--accent)';
                return false;
            }
        });
        
       
        const assemblyInput = document.querySelector('input[name="ass"]');
        assemblyInput.addEventListener('focus', function() {
            this.style.borderColor = 'var(--accent)';
            this.style.boxShadow = '0 0 0 3px rgba(79, 195, 247, 0.3)';
        });
        
        assemblyInput.addEventListener('blur', function() {
            this.style.boxShadow = 'none';
        });
    </script>
</body>
</html>