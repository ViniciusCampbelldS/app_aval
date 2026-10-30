import 'package:flutter/material.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  // controladores para os campos de texto
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  // variável para o resultado da operação
  String _infoText = 'Informe dois numeros e selecione a operação.';
  // função para resetar os campos de texto e a variável de resultado
  void _resetFields() {
	 num1Controller.text = '';
	 num2Controller.text = '';
	 setState(() {
		_infoText = 'Informe dois numeros e selecione a operação.';
	 });
  } // _resetFields

  void _calculate() {
	 setState(() {
		double num1 = double.tryParse(num1Controller.text) ?? 0;
		double num2 = double.tryParse(num2Controller.text) ?? 0;
		double? result = null;
		String operation = '';
		switch (operation){
			case '+':
				result = num1 + num2;
				break;
			case '-':
				result = num1 - num2;
				break;
			case '*':
				result = num1 * num2;
				break;
			case '/':
				result = num1 / num2;
				break;
	} // switch (operation)
	 }); // setState
  } // _calculate
	@override
	void dispose() {
		num1Controller.dispose();
		num2Controller.dispose();
		super.dispose();
	} // dispose

	@override
	Widget build(BuildContext context) {
		return  Scaffold( // build
			backgroundColor: Colors.black,
			appBar: AppBar(
				backgroundColor: Colors.cyan,
				iconTheme: const IconThemeData(
					color: Colors.black,
				), // IconThemeData
				title: const Text(
					'Calculadora das quatro operações básicas',
					style: TextStyle(color: Colors.black),
				), // Text
				centerTitle: true,
				actions: [
					IconButton(
						onPressed: _resetFields,
						icon: Icon(
							Icons.refresh,
							color: Colors.black,
						), // icon
					), // IconButton
				], // actions
			), // AppBar
			body: SingleChildScrollView(
				padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						Icon(Icons.person_outline, size: 120, color: Colors.cyan),
						TextField(
							keyboardType: TextInputType.number,
							textAlign: TextAlign.center,
							style: TextStyle(
								color: Colors.white,
								fontSize: 25
							), // TextStyle
							// decoração do campo de texto
							decoration: InputDecoration(
								labelText: 'Peso (kg)',
								labelStyle: TextStyle(color:  Colors.white),
							), // decoration: InputDecoration(
							controller: num1Controller,
						), // TextField
						SizedBox(height: 20),
						TextField(
							keyboardType: TextInputType.number,
							textAlign: TextAlign.center,
							style: TextStyle(color: Colors.white, fontSize: 25),
							// decoração do campo de texto
							decoration: InputDecoration(
								labelText: 'Altura (cm)',
								labelStyle: TextStyle(color: Colors.white),
							), // decoration: InputDecoration
							controller: num2Controller,
						), // TextField
						SizedBox(height: 20),
						Padding(
							padding: const EdgeInsets.all(8.0),
							child: SizedBox(
								height: 50,
								child: ElevatedButton(
									onPressed: _calculate,
									// ignore: sort_child_properties_last
									child: Text(
										'Calcular ',
										style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
									), // Text
									style: ElevatedButton.styleFrom(
										backgroundColor: const Color.fromARGB(255, 15, 130, 35),
									), // style: ElevatedButton.styleFrom(
								), // Elevated Button
							), // child sizedBox
						), // Padding
						SizedBox(height: 20),
							Text(
							_infoText,
							textAlign: TextAlign.center,
							style: TextStyle(color: Colors.black, fontSize: 25),
						), // Text
				], // children of Column
			), // Column
		), // SingleChildScrollView
	); // Scaffold
	} // build
} // _CalculadoraPageState