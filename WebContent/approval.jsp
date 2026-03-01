<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Symbols - Election Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --success: #2ecc71;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            color: #333;
            min-height: 100vh;
            padding: 20px;
        }
        
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .page-title {
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
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
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        .content-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 30px;
        }
        
        .card-title {
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 25px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .card-title i {
            color: var(--secondary);
        }
        
        .candidate-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border: none;
        }
        
        .candidate-table thead {
            background: linear-gradient(45deg, var(--primary), var(--secondary));
        }
        
        .candidate-table th {
            color: white;
            padding: 20px 15px;
            text-align: center;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .candidate-table td {
            padding: 20px 15px;
            border-bottom: 1px solid #e1e5ee;
            vertical-align: middle;
            text-align: center;
            border: none;
            font-weight: 500;
            color: var(--dark);
        }
        
        .candidate-table tbody tr {
            transition: var(--transition);
            background: white;
        }
        
        .candidate-table tbody tr:hover {
            background: rgba(52, 152, 219, 0.08);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .image-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px;
        }
        
        .candidate-image {
            width: 100px;
            height: 80px;
            border-radius: 12px;
            object-fit: cover;
            border: 3px solid #e1e5ee;
            transition: var(--transition);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .candidate-image:hover {
            transform: scale(1.05);
            border-color: var(--secondary);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .symbol-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #e1e5ee;
            transition: var(--transition);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background: white;
            padding: 5px;
        }
        
        .symbol-image:hover {
            transform: scale(1.08);
            border-color: var(--success);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .no-image {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #95a5a6;
            padding: 15px;
        }
        
        .no-image i {
            font-size: 2rem;
            margin-bottom: 8px;
            opacity: 0.6;
        }
        
        .no-image p {
            font-size: 0.85rem;
            margin: 0;
        }
        
        .district-badge, .assembly-badge {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
            display: inline-block;
        }
        
        .assembly-badge {
            background: linear-gradient(45deg, #9b59b6, #8e44ad);
        }
        
        .candidate-name {
            font-weight: 600;
            color: var(--primary);
            font-size: 1.1rem;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.4;
        }
        
        .empty-state h4 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--primary);
        }
        
        .empty-state p {
            font-size: 1rem;
            max-width: 500px;
            margin: 0 auto;
        }
        
        .stats-bar {
            display: flex;
            justify-content: space-around;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--secondary);
            display: block;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: var(--primary);
            font-weight: 500;
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
        
        .content-card {
            animation: fadeInUp 0.8s ease-out;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                text-align: center;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .candidate-table {
                display: block;
                overflow-x: auto;
            }
            
            .stats-bar {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Header Section -->
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-flag"></i>
                Candidate Symbol
            </h1>
            <a href="candidatemain.jsp" class="btn-back">
    <i class="fas fa-arrow-left"></i>
    Go Back
</a>

        </div>

        
      
        <div class="content-card">
            <h2 class="card-title">
                <i class="fas fa-list-alt"></i>
                Candidate Information & Symbols
            </h2>
            
            <div class="table-responsive">
                <table class="candidate-table">
                    <thead>
                        <tr>
                            <th>Candidate Name</th>
                            <th>Candidate Reg no</th>
                            <th>Department </th>
                            <th>Email</th>
                            <th>Election Symbol</th>
                        </tr>
                    </thead>
                   <tbody>
<%
    // Import needed classes
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
String name=session.getAttribute("candidateEmail").toString(); 

    try {
        // Get database connection
        con = dbconn.create();

        // Use a parameterized query to prevent SQL injection
        String sql = "SELECT * FROM `studentvoute`.`eligible` WHERE email = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, name); // 'name' should be obtained safely, e.g., from session or request
        
        rs = ps.executeQuery();

        int count = 0;

        while (rs.next()) {
            count++;
            byte[] blobpic = rs.getBytes("image"); // replace 'photo_column' with your actual column name
            byte[] blobsymbol = rs.getBytes("symbol"); // replace 'symbol_column' with your actual column name
%>
<tr>
    <!-- Candidate Photo -->
    <td>
        <div class="image-container">
            <%
                if (blobpic != null) {
                    String base64Image = Base64.getEncoder().encodeToString(blobpic);
            %>
                <img src="data:image/jpeg;base64,<%= base64Image %>" 
                     class="candidate-image" 
                     alt="Candidate Photo">
            <%
                } else {
            %>
                <div class="no-image">
                    <i class="fas fa-user-slash"></i>
                    <p>No Image</p>
                </div>
            <%
                }
            %>
        </div>
    </td>

    <!-- District -->
    <td>
        <span class="district-badge">
            <i class="fas fa-map-marker-alt"></i>
            <%= rs.getString("rollno") %> <!-- replace with actual column -->
        </span>
    </td>

    <!-- Assembly -->
    <td>
        <span class="assembly-badge">
            <i class="fas fa-landmark"></i>
            <%= rs.getString("department") %> <!-- replace with actual column -->
        </span>
    </td>

    <!-- Candidate Name -->
    <td>
        <span class="candidate-name">
            <i class="fas fa-user-tie"></i>
            <%= rs.getString("email") %> <!-- replace with actual column -->
        </span>
    </td>

    <!-- Election Symbol -->
    <td>
        <div class="image-container">
            <%
                if (blobsymbol != null) {
                    String base64Image = Base64.getEncoder().encodeToString(blobsymbol);
            %>
                <img src="data:image/jpeg;base64,<%= base64Image %>" 
                     class="symbol-image pulse" 
                     alt="Election Symbol">
            <%
                } else {
            %>
                <div class="no-image">
                    <i class="fas fa-flag"></i>
                    <p>No Symbol</p>
                </div>
            <%
                }
            %>
        </div>
    </td>
</tr>
<%
        }

        // If no rows found
        if (count == 0) {
%>
<tr>
    <td colspan="5">
        <div class="empty-state">
            <i class="fas fa-inbox"></i>
            <h4>No Candidate Data Available</h4>
            <p>There is no candidate information to display at the moment.</p>
        </div>
    </td>
</tr>
<%
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close resources
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
</tbody>

                </table>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        
        
       
        function goBack() {
            window.history.back();
        }
        
        
        $(document).ready(function() {
            $('.candidate-table tbody tr').each(function(i) {
                $(this).delay(i * 100).animate({opacity: 1}, 300);
            });
            
            
            $('.candidate-image, .symbol-image').hover(
                function() {
                    $(this).css('transform', 'scale(1.05)');
                },
                function() {
                    $(this).css('transform', 'scale(1)');
                }
            );
        });
        
       
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
    </script>
</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="dbcon.dbconn"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Base64"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Candidate Symbols - Election Portal</title>

    <!-- UI CSS (UNCHANGED) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <!-- YOUR EXISTING STYLE (NOT TOUCHED) -->
    <style>
        /* FULL UI STYLE SAME AS YOUR CODE */
        / <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --success: #2ecc71;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            color: #333;
            min-height: 100vh;
            padding: 20px;
        }
        
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .page-title {
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
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
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        .content-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 30px;
        }
        
        .card-title {
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 25px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .card-title i {
            color: var(--secondary);
        }
        
        .candidate-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border: none;
        }
        
        .candidate-table thead {
            background: linear-gradient(45deg, var(--primary), var(--secondary));
        }
        
        .candidate-table th {
            color: white;
            padding: 20px 15px;
            text-align: center;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .candidate-table td {
            padding: 20px 15px;
            border-bottom: 1px solid #e1e5ee;
            vertical-align: middle;
            text-align: center;
            border: none;
            font-weight: 500;
            color: var(--dark);
        }
        
        .candidate-table tbody tr {
            transition: var(--transition);
            background: white;
        }
        
        .candidate-table tbody tr:hover {
            background: rgba(52, 152, 219, 0.08);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .image-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px;
        }
        
        .candidate-image {
            width: 100px;
            height: 80px;
            border-radius: 12px;
            object-fit: cover;
            border: 3px solid #e1e5ee;
            transition: var(--transition);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .candidate-image:hover {
            transform: scale(1.05);
            border-color: var(--secondary);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .symbol-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #e1e5ee;
            transition: var(--transition);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background: white;
            padding: 5px;
        }
        
        .symbol-image:hover {
            transform: scale(1.08);
            border-color: var(--success);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .no-image {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #95a5a6;
            padding: 15px;
        }
        
        .no-image i {
            font-size: 2rem;
            margin-bottom: 8px;
            opacity: 0.6;
        }
        
        .no-image p {
            font-size: 0.85rem;
            margin: 0;
        }
        
        .district-badge, .assembly-badge {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
            display: inline-block;
        }
        
        .assembly-badge {
            background: linear-gradient(45deg, #9b59b6, #8e44ad);
        }
        
        .candidate-name {
            font-weight: 600;
            color: var(--primary);
            font-size: 1.1rem;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.4;
        }
        
        .empty-state h4 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--primary);
        }
        
        .empty-state p {
            font-size: 1rem;
            max-width: 500px;
            margin: 0 auto;
        }
        
        .stats-bar {
            display: flex;
            justify-content: space-around;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--secondary);
            display: block;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: var(--primary);
            font-weight: 500;
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
        
        .content-card {
            animation: fadeInUp 0.8s ease-out;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                text-align: center;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .candidate-table {
                display: block;
                overflow-x: auto;
            }
            
            .stats-bar {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>

<body>
<div class="main-container">

    <!-- Header -->
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-flag"></i>
            Candidate Symbol
        </h1>
        <a href="candidatemain.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i>
            Go Back
        </a>
    </div>

    <div class="content-card">
        <h2 class="card-title">
            <i class="fas fa-list-alt"></i>
            Candidate Information & Symbols
        </h2>

        <div class="table-responsive">
            <table class="candidate-table">
                <thead>
                    <tr>
                        <th>Candidate Name</th>
                        <th>Candidate Reg no</th>
                        <th>Department</th>
                        <th>Email</th>
                        <th>Election Symbol</th>
                    </tr>
                </thead>

                <tbody>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String email = session.getAttribute("candidateEmail").toString();
    String name= session.getAttribute("candidateName").toString();
    if (email == null) {
%>
        <tr>
            <td colspan="5">
                <div class="empty-state">
                    <h4>Session Expired</h4>
                    <p>Please login again.</p>
                </div>
            </td>
        </tr>
<%
    } else {
        try {
            con = dbconn.create();
            String sql = "SELECT * FROM eligible WHERE email=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();

            boolean found = false;

            while (rs.next()) {
                found = true;

                byte[] photo = rs.getBytes("image");
                byte[] symbol = rs.getBytes("symbol");
%>
<tr>
    <!-- Candidate Name -->
    <td class="candidate-name">
        <%= name %>
    </td>

    <!-- Reg No -->
    <td>
        <span class="district-badge">
            <%= rs.getString("rollno") %>
        </span>
    </td>

    <!-- Department -->
    <td>
        <span class="assembly-badge">
            <%= rs.getString("department") %>
        </span>
    </td>

    <!-- Email -->
    <td>
        <%= rs.getString("email") %>
    </td>

    <!-- Symbol -->
    <td>
        <div class="image-container">
            <%
                if (symbol != null) {
                    String symImg = Base64.getEncoder().encodeToString(symbol);
            %>
                <img src="data:image/jpeg;base64,<%= symImg %>"
                     class="symbol-image pulse">
            <%
                } else {
            %>
                <div class="no-image">
                    <i class="fas fa-flag"></i>
                    <p>No Symbol</p>
                </div>
            <%
                }
            %>
        </div>
    </td>
</tr>
<%
            }

            if (!found) {
%>
<tr>
    <td colspan="5">
        <div class="empty-state">
            <i class="fas fa-database"></i>
            <h4>No Data Found</h4>
            <p>No approved candidate details available.</p>
        </div>
    </td>
</tr>
<%
            }

        } catch (Exception e) {
%>
<tr>
    <td colspan="5" style="color:red;text-align:center;">
        Error: <%= e.getMessage() %>
    </td>
</tr>
<%
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
%>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
