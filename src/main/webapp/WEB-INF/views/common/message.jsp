<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

	<script>
	var text = '${msg}';
	var auth;
	var movePath = '${movePath}';
	alert(text);
	location.href=movePath;
	</script>

</body>
</html>