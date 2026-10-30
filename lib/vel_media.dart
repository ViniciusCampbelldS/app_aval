import 'package:flutter/material.dart';

class VelMediaPage extends StatefulWidget {
	const VelMediaPage({super.key});

	@override
	State<VelMediaPage> createState() => _VelMediaPageState();
	} // VelMediaPage

class _VelMediaPageState extends State<VelMediaPage> {
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
	
	double? _parseNumber(String value) {
		final text = value.trim();
		if (text.isEmpty) return null;
		final parsed = double.tryParse(text.replaceAll(',', '.'));
		return parsed != null && parsed.isFinite ? parsed : null;
  	}
	
	String _formatNumber(double value) => value.toStringAsFixed(2);

	void _calcularVelMedia() {
		final posicaoInicialText = posicaoInicialController.text.trim();
		final posicaoFinalText = posicaoFinalController.text.trim();
		final tempoInicialText = tempoInicialController.text.trim();
		final tempoFinalText = tempoFinalController.text.trim();

		final posicaoInicial = _parseNumber(posicaoInicialText) ?? 0;
		final posicaoFinal = _parseNumber(posicaoFinalText);
		final tempoInicial = _parseNumber(tempoInicialText) ?? 0;
		final tempoFinal = _parseNumber(tempoFinalText);

		setState(() {
		if ((posicaoInicialText.isNotEmpty &&
				  _parseNumber(posicaoInicialText) == null) ||
			 posicaoFinal == null ||
			 (tempoInicialText.isNotEmpty &&
				  _parseNumber(tempoInicialText) == null) ||
			 tempoFinal == null) {
		  result = 'Por favor, informe números válidos nos campos preenchidos.';
		  return;
		}

		if (tempoFinal <= tempoInicial) {
		  result =
				'O tempo final deve ser maior que o tempo inicial. Use o botão ↔ para inverter os valores.';
		  return;
		}
		
		final velocidade =
			 (posicaoFinal - posicaoInicial) / (tempoFinal - tempoInicial);
		if (!velocidade.isFinite) {
		  result = 'O resultado está fora do intervalo numérico suportado.';
		  return;
		}
		
		result = 'Velocidade média: ${_formatNumber(velocidade)}';
		
		if (velocidade < 0) {
		  result += '\nO sinal negativo indica deslocamento no sentido oposto.';
		}
	 });
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

	} // _calcularVelMedia

	void _swapControllers(
		TextEditingController first,
		TextEditingController second,
	) {
		setState(() {
			final temporary = first.text;
			first.text = second.text;
			second.text = temporary;
		});
	}

	@override
	void dispose() {
		posicaoInicialController.dispose();
		posicaoFinalController.dispose();
		tempoInicialController.dispose();
		tempoFinalController.dispose();
		super.dispose();
	} // dispose

	Widget _buildInputField(
		String label,
		TextEditingController controller,
	) {
		return TextField(
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
			); // TextField
	} // buildInputField

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			appBar: AppBar(
				backgroundColor: Colors.cyan,
				iconTheme: const IconThemeData(
					color: Colors.black, // Defina a cor desejada aqui
				),
				title: const Text(
					'Calculadora de Velocidade Média',
					style: TextStyle(fontSize: 22,
					color: Colors.black,
					fontWeight: FontWeight.bold),),
				centerTitle: true,
			), // AppBar
			body: Padding(
				padding: const EdgeInsets.all(18.0),
				child: SafeArea(
					child: SingleChildScrollView(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.start,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: [
								Column(
									crossAxisAlignment: CrossAxisAlignment.center,
									children: [
										Icon(Icons.speed, size: 120, color: Colors.cyan),
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
										SizedBox(height: 8),
										Row(
											children: [
											Text(textAlign: TextAlign.left,'• ', style: const TextStyle(fontSize: 18, color: Colors.white),),
											Text(textAlign: TextAlign.left,info[2], style: const TextStyle(fontSize: 18, color: Colors.white),),
											],
										), // Row
									], // children
								), // Column
								Row(
								children: [
									Expanded(
										child: _buildInputField(
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
										child: _buildInputField(
										'Posição final ou a variação da posição',
										posicaoFinalController,
										),
									), // Expanded
								], // children
							), // Row
							Row(
								children: [
									Expanded(
										child: _buildInputField(
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
										child: _buildInputField(
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
									onPressed: _calcularVelMedia,
									style: ElevatedButton.styleFrom(
										backgroundColor: const Color.fromARGB(255, 15, 130, 35),
									),
									child: const Text('Calcular Velocidade Média', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
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
									color: Colors.white,
									fontSize: 20,
									fontWeight: FontWeight.bold,
								),
								),
							),
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
			), // SafeArea
		), // Padding
	); // Scaffold
} // build
} // _VelMediaPageState