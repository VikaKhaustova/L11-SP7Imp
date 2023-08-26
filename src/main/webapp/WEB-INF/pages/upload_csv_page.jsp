<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload CSV</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <form role="form" class="form-horizontal" action="/upload_csv" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <h3>Upload CSV</h3>
        </div>
        <div class="form-group">
            <input type="file" class="form-control" name="csvFile" accept=".csv" required>
        </div>
        <div class="form-group">
            <input type="submit" class="btn btn-primary" value="Upload">
        </div>
    </form>
</div>
</body>
</html>
