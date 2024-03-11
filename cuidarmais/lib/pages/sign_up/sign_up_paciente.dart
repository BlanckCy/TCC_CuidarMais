import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/models/database.dart';
import 'package:cuidarmais/constants/custom_colors.dart'; // Importe a classe que contém o método RetornarPaciente

class SignUpPacientePage extends StatefulWidget {
  const SignUpPacientePage({Key? key}) : super(key: key);

  @override
  State<SignUpPacientePage> createState() => _SignUpPacientePageState();
}

class _SignUpPacientePageState extends State<SignUpPacientePage> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  int _idade = 0;
  String _genero = '';
  String _nomeResponsavel = '';
  String _emailResponsavel = '';
  String _telefoneResponsavel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'PREENCHA OS DADOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 63, 81, 181),
              ),
            ),
            SizedBox(height: 16), // Espaçamento entre o texto e o botão
            Form(
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 2, 84, 109),
                      ),
                      labelText: "Nome:",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Digite seu nome completo",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*class SignUpPacientePage extends StatefulWidget {
  const SignUpPacientePage({super.key});

  @override
  State<SignUpPacientePage> createState() => _SignUpPacientePageState();
}

class _SignUpPacientePageState extends State<SignUpPacientePage> {
  bool _mostrarSenha = false;
  String _emailError = '';
  String _senhaError = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Paciente paciente = Paciente();
  List<Paciente> pacientes = [];

  @override
  void initState() {
    super.initState();
    _carregarPacientes();
  }

  Future<void> _carregarPacientes() async {
    try {
      var paciente = Paciente(); // Crie uma instância da classe Database
      List<Paciente> listaPacientes = await paciente.RetornarPacientes(
          1); // Chame o método RetornarPaciente através dessa instância
      setState(() {
        pacientes = listaPacientes;
      });
    } catch (error) {
      // Handle error
      print('Erro ao carregar pacientes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
        decoration: BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Aqui você pode usar a lista de pacientes para construir widgets
              // Exemplo:
              ListView.builder(
                shrinkWrap: true,
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pacientes[index].nome ??
                        ''), // Verifique se o nome é nulo antes de acessá-lo
                    subtitle: Text(
                        'ID: ${pacientes[index].idpaciente ?? ''}'), // Use idpaciente em vez de id
                    // Outros detalhes do paciente
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
