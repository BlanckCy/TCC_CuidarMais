import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class RefeicaoPage extends StatefulWidget {
  @override
  _RefeicaoPageState createState() => _RefeicaoPageState();
}

class _RefeicaoPageState extends State<RefeicaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            color: Colors.white,
            child: Center(
              child: Text(
                "Como o paciente se alimentou hoje?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                "Café da manhã",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.sentiment_satisfied),
                    onPressed: () {
                      // Adicione aqui o código para lidar com a escolha de alimentação boa
                    },
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.sentiment_dissatisfied),
                    onPressed: () {
                      // Adicione aqui o código para lidar com a escolha de alimentação ruim
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Observações',
                  ),
                  maxLines: 1, // define o número máximo de linhas
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "Almoço",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.sentiment_satisfied),
                    onPressed: () {
                      // Adicione aqui o código para lidar com a escolha de alimentação boa
                    },
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.sentiment_dissatisfied),
                    onPressed: () {
                      // Adicione aqui o código para lidar com a escolha de alimentação ruim
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Observações',
                  ),
                  maxLines: 1, // define o número máximo de linhas
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "Jantar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.sentiment_satisfied),
                    onPressed: () {
                      // Adicione aqui o código para lidar com a escolha de alimentação boa
                    },
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.sentiment_dissatisfied),
                    onPressed: () {
                      // Adicione aqui o código para lidar com a escolha de alimentação ruim
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Observações',
                  ),
                  maxLines: 1, // define o número máximo de linhas
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
