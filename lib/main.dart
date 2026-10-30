import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'area_retangulo.dart';
import 'calculadora.dart';
import 'vel_media.dart';

void main() {
  runApp(const CalculoNaMaoApp());
}

class CalculoNaMaoApp extends StatelessWidget {
  const CalculoNaMaoApp({super.key});

  @override
  Widget build(BuildContext context) {
	 return MaterialApp(
		title: 'Cálculo na mão.APK',
		theme: ThemeData(
			appBarTheme: const AppBarTheme(
					// Define a cor dos ícones do AppBar para todo o app
					iconTheme: IconThemeData(color: Colors.cyan),
				), // AppBarTheme
			), // ThemeData
		home: Home(),
		debugShowCheckedModeBanner: false,
	 );
  }
}

class Home extends StatefulWidget {
	const Home({super.key});

	void _openPage(BuildContext context, Widget page) {
  		Navigator.pop(context);
		Navigator.push(
			context,
			MaterialPageRoute<void>(builder: (_) => page),
		);
  }
  
	@override
	State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			// opções de menu superior
			drawer: Drawer (
				backgroundColor: Colors.black,
				child: ListView(
					children:[
						DrawerHeader(
							decoration: BoxDecoration(color: Colors.cyan,),
							child: Text(
								'Menu',
								style: TextStyle(
									color: Colors.black,
									fontSize: 24,
									fontWeight: FontWeight.bold,
								), // TextStyle
							), // Text
						), // DrawerHeader
						ListTile(
							trailing:Icon(Icons.add_box_sharp, color: Colors.cyan,),
							title: Text(
								'Operações Básicas',
								style: TextStyle(color: Colors.white,),
							),
							onTap: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => const CalculadoraPage()),
								); // Navigator.push
							}, // onTap 
						), // ListTitle
						ListTile(
							trailing:Icon(Icons.airplay_sharp, color: Colors.cyan),
							title: Text(
								'Área do retângulo',
								style: TextStyle(color: Colors.white,),
							),
							onTap: () {
							Navigator.push( 
								context,
								MaterialPageRoute(builder: (context) => const AreaRetanguloPage()),
								); // Navigator.push
							} // onTap
						), // ListTitle
						ListTile(
							trailing:Icon(Icons.speed, color: Colors.cyan),
							title: Text(
								'Velocidade média',
								style: TextStyle(color: Colors.white,),
							),
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
			appBar: AppBar(
				backgroundColor: Colors.cyan,
				centerTitle: true,
				iconTheme: const IconThemeData(
					color: Colors.black,
				),
				title: Text(
					'Calculo na mão .app',
					textAlign: TextAlign.center,
					style: TextStyle(
						fontSize: 22,
						color: Colors.black,
						fontWeight: FontWeight.bold,
					), // TextStyle
				), // Text
			), // AppBar
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						Text(
							'\n1. Cálculo das quatro operações básicas com dois números decimais ou inteiros.',
							textAlign: TextAlign.left,
							style: TextStyle(
								fontSize: 28,
								color: Colors.cyan,
							), // TextStyle
						), // text
						Text(
							'\n2. Cálculo da velocidade média a partir dos dados final e inicial (Xf - Xi), ou apenas variação (ΔX) de posição e tempo.',
							textAlign: TextAlign.left,
							style: TextStyle(
								fontSize: 28,
								color: Colors.cyan,
							), // TextStyle
						), // text
						Text(
							'\n3. Cálculo da área de um retângulo ou quadrado. A partir dos comprimentos dos lados.\n',
							textAlign: TextAlign.left,
							style: TextStyle(
								fontSize: 28,
								color: Colors.cyan,
							), // TextStyle
						), // text
					], // Column
				), // Column
			), // body: Center
			bottomNavigationBar: BottomAppBar(
				padding: EdgeInsets.all(0),
				child: Container(
				height: 30,
				color: Colors.cyan,
				child: Column(
					children: [
						Text(
								'Desenvolvido por Vinicius C. dos Santos',
								style: TextStyle(color: Colors.black, fontSize: 18),
						), // child: Text
					], // children
				), // Column
			), // child: Container
		), // BottomAppBar
	); // return Scaffold
} // build
} // _HomeState
