import 'package:flutter/material.dart';
import 'area_retangulo.dart';
import 'calculadora.dart';
import 'vel_media.dart';

void main() {
	runApp(
		MaterialApp(
			home: Home(),
			debugShowCheckedModeBanner: false
		)
	);
}

class Home extends StatefulWidget {
	const Home({super.key});
	
	@override
	State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			// opções de menu superior
			drawer: Drawer (
				child: ListView(
					children:[
						DrawerHeader(
							decoration: BoxDecoration(
								color: Colors.cyan,
							), // decoration: BoxDecoration
							child: Text(
								'Menu',
								style: TextStyle(
									color: Colors.white,
									fontSize: 24,
								), // TextStyle
							), // Text
						), // DrawerHeader
						ListTile(
							trailing:Icon(
								Icons.add_box_sharp,
								color: Colors.cyan
							), // Icon
							title: Text('Operações Básicas'),
							onTap: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => const CalculadoraPage()),
								); // Navigator.push
							}, // onTap 
						), // ListTitle
						ListTile(
							trailing:Icon(Icons.airplay_sharp, color: Colors.cyan),
							title: Text('Área do retângulo'),
							onTap: () {
							Navigator.push( 
								context,
								MaterialPageRoute(builder: (context) => const AreaRetanguloPage()),
								); // Navigator.push
							} // onTap
						), // ListTitle
						ListTile(
							trailing:Icon(Icons.speed, color: Colors.cyan),
							title: Text('Velocidade média'),
							onTap: () {
							Navigator.push( 
								context,
								MaterialPageRoute(builder: (context) => const VelMediaPage()),
								); // Navigator.push
							} // onTap
						), // ListTitle
					] // children
				) // child: ListView
			), // Drawer
			body: const Center(
				children[
					Text(
						'Cálculo das quatro operações básicas com dois números decimais.',
						textAlign: TextAlign.center,
						style: TextStyle(
							fontSize: 30,
							color: Colors.white,
							fontWeight: FontWeight.bold,
						), // TextStyle
					), // text
					Text(
						'Cálculo da velocidade média a partir da posição e tempo inícial e final, ou apenas.',
						textAlign: TextAlign.center,
						style: TextStyle(
							fontSize: 30,
							color: Colors.white,
							fontWeight: FontWeight.bold,
						), // TextStyle
					), // text
					Text(
						'Cálculo da área de um retângulo ou quadrado.',
						textAlign: TextAlign.center,
						style: TextStyle(
							fontSize: 30,
							color: Colors.white,
							
							fontWeight: FontWeight.bold,
						), // TextStyle
					), // text
					backgroundColor: const Colors.black,
				],
			), // body: Center
			appBar: AppBar(
				title: Text(
					'Calculo na mão .app',
					textAlign: TextAlign.center,
					style: TextStyle(
						fontSize: 30,
						color: Colors.cyan,
						fontWeight: FontWeight.bold,
					), // TextStyle
				), // Text
				centerTitle: true,
				backgroundColor: const Colors.black,
			), // AppBar
			bottomNavigationBar: BottomAppBar(
				padding: EdgeInsets.all(0),
				child: Container(
				height: 30,
				color: Colors.black,
				child: Center(
					child: Text(
							'Desenvolvido por Vinicius C. dos Santos',
							style: TextStyle(color: Colors.cyan, fontSize: 18),
						), // child: Text
					), // child: Center
				), // child: Container
			), // BottomAppBar
		); // return Scaffold(
	}// build (){
} // _HomeState
