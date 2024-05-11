import 'package:cuidarmais/pages/emergency/emergency_contacts_management.dart';
import 'package:cuidarmais/pages/home/home.dart';
import 'package:cuidarmais/pages/list_patient/list_paciente.dart';
import 'package:cuidarmais/pages/medication/medication_registration.dart';
import 'package:cuidarmais/pages/patient_data/patient_data.dart';
import 'package:cuidarmais/pages/registrar_rotina/registrar_rotina.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_ativ_fisica.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_decubito.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_higiene.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_medicacao.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_refeicao.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_sinais_vitais.dart';
import 'package:cuidarmais/pages/sign_up/sign_up_cuidador.dart';
import 'package:cuidarmais/pages/sign_up/sign_up_paciente.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/pages/principal/principal.dart';
import 'package:cuidarmais/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/principal':
            return MaterialPageRoute(builder: (_) => const PrincipalPage());
          case '/listaPacientes':
            return MaterialPageRoute(builder: (_) => const ListaPacientePage());
          case '/cadastrarPaciente':
            return MaterialPageRoute(
                builder: (_) => const SignUpPacientePage());
          case '/dadosPaciente':
            return MaterialPageRoute(builder: (_) => const PatientDataPage());
          case '/cadastrarCuidador':
            return MaterialPageRoute(
                builder: (_) => const SignUpCuidadorPage());
          case '/gerenciarContatos':
            final args = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (_) =>
                  EmergencyContactsManagementPage(idcontato_emergencia: args),
            );
          case '/gerenciarMedicacao':
            return MaterialPageRoute(
              builder: (_) => const MedicationRegistrationPage(),
            );
          case '/registrarRotina':
            return MaterialPageRoute(
              builder: (_) => const RegistrarRotinaPage(),
            );
          case '/home':
            final args = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (_) => HomePage(selectedIndex: args ?? 1),
            );
          case '/rotinaMedicacao':
            return MaterialPageRoute(
              builder: (_) => const MedicacaoPage(tipoCuidado: 5),
            );
          case '/rotinaSinaisVitais':
            return MaterialPageRoute(
              builder: (_) => const SinaisVitaisPage(tipoCuidado: 2),
            );
          case '/rotinaRefeicao':
            return MaterialPageRoute(
              builder: (_) => const RefeicaoPage(tipoCuidado: 1),
            );
          case '/rotinaAtividadeFisica':
            return MaterialPageRoute(
              builder: (_) => const AtividadeFisicaPage(tipoCuidado: 3),
            );
          case '/rotinaHigiene':
            return MaterialPageRoute(
              builder: (_) => const RotinaHigienePage(tipoCuidado: 4),
            );
          case '/rotinaDecubito':
            return MaterialPageRoute(
              builder: (_) => const RotinaDecubitoPage(tipoCuidado: 6),
            );
          default:
            return MaterialPageRoute(builder: (_) => const LoginPage());
        }
      },
      title: 'Cuidar+',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 133, 187, 203),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
