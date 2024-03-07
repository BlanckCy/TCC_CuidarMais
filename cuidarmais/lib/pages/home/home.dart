import 'package:flutter/material.dart';
import 'package:cuidarmais/models/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<dynamic> _buscarCuidadores() async {
    try {
      return await Database.buscarDadosPost('/cuidadores/lista', {});
    } catch (e) {
      // Tratamento de erro
      print('Erro ao buscar cuidadores: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: Icon(Icons.menu),
        title: Text("App"),
      ),
      body: FutureBuilder<dynamic>(
        future: _buscarCuidadores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Erro ao carregar cuidadores'));
          } else {
            final cuidadores = snapshot.data;
            return ListView.builder(
              itemCount: cuidadores.length,
              itemBuilder: (context, index) {
                final cuidador = cuidadores[index];
                return ListTile(
                  title: Text('Nome: ${cuidador['nome']}'),
                  subtitle: Text('Email: ${cuidador['email']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
