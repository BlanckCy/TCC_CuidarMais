import 'package:flutter/material.dart';

class PatientDataManagementPage extends StatefulWidget {
  const PatientDataManagementPage({Key? key}) : super(key: key);

  @override
  _PatientDataManagementPageState createState() =>
      _PatientDataManagementPageState();
}

class _PatientDataManagementPageState extends State<PatientDataManagementPage> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remover o botão de voltar padrão
        backgroundColor: Color.fromARGB(255, 24, 147, 189),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/TesteBar.png', // Caminho para o logotipo
                height: 40, // Altura do logotipo
              ),
            ),
            Text(
              'CUIDAR +', // Texto ao lado do logotipo
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dados do Paciente:', // Título da seção
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Campo de nome do paciente
            TextFormField(
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: 'Nome do Paciente',
                hintText: 'Digite o nome do paciente',
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Campo de idade do paciente
            TextFormField(
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: 'Idade do Paciente',
                hintText: 'Digite a idade do paciente',
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Campo de nome do responsável
            TextFormField(
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: 'Nome do Responsável',
                hintText: 'Digite o nome do responsável',
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Campo de e-mail do responsável
            TextFormField(
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: 'E-mail do Responsável',
                hintText: 'Digite o e-mail do responsável',
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Campo de telefone do responsável
            TextFormField(
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: 'Telefone do Responsável',
                hintText: 'Digite o telefone do responsável',
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.edit), // Ícone de lápis para edição
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete), // Ícone de lixeira para exclusão
                  onPressed: () {
                    // Lógica para excluir todos os dados do paciente
                  },
                ),
              ],
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Botão de salvar alterações
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar as alterações
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
