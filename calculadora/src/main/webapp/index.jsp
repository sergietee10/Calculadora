<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Formulario</title>
</head>
<body>
	<div class="row" style="margin-top: 100px">
		<div class="col-md-4"></div>
		<div class="col-md-4"
			style="border: 2px solid black; border-radius: 16px 16px 16px 16px">
			<h1 style="text-align: center">Tabla de Multiplicar</h1>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<form id="formulario">
						<div class="form-group">
							<label for="num1">1º Núm.</label><input type="text"
								class="form-control" name="num1" id="num1">
							<div id="mnum1" style="text-align: center"></div>
						</div>
						<div class="form-group">
							<label for="num2">2º Núm.</label><input type="text"
								class="form-control" name="num2" id="num2">
							<div id="mnum2" style="text-align: center"></div>
						</div>
						<div class="form-group">
							<label for="operadorO">Operación</label> <select
								class="form-control" id="operador">
								<option>Selecciona una Operación</option>
								<option value="suma">Suma</option>
								<option value="resta">Resta</option>
								<option value="multiplicacion">Multiplicación</option>
								<option value="division">División</option>
							</select>
						</div>
						<div class="form-group" style="text-align: right">
							<button id="enviar" type="button"
								class="btn btn-primary btn-responsive btninter" disabled="true">Enviar</button>
							<button id="limpiar"
								class="btn btn-warning btn-responsive btninter right"
								type="reset">Limpiar</button>
							<div id="malert" style="text-align: center"></div>
						</div>
						<div class="form-group">
							<label for="resultado">Resultado</label> <input type="text"
								class="form-control" id="resul" placeholder="Resultado"
								disabled="true">
						</div>
					</form>
				</div>
				<div class="col-md-3"></div>
			</div>
		</div>
		<div class="col-md-4"></div>
	</div>

	<script>
		$(document).ready(function() {

							function isNormalInteger(str) {
								return /^-?[0-9]+([.][0-9]+)?$/.test(str);
							}

							$("#num1").keyup(function() {
												if ((isNormalInteger($("#num1").val()))) {
													$("#mnum1").attr("class","alert alert-success");
													$("#num1").css("border-color","green");
													$("#mnum1").empty().append("Success");

													if ((isNormalInteger($("#num2").val()))) {
														$("#enviar").attr("disabled",false);
													}
												} else {
													$("#mnum1").attr("class","alert alert-danger");
													$("#mnum1").empty().append("Introduzca números enteros o decimales con '.' .");
													$("#num1").css("border-color","red");
													$("#enviar").attr("disabled", true);
												}
											});

							$("#num2").keyup(function() {
												if ((isNormalInteger($("#num2").val()))) {
													$("#mnum2").attr("class","alert alert-success");
													$("#num2").css("border-color","green");
													$("#mnum2").empty().append("Success");
													if ((isNormalInteger($("#num1").val()))) {
														$("#enviar").attr("disabled",false);
													}
												} else {
													$("#mnum2").attr("class","alert alert-danger");
													$("#mnum2").empty().append("Introduzca números enteros o decimales con '.' .");
													$("#num2").css("border-color","red");
													$("#enviar").attr("disabled", true);
												}
											});

							$("#enviar").click(function() {
												var num2 = $("#num2").val();
												var num1 = $("#num1").val();
												var operador = $("#operador").val();

												$.ajax({
															url : "calculadora?num1="	+ num1	+ "&num2=" + num2 + "&operador=" + operador,
															cache : false,
															method : "GET",
															dataType : "json",
															success : function(data) {

																$("#resul").attr("value", (data));
															},
															error : function(error) {
																$("#malert").attr("class","alert alert-danger");
																$("#malert").empty().append("<h4>Error<h4>");
																$("#resul").empty().append("<h5 class=\"alert alert-danger\">" + error.status + ": " + error.responseText + "</h5>");
															}

														});
											});
							$("#limpiar").click(function() {
								
								$("#num1").val("");
								$("#num2").val("");
								$("#mnum1").attr("class", "");
								$("#mnum2").attr("class", "");
								$("#malert").attr("class", "");
								$("#mnum1").empty();
								$("#mnum2").empty();
								$("#malert").empty();
								$("#num1").css("border-color", "");
								$("#num2").css("border-color", "");
								$("#enviar").attr("disabled", true);
								$("#resul").attr("value",(""));
								$("#resul").empty();
								$("#resul").val("");
							});
						});
	</script>
</body>
</html>
