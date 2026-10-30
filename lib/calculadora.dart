import 'package:flutter/material.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
	TextEditingController num1Controller = TextEditingController();
	TextEditingController num2Controller = TextEditingController();
	
	// variável para o resultado e operação
	String? operation;
	String result = 'Informe dois números e selecione uma operação.';
	double? _parseNumber(String value) {
		final parsed = double.tryParse(value.trim().replaceAll(',', '.'));
		return parsed != null && parsed.isFinite ? parsed : null;
	}

	String _formatNumber(double value) {
		if (value.isNaN || value.isInfinite) return value.toString();
		return value.toStringAsFixed(2);
	}
	
	void _selectOperation(String selectedOperation) {
		setState(() {
			operation = selectedOperation;
		});
		_calculate();
	}
  
	void _calculate() {
		final firstText = num1Controller.text.trim();
		final secondText = num2Controller.text.trim();
		final num1 = _parseNumber(firstText);
		final num2 = _parseNumber(secondText);

		setState(() {
			if (operation == null) {
			result = 'Selecione uma operação.';
			return;
			}

			if (firstText.isEmpty || secondText.isEmpty) {
			result = 'Informe os dois números para calcular.';
			return;
			}

			if (num1 == null || num2 == null) {
			result = 'Digite dois números válidos.';
			return;
			}

			if (operation == '/' && num2 == 0) {
			result = 'Não é possível dividir por zero.';
			return;
			}

			late double calculationResult;
			switch (operation) {
			case '+':
				calculationResult = num1 + num2;
				break;
			case '-':
				calculationResult = num1 - num2;
				break;
			case '*':
				calculationResult = num1 * num2;
				break;
			case '/':
				calculationResult = num1 / num2;
				break;
			default:
				result = 'Selecione uma operação válida.';
				return;
			}

			if (!calculationResult.isFinite) {
			result = 'O resultado está fora do intervalo numérico suportado.';
			return;
			}

			final displayOperation = operation == '*'
				? '×'
				: operation == '/'
					? '÷'
					: operation!;
			result = '${_formatNumber(num1)} $displayOperation ${_formatNumber(num2)}'
				' = ${_formatNumber(calculationResult)}';
		});
	}
	
	void _resetFields() {
		num1Controller.clear();
		num2Controller.clear();
		setState(() {
			operation = null;
			result = 'Informe dois números e selecione uma operação.';
		});
	}
	
	@override
	void dispose() {
		num1Controller.dispose();
		num2Controller.dispose();
		super.dispose();
	} // dispose

	Widget _buildNumberField({
		required String label,
		required TextEditingController controller,
	}) {
		return TextField(
			controller: controller,
			keyboardType: const TextInputType.numberWithOptions(
			decimal: true,
			signed: true,
			),
			textAlign: TextAlign.center,
			style: const TextStyle(color: Colors.white, fontSize: 22),
			decoration: InputDecoration(
			labelText: label,
			labelStyle: const TextStyle(color: Colors.white),
			floatingLabelStyle: const TextStyle(color: Colors.white),
			border: const OutlineInputBorder(),
			),
			onChanged: (_) {
			if (operation != null) _calculate();
			},
		);
	}

	Widget _buildOperationButton(String operationValue, String symbol) {
		final isSelected = operation == operationValue;
		return Expanded(
			child: Padding(
			padding: const EdgeInsets.symmetric(horizontal: 3),
			child: ElevatedButton(
				onPressed: () => _selectOperation(operationValue),
				style: ElevatedButton.styleFrom(
					backgroundColor: isSelected ? Colors.cyan : Colors.black,
					foregroundColor: isSelected ? Colors.black : Colors.cyan,
					side: const BorderSide(color: Colors.cyan),
					minimumSize: const Size.fromHeight(52),
					padding: EdgeInsets.zero,
				),
				child: Text(
					symbol,
					style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
				),
			),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		return  Scaffold(
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
				actions: [
					IconButton(
						onPressed: _resetFields,
						tooltip: 'Limpar campos',
						icon: const Icon(Icons.refresh, color: Colors.black),
					),
				],
				centerTitle: true,
			), // AppBar
			body: SafeArea(
				child: SingleChildScrollView(
					padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.center,
						children: [
							Icon(Icons.add_box_sharp, size: 120, color: Colors.cyan),
							const SizedBox(height: 12),
							_buildNumberField(
								label: 'Primeiro número (Dividendo/Subtraendo)',
								controller: num1Controller,
							),
							const SizedBox(height: 18),
							_buildNumberField(
								label: 'Segundo número (Divisor/Minuendo)',
								controller: num2Controller,
							), // TextField
							const SizedBox(height: 22),
							const Text(
								'Selecione a operação:',
								style: TextStyle(color: Colors.white, fontSize: 17),
								textAlign: TextAlign.center,
							),
							const SizedBox(height: 10),
							Row(
								children: [
									_buildOperationButton('+', '+'),
									_buildOperationButton('-', '-'),
									_buildOperationButton('*', '×'),
									_buildOperationButton('/', '÷'),
								],
							),
							const SizedBox(height: 26),
							Padding(
								padding: const EdgeInsets.all(18),
								child: Container(
									decoration: BoxDecoration(
										border: Border.all(color: Colors.cyan),
										borderRadius: BorderRadius.circular(10),
									),
									child: Text(
										result,
										textAlign: TextAlign.center,
										style: const TextStyle(
											color: Colors.white,
											fontSize: 22,
											fontWeight: FontWeight.bold,
										),
									), // child sizedBox
								), // Container
							), // Padding
					], // children of Column
				), // Column
				), // SingleChildScrollView
			), // SafeArea
		); // Scaffold
	} // build
} // _CalculadoraPageState