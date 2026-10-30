import 'package:flutter/material.dart';

class AreaRetanguloPage extends StatefulWidget {
  const AreaRetanguloPage({super.key});

  @override
  State<AreaRetanguloPage> createState() => _AreaRetanguloPageState();
}

class _AreaRetanguloPageState extends State<AreaRetanguloPage> {
final TextEditingController posicaoInicialController = TextEditingController();
	final TextEditingController posicaoFinalController = TextEditingController();
	final TextEditingController tempoInicialController = TextEditingController();
	final TextEditingController tempoFinalController = TextEditingController();
	final List<String> info = [
		'Deixe os campos iniciais em branco caso já tenha a diferença, ou caso o inicial seja zero.',
		'A unidade de medida depende da unidade dos dados fornecidos.',
		'A velocidade é negativa se a posição final for menor ou igual à posição inicial.'
		];
	String result = '';

	void calcularVelMedia() {
			double posicaoInicial = double.tryParse(posicaoInicialController.text.trim()) ?? 0;
			double? posicaoFinal = double.tryParse(posicaoFinalController.text.trim());
			double tempoInicial = double.tryParse(tempoInicialController.text.trim()) ?? 0;
			double? tempoFinal = double.tryParse(tempoFinalController.text.trim());

		if (
			posicaoFinal == null ||
			tempoFinal == null) {
				setState(() {
					result = 'Por favor, entre números válidos en todos os campos.';
				});
			return;
		} // if (invalid input)

		if (tempoFinal <= tempoInicial) {
			setState(() {
				result = 'O tempo final deve ser maior que o tempo inicial. O botão ↔ inverte os valores.';
			});
			return;
		} // if (tempoFinal <= tempoInicial)
		
		double velMedia = (posicaoFinal - posicaoInicial) / (tempoFinal - tempoInicial);
		
		setState(() {
			result = 'Velocidade média: ${velMedia.toStringAsFixed(2)} m/s';
		}); // setState
		
		if (posicaoFinal <= posicaoInicial) {
			setState(() {
				result = 'Velocidade média: ${velMedia.toStringAsFixed(2)} m/s\nA velocidade negativa indica direção oposta ao movimento.';
			});
			return;
		} else{
			setState(() {
				result = 'Velocidade média: ${velMedia.toStringAsFixed(2)} m/s';
			});
		}

	} // calculatevelMedia

	@override
	void dispose() {
		posicaoInicialController.dispose();
		posicaoFinalController.dispose();
		tempoInicialController.dispose();
		tempoFinalController.dispose();
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
						'Calculadora de Velocidade Média',
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
							Column(
								crossAxisAlignment: CrossAxisAlignment.center,
								children: [
									// Equivalente a um item de <ul> (com marcador de bolinha)
									Row(
										children: [
										Text(textAlign: TextAlign.left,'• ', style: const TextStyle(fontSize: 18, color: Colors.white),),
										Text(textAlign: TextAlign.left,'${info[0]}', style: const TextStyle(fontSize: 18, color: Colors.white),),
										],
									), // Row
									SizedBox(height: 8),
									Row(
										children: [
										Text(textAlign: TextAlign.left,'• ', style: const TextStyle(fontSize: 18, color: Colors.white),),
										Text(textAlign: TextAlign.left,'${info[1]}', style: const TextStyle(fontSize: 18, color: Colors.white),),
										],
									), // Row
									SizedBox(height: 8),
									Row(
										children: [
										Text(textAlign: TextAlign.left,'• ', style: const TextStyle(fontSize: 18, color: Colors.white),),
										Text(textAlign: TextAlign.left,'${info[2]}', style: const TextStyle(fontSize: 18, color: Colors.white),),
										],
									), // Row
								], // children
							), // Column
							Row(
							children: [
								Expanded(
									child: buildInputField(
									'Posição inicial',
									posicaoInicialController,
									), // buildInputField
								), // Expanded
								IconButton(
									icon: const Icon(
										Icons.swap_horiz,
										color: Colors.white,
									), // Icon
									tooltip: 'Trocar posições',
									onPressed: () {
									setState(() {
										final temp = posicaoInicialController.text;
										posicaoInicialController.text = posicaoFinalController.text;
										posicaoFinalController.text = temp;
									}); // setState
									}, // onPressed
								), // IconButton
								Expanded(
									child: buildInputField(
									'Posição final ou a variação da posição',
									posicaoFinalController,
									),
								), // Expanded
							], // children
						), // Row
						Row(
							children: [
								Expanded(
									child: buildInputField(
									'Tempo inicial',
									tempoInicialController,
									),
								),
								IconButton(
									icon: const Icon(
										Icons.swap_horiz,
										color: Colors.white,
									), // Icon
									tooltip: 'Trocar tempos',
									onPressed: () {
										setState(() {
											final temp = tempoInicialController.text;
											tempoInicialController.text = tempoFinalController.text;
											tempoFinalController.text = temp;
										}); // setState
									}, // onPressed
								), // IconButton
								Expanded(
									child: buildInputField(
										'Tempo final ou variação de tempo',
										tempoFinalController,
									),
								), // Expanded
							], // children
						), // Row
						const SizedBox(height: 20),
						Padding(
							padding: const EdgeInsets.all(8.0),
							child: SizedBox(
								height: 50,
								child: ElevatedButton(
								onPressed: calcularVelMedia,
								style: ElevatedButton.styleFrom(
									backgroundColor: const Color.fromARGB(255, 15, 130, 35),
								),
								child: const Text('Calcular Velocidade Média', style: TextStyle(fontSize: 20, color: Colors.black),),
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