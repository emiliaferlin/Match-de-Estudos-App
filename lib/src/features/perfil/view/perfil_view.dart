import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/perfil/model/perfil_model.dart';
import 'package:match_estudos_app/src/features/perfil/viewmodel/perfil_viewmodel.dart';
import 'package:provider/provider.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  @override
  void initState() {
    super.initState();
    context.read<PerfilViewModel>().fetchPerfis();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PerfilViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Perfis")),
      body:
          vm.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: vm.perfis.length,
                itemBuilder: (_, i) {
                  final p = vm.perfis[i];

                  return Card(
                    child: ListTile(
                      title: Text(p.nome ?? ''),
                      subtitle: Text("${p.disciplina} - ${p.nivel}"),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vm.addPerfil(
            PerfilModel(
              nome: "Novo Perfil",
              idade: 20,
              disciplina: "Algoritmos",
              nivel: "iniciante",
              estilo: "silencioso",
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
