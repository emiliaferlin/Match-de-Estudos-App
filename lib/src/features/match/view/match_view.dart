import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/match/viewmodel/match_viewmodel.dart';
import 'package:match_estudos_app/src/features/perfil/model/perfil_model.dart';
import 'package:match_estudos_app/src/features/sessao/model/sessao_model.dart';
import 'package:provider/provider.dart';

class MatchView extends StatefulWidget {
  const MatchView({super.key});

  @override
  State<MatchView> createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  List<PerfilModel> perfis = [];
  List<SessaoModel> sessoes = [];

  PerfilModel? selectedPerfil;
  SessaoModel? selectedSessao;

  bool loadingDropdowns = true;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    context.read<MatchViewmodel>().clearData();
    final vm = context.read<MatchViewmodel>();

    try {
      final perfisResp = await vm.getPerfis();
      final sessoesResp = await vm.getSessoes();

      setState(() {
        perfis = perfisResp;
        sessoes = sessoesResp;
        loadingDropdowns = false;
      });
    } catch (e) {
      setState(() => loadingDropdowns = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MatchViewmodel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Match dos Estudos"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// INPUTS (AGORA SELECT)
            _buildInputs(vm),

            const SizedBox(height: 20),

            /// RESULTADO DO MATCH
            _buildResult(vm),

            const SizedBox(height: 20),

            /// LISTA DE MATCHES
            Expanded(child: _buildMatchesList(vm)),
          ],
        ),
      ),
    );
  }

  /// SELECTS DINÂMICOS
  Widget _buildInputs(MatchViewmodel vm) {
    if (loadingDropdowns) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        DropdownButtonFormField<PerfilModel>(
          value: selectedPerfil,
          items:
              perfis.map((p) {
                return DropdownMenuItem<PerfilModel>(
                  value: p,
                  child: Text(p.nome ?? ''),
                );
              }).toList(),
          onChanged: (value) {
            setState(() => selectedPerfil = value);
          },
          decoration: const InputDecoration(
            labelText: "Selecione um Perfil",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<SessaoModel>(
          value: selectedSessao,
          items:
              sessoes.map((s) {
                return DropdownMenuItem<SessaoModel>(
                  value: s,
                  child: Text(s.titulo ?? ''),
                );
              }).toList(),
          onChanged: (value) {
            setState(() => selectedSessao = value);
          },
          decoration: const InputDecoration(
            labelText: "Selecione uma Sessão",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),

        /// BOTÕES
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed:
                    vm.loadingCalc
                        ? null
                        : () {
                          if (selectedPerfil != null &&
                              selectedSessao != null) {
                            vm.calcularMatch(
                              selectedPerfil!.id!,
                              selectedSessao!.id!,
                            );
                          }
                        },
                child:
                    vm.loadingCalc
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Calcular Match"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  if (selectedPerfil != null) {
                    vm.fetchMatches(selectedPerfil!.id!);
                  }
                },
                child: const Text("Ver Matches"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Resultado do match
  Widget _buildResult(MatchViewmodel vm) {
    if (vm.loadingCalc) {
      return const LinearProgressIndicator();
    }

    if (vm.errorMessage != null) {
      return Text(vm.errorMessage!, style: const TextStyle(color: Colors.red));
    }

    final match = vm.lastCalculated;

    if (match == null) {
      return const Text("Nenhum match calculado ainda.");
    }

    final score = match.score ?? 0;
    final aprovado = match.aprovado ?? false;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Score: $score%",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: score / 100),
              duration: const Duration(milliseconds: 600),
              builder: (_, value, __) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade300,
                  color: _getColor(score),
                );
              },
            ),

            const SizedBox(height: 15),

            Text(
              aprovado ? "MATCH APROVADO!" : "Não compatível",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: aprovado ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Lista de matches aprovados
  Widget _buildMatchesList(MatchViewmodel vm) {
    if (vm.loadingList) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.matches.isEmpty) {
      return const Center(child: Text("Nenhum match encontrado."));
    }

    return ListView.builder(
      itemCount: vm.matches.length,
      itemBuilder: (_, index) {
        final m = vm.matches[index];

        return Card(
          child: ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: Text("Sessão ${m.sessaoId}"),
            subtitle: Text("Score: ${m.score}%"),
            trailing: Icon(
              m.aprovado == true ? Icons.check_circle : Icons.cancel,
              color: m.aprovado == true ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }

  /// Cor dinâmica do score
  Color _getColor(int score) {
    if (score < 60) return Colors.red;
    if (score < 80) return Colors.orange;
    return Colors.green;
  }
}
