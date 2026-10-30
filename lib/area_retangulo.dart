import 'package:flutter/material.dart';

class AreaRetanguloPage extends StatefulWidget {
  const AreaRetanguloPage({super.key});

  @override
  State<AreaRetanguloPage> createState() => _AreaRetanguloPageState();
}

class _AreaRetanguloPageState extends State<AreaRetanguloPage> {
	final TextEditingController comprimentoController = TextEditingController();
	final TextEditingController larguraController = TextEditingController();
	final List<String> info = [
		'Insira o comprimento dos lados do retângulo.',
		'Para calcular a área do quadrado, deixe um dos campos em branco.',
		];
	String result = '';

	void calcularAreaRetangulo() {
			double? comprimento = double.tryParse(comprimentoController.text.trim()) ?? null;
			double? largura = double.tryParse(larguraController.text.trim()) ?? null;

		if (largura == null &&
			comprimento == null) {
				setState(() {
					result = 'Por favor, entre números válidos en todos os campos.';
				});
			return;
		} // if (sem input)

		if (comprimento! <= 0 || largura! <= 0) {
			setState(() {
				result = 'O comprimento e a largura devem ser maiores que zero.';
			});
			return;
		} // if - negativo
		
		setState(() {
			if (largura == null ||
			comprimento == null) {
				if (comprimento == null) {
					result = 'Área do QUADRADO: ${largura * largura}';
				} else {
					result = 'Área do QUADRADO: ${comprimento * comprimento}';
				} // else
			} else {
				result = 'Área do retângulo: ${comprimento * largura}';
			} // else
		}); // setState
	} // calcularAreaRetangulo

	@override
	void dispose() {
		comprimentoController.dispose();
		larguraController.dispose();
		super.dispose();
	} // dispose

	Widget buildInputField(
		String label,
		TextEditingController controller,
	) {
		return Padding(
			padding: const EdgeInsets.symmetric(vertical: 8.0),
			child: TextField(
			controller: controller,
			style: const TextStyle(color: Colors.white),
			keyboardType: const TextInputType.numberWithOptions(
				decimal: true,
				signed: true,
			), // TextInputType.numberWithOptions
			decoration: InputDecoration(
				labelText: label,
				border: const OutlineInputBorder(),
				labelStyle: const TextStyle(
					color: Colors.white,
					), // TextStyle
				), // InputDecoration
			), // TextField
		); // Padding
	} // buildInputField

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			appBar: AppBar(
				backgroundColor: Colors.cyan,
				iconTheme: const IconThemeData(
					color: Colors.black,
				), // IconThemeData
				title: const Text(
						'Calculadora de Área do Retângulo',
						style: TextStyle(
							fontSize: 22,
							color: Colors.black,
							fontWeight: FontWeight.bold
						),
					),
				centerTitle: true,
			), // AppBar
			body: Padding(
				padding: const EdgeInsets.all(20.0),
				child: SingleChildScrollView(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.center,
						children: [
							Icon(Icons.airplay_sharp, size: 120, color: Colors.cyan),
							Column(
								crossAxisAlignment: CrossAxisAlignment.center,
								children: [
									// Equivalente a um item de <ul> (com marcador de bolinha)
									Row(
										children: [
										Text(textAlign: TextAlign.left,'• ', style: const TextStyle(fontSize: 18, color: Colors.white),),
										Text(textAlign: TextAlign.left,info[0], style: const TextStyle(fontSize: 18, color: Colors.white),),
										],
									), // Row
									SizedBox(height: 8),
									Row(
										children: [
										Text(textAlign: TextAlign.left,'• ', style: const TextStyle(fontSize: 18, color: Colors.white),),
										Text(textAlign: TextAlign.left,info[1], style: const TextStyle(fontSize: 18, color: Colors.white),),
										],
									), // Row
								], // children
							), // Column
							Expanded(
							child: buildInputField(
									'Comprimento',
									comprimentoController,
								), // buildInputField
							), // Expanded
							Expanded(
								child: buildInputField(
								'Largura',
								larguraController,
								),
							),
							const SizedBox(height: 20),
							Padding(
							padding: const EdgeInsets.all(8.0),
							child: SizedBox(
								height: 50,
								child: ElevatedButton(
								onPressed: calcularAreaRetangulo,
								style: ElevatedButton.styleFrom(
									backgroundColor: const Color.fromARGB(255, 15, 130, 35),
								),
								child: const Text('Calcular Área do retângulo', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
							),	// ElevatedButton
							), // SizedBox
						), // Padding
						const SizedBox(height: 20),
						Text(
								result,
								textAlign: TextAlign.center,
								style: const TextStyle(
									fontSize: 20,
									fontWeight: FontWeight.bold,
								), // TextStyle
							), // Text
						], // children
					), // Column
				), // SingleChildScrollView
			), // Padding
		); // Scaffold
	} // build
}