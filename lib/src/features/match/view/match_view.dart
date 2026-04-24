import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/core/shared/constantes.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';
import 'package:match_estudos_app/src/features/match/model/match_model.dart';
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

  Color _scoreColor(int score) {
    if (score < 60) return const Color(0xFFEF5350);
    if (score < 80) return const Color(0xFFFFA726);
    return const Color(0xFF4CAF50);
  }

  String _scoreLabel(int score) {
    if (score < 60) return 'Baixa compatibilidade';
    if (score < 80) return 'Boa compatibilidade';
    return 'Alta compatibilidade';
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MatchViewmodel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F0),
      appBar: AppBar(
        title: Text(
          'Match dos Estudos',
          style: TextStyleMatchEstudo.titleMD(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body:
          loadingDropdowns
              ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
              : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSelectorCard(vm),
                          const SizedBox(height: 16),
                          if (vm.loadingCalc)
                            _buildLoadingCard()
                          else if (vm.errorMessage != null)
                            _buildErrorCard(vm.errorMessage!)
                          else if (vm.lastCalculated != null)
                            _buildResultCard(vm.lastCalculated!),
                          if (vm.matches.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            _buildMatchesHeader(vm),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (vm.loadingList)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        ),
                      ),
                    )
                  else if (vm.matches.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, i) => _buildMatchCard(vm.matches[i]),
                          childCount: vm.matches.length,
                        ),
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: _buildEmptyMatches(),
                      ),
                    ),
                ],
              ),
    );
  }

  Widget _buildSelectorCard(MatchViewmodel vm) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cabeçalho
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.tune_rounded, color: primaryColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Configurar Match',
                  style: TextStyleMatchEstudo.titleXS(color: primaryColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Dropdown Perfil
                _buildDropdown<PerfilModel>(
                  label: 'Selecione um Perfil',
                  icon: Icons.person_rounded,
                  value: selectedPerfil,
                  items: perfis,
                  itemLabel: (p) => p.nome ?? '',
                  itemSubtitle: (p) => p.disciplina ?? '',
                  onChanged: (value) => setState(() => selectedPerfil = value),
                ),
                const SizedBox(height: 12),
                // Dropdown Sessão
                _buildDropdown<SessaoModel>(
                  label: 'Selecione uma Sessão',
                  icon: Icons.menu_book_rounded,
                  value: selectedSessao,
                  items: sessoes,
                  itemLabel: (s) => s.titulo ?? '',
                  itemSubtitle: (s) => s.disciplina ?? '',
                  onChanged: (value) => setState(() => selectedSessao = value),
                ),
                const SizedBox(height: 16),
                // Botões
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: primaryColor.withOpacity(
                            0.4,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        icon:
                            vm.loadingCalc
                                ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Icon(Icons.calculate_rounded, size: 18),
                        label: Text(
                          'Calcular Match',
                          style: TextStyleMatchEstudo.bodySM(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          if (selectedPerfil != null) {
                            vm.fetchMatches(selectedPerfil!.id!);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryColor,
                          side: BorderSide(
                            color: primaryColor.withOpacity(0.6),
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.list_alt_rounded, size: 18),
                        label: Text(
                          'Ver Matches',
                          style: TextStyleMatchEstudo.bodySM(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required IconData icon,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabel,
    required String Function(T) itemSubtitle,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            hint: Row(
              children: [
                Icon(icon, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyleMatchEstudo.bodySM(color: Colors.grey[500]),
                ),
              ],
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primaryColor,
            ),
            borderRadius: BorderRadius.circular(12),
            items:
                items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          itemLabel(item),
                          style: TextStyleMatchEstudo.bodySM(),
                        ),
                        if (itemSubtitle(item).isNotEmpty)
                          Text(
                            itemSubtitle(item),
                            style: TextStyleMatchEstudo.bodyXS(
                              color: Colors.grey[500],
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(color: primaryColor),
          const SizedBox(height: 12),
          Text(
            'Calculando compatibilidade...',
            style: TextStyleMatchEstudo.bodySM(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.red.shade600,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyleMatchEstudo.bodySM(color: Colors.red.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(MatchModel match) {
    final score = match.score ?? 0;
    final aprovado = match.aprovado ?? false;
    final scoreColor = _scoreColor(score);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cabeçalho colorido
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: scoreColor.withOpacity(0.12),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  aprovado
                      ? Icons.favorite_rounded
                      : Icons.heart_broken_rounded,
                  color: scoreColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Resultado do Match',
                  style: TextStyleMatchEstudo.titleXS(color: scoreColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Score circular + info
                Row(
                  children: [
                    // Indicador circular do score
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: 1,
                            strokeWidth: 6,
                            color: Colors.grey.shade200,
                          ),
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: score / 100),
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeOut,
                            builder: (_, value, __) {
                              return CircularProgressIndicator(
                                value: value,
                                strokeWidth: 6,
                                color: scoreColor,
                                strokeCap: StrokeCap.round,
                              );
                            },
                          ),
                          Center(
                            child: Text(
                              '$score%',
                              style: TextStyleMatchEstudo.titleSM(
                                color: scoreColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            aprovado ? 'Match Aprovado!' : 'Não Compatível',
                            style: TextStyleMatchEstudo.titleSM(
                              color: scoreColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _scoreLabel(score),
                            style: TextStyleMatchEstudo.bodySM(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildChip(
                            aprovado ? 'Aprovado' : 'Reprovado',
                            scoreColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Barra de progresso
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: score / 100),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                    builder: (_, value, __) {
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade200,
                        color: scoreColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesHeader(MatchViewmodel vm) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.favorite_rounded, color: primaryColor, size: 18),
          const SizedBox(width: 8),
          Text(
            'Matches Encontrados',
            style: TextStyleMatchEstudo.titleXS(color: primaryColor),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${vm.matches.length}',
              style: TextStyleMatchEstudo.bodyXS(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(MatchModel match) {
    final score = match.score ?? 0;
    final aprovado = match.aprovado ?? false;
    final scoreColor = _scoreColor(score);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Ícone de status
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: scoreColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                aprovado ? Icons.favorite_rounded : Icons.heart_broken_rounded,
                color: scoreColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sessão #${match.sessaoId}',
                    style: TextStyleMatchEstudo.titleXS(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Perfil #${match.perfilId}',
                    style: TextStyleMatchEstudo.bodySM(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildChip('${score}%', scoreColor),
                      const SizedBox(width: 8),
                      _buildChip(
                        aprovado ? 'Aprovado' : 'Reprovado',
                        aprovado
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFEF5350),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Barra de score vertical
            Column(
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: 1,
                        strokeWidth: 4,
                        color: Colors.grey.shade200,
                      ),
                      CircularProgressIndicator(
                        value: score / 100,
                        strokeWidth: 4,
                        color: scoreColor,
                        strokeCap: StrokeCap.round,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyMatches() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nenhum match encontrado',
              style: TextStyleMatchEstudo.titleSM(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Selecione um perfil e calcule um match',
              style: TextStyleMatchEstudo.bodySM(color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyleMatchEstudo.bodyXS(color: color)),
    );
  }
}
