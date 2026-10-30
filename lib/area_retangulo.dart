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

  double? _parseOptionalNumber(String value) {
	 final text = value.trim();
	 if (text.isEmpty) return null;
	 final parsed = double.tryParse(text.replaceAll(',', '.'));
	 return parsed != null && parsed.isFinite ? parsed : null;
  }

  String _formatNumber(double value) {
	 return value.toStringAsFixed(2);
  }

	void calcularAreaRetangulo() {
		String comprimentoTexto = comprimentoController.text.trim();
		String larguraTexto = larguraController.text.trim();

		double? comprimento = _parseOptionalNumber(comprimentoTexto);
		double? largura = _parseOptionalNumber(larguraTexto);

		if (comprimentoTexto.isEmpty && larguraTexto.isEmpty) {
			setState(() {
					result = 'Por favor, preencha pelo menos um campo.';
			});
			return;
		}

		if ((comprimentoTexto.isNotEmpty && comprimento == null) ||
			(larguraTexto.isNotEmpty && largura == null)) {
			setState(() {
					result = 'Por favor, insira números válidos.';
			});
			return;
		}

		setState(() {
			if (comprimento == null) {
					result = 'Área do QUADRADO: ${_formatNumber(largura! * largura)}';
			} else if (largura == null) {
					result = 'Área do QUADRADO: ${_formatNumber(comprimento * comprimento)}';
			} else if (comprimento == largura) {
					result = 'Área do QUADRADO: ${_formatNumber(comprimento * largura)}';
			} else {
					result = 'Área do retângulo: ${_formatNumber(comprimento * largura)}';
			}
		});
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
										Text('• ', textAlign: TextAlign.left, style: const TextStyle(fontSize: 18, color: Colors.white),),
										Text(info[0], textAlign: TextAlign.left,style: const TextStyle(fontSize: 18, color: Colors.white),),
										],
									), // Row
									SizedBox(height: 8),
									Row(
										children: [
										Text('• ', textAlign: TextAlign.left, style: const TextStyle(fontSize: 18, color: Colors.white),),
										Text(info[1], textAlign: TextAlign.left,style: const TextStyle(fontSize: 18, color: Colors.white),),
										],
									), // Row
								], // children
							), // Column
							buildInputField('Comprimento', comprimentoController),
							buildInputField('Largura', larguraController),
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
						if (result.isNotEmpty)
							Container(
								padding: const EdgeInsets.all(16),
								decoration: BoxDecoration(
								border: Border.all(color: Colors.cyan),
								borderRadius: BorderRadius.circular(10),
								),
								child: Text(
								result,
								textAlign: TextAlign.center,
								style: const TextStyle(
									fontSize: 20,
									fontWeight: FontWeight.bold,
									color: Colors.white,
								), // TextStyle
								), // Text
							), // Container
						], // children
					), // Column
				), // SingleChildScrollView
			), // Padding
		); // Scaffold
	} // build
}