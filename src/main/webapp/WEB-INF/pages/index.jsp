<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Prog.kiev.ua</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<body>
<div class="container">
    <h3><img height="50" width="55" src="<c:url value="/static/logo.png"/>"/><a href="/">Contacts List</a></h3>

    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul id="groupList" class="nav navbar-nav">
                    <li><button type="button" id="add_contact" class="btn btn-default navbar-btn">Add Contact</button></li>
                    <li><button type="button" id="add_group" class="btn btn-default navbar-btn">Add Group</button></li>
                    <li><button type="button" id="delete_contact" class="btn btn-default navbar-btn">Delete Contact</button></li>
                    <li><button type="button" id="reset" class="btn btn-default navbar-btn">Reset</button></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Groups <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/">Default</a></li>
                            <c:forEach items="${groups}" var="group">
                                <li><a href="/group/${group.id}">${group.name}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                    <li><button type="button" class="btn btn-default navbar-btn" onclick="window.location.href='/download/csv';">Download CSV</button></li>
                    <li><button type="button" id="upload_csv" class="btn btn-default navbar-btn">Upload CSV</button></li>
                </ul>
                <form class="navbar-form navbar-left" role="search" action="/search" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" name="pattern" placeholder="Search" value="${currentPattern}"/>
                    </div>
                    <button type="submit" class="btn btn-default">Submit</button>
                </form>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->


    </nav>

    <table class="table table-striped">
        <thead>
        <tr>
            <td></td>
            <td><b>Name</b></td>
            <td><b>Surname</b></td>
            <td><b>Phone</b></td>
            <td><b>E-mail</b></td>
            <td><b>Group</b></td>
        </tr>
        </thead>
        <c:forEach items="${contacts}" var="contact">
            <tr>
                <td><input type="checkbox" name="toDelete[]" value="${contact.id}" id="checkbox_${contact.id}"/></td>
                <td>${contact.name}</td>
                <td>${contact.surname}</td>
                <td>${contact.phone}</td>
                <td>${contact.email}</td>
                <c:choose>
                    <c:when test="${contact.group ne null}">
                        <td>${contact.group.name}</td>
                    </c:when>
                    <c:otherwise>
                        <td>Default</td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </c:forEach>
    </table>

    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:if test="${contacts != null and not empty contacts}">
                <c:forEach var="i" begin="1" end="${allPages}">
                    <c:url var="pagingUrl" value="/">
                        <c:param name="page" value="${i - 1}"/>
                        <c:param name="pattern" value="${currentPattern}"/>
                    </c:url>
                    <li><a href="${pagingUrl}"><c:out value="${i}"/></a></li>
                </c:forEach>
            </c:if>
        </ul>
    </nav>
</div>

<script>
    $('.dropdown-toggle').dropdown();

    $('#add_contact').click(function(){
        window.location.href='/contact_add_page';
    });

    $('#add_group').click(function(){
        window.location.href='/group_add_page';
    });

    $('#reset').click(function(){
        window.location.href='/reset';
    });

    $('#upload_csv').click(function(){
        window.location.href='/upload_csv_page';
    });

    $('#delete_contact').click(function(){
        var data = { 'toDelete[]' : []};
        $(":checked").each(function() {
            data['toDelete[]'].push($(this).val());
        });
        $.post("/contact/delete", data, function(data, status) {
            window.location.reload();
        });
    });
</script>
</body>
</html>
