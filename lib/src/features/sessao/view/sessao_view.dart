import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/sessao/model/sessao_model.dart';
import 'package:match_estudos_app/src/features/sessao/viewmodel/sessao_viewmodel.dart';
import 'package:provider/provider.dart';

class SessaoView extends StatefulWidget {
  const SessaoView({super.key});

  @override
  State<SessaoView> createState() => _SessaoViewState();
}

class _SessaoViewState extends State<SessaoView> {
  @override
  void initState() {
    super.initState();
    context.read<SessaoViewModel>().fetchSessoes();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SessaoViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Sessões")),
      body:
          vm.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: vm.sessoes.length,
                itemBuilder: (_, i) {
                  final s = vm.sessoes[i];

                  return Card(
                    child: ListTile(
                      title: Text(s.titulo ?? ''),
                      subtitle: Text("${s.disciplina} • ${s.nivel}"),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vm.addSessao(
            SessaoModel(
              titulo: "Nova Sessão",
              disciplina: "Algoritmos",
              nivel: "médio",
              estilo: "argumentativo",
              dataHoraInicio: "2026-04-20T19:00:00",
              duracaoMinutos: 60,
              vagas: 5,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
