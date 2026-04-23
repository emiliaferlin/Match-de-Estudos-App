import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/core/shared/constantes.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';
import 'package:match_estudos_app/src/features/sessao/model/sessao_model.dart';
import 'package:match_estudos_app/src/features/sessao/view/sessao_form_view.dart';
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

  void _abrirFormulario({SessaoModel? sessao}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ChangeNotifierProvider.value(
              value: context.read<SessaoViewModel>(),
              child: SessaoFormView(sessao: sessao),
            ),
      ),
    );
  }

  Future<void> _confirmarExclusao(
    BuildContext context,
    SessaoModel sessao,
  ) async {
    final vm = context.read<SessaoViewModel>();
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Excluir sessão?',
              style: TextStyleMatchEstudo.titleSM(),
            ),
            content: Text(
              'Deseja excluir a sessão "${sessao.titulo}"? Esta ação não pode ser desfeita.',
              style: TextStyleMatchEstudo.bodySM(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(
                  'Cancelar',
                  style: TextStyleMatchEstudo.bodySM(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );

    if (confirm == true && sessao.id != null) {
      await vm.excluirSessao(sessao.id!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sessão "${sessao.titulo}" excluída com sucesso.'),
            backgroundColor: primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  Color _nivelColor(String? nivel) {
    switch (nivel?.toLowerCase()) {
      case 'fácil':
      case 'facil':
      case 'iniciante':
        return const Color(0xFF4CAF50);
      case 'médio':
      case 'medio':
      case 'intermediário':
        return const Color(0xFFFFA726);
      case 'difícil':
      case 'dificil':
      case 'avançado':
        return const Color(0xFFEF5350);
      default:
        return primaryColor;
    }
  }

  String _formatarData(String? dataHora) {
    if (dataHora == null) return '';
    try {
      final dt = DateTime.parse(dataHora);
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return dataHora;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SessaoViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F0),
      appBar: AppBar(
        title: Text(
          'Sessões',
          style: TextStyleMatchEstudo.titleMD(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body:
          vm.loading
              ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
              : vm.sessoes.isEmpty
              ? _buildEmpty()
              : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: vm.sessoes.length,
                itemBuilder: (_, i) => _buildCard(vm.sessoes[i]),
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(
          'Nova Sessão',
          style: TextStyleMatchEstudo.bodySM(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy_rounded, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Nenhuma sessão cadastrada',
            style: TextStyleMatchEstudo.titleSM(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque em "Nova Sessão" para começar',
            style: TextStyleMatchEstudo.bodySM(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(SessaoModel sessao) {
    final nivelColor = _nivelColor(sessao.nivel);

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
      child: Column(
        children: [
          // Cabeçalho colorido
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
                const Icon(
                  Icons.menu_book_rounded,
                  color: primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    sessao.titulo ?? '',
                    style: TextStyleMatchEstudo.titleXS(color: primaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildActionButton(
                  icon: Icons.edit_rounded,
                  color: const Color(0xFF1565C0),
                  tooltip: 'Editar',
                  onTap: () => _abrirFormulario(sessao: sessao),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.delete_rounded,
                  color: Colors.red[600]!,
                  tooltip: 'Excluir',
                  onTap: () => _confirmarExclusao(context, sessao),
                ),
              ],
            ),
          ),
          // Detalhes
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildInfoItem(
                      Icons.subject_rounded,
                      sessao.disciplina ?? '',
                      Colors.grey[700]!,
                    ),
                    const SizedBox(width: 12),
                    _buildInfoItem(
                      Icons.psychology_rounded,
                      sessao.estilo ?? '',
                      Colors.grey[700]!,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildInfoItem(
                      Icons.access_time_rounded,
                      _formatarData(sessao.dataHoraInicio),
                      Colors.grey[600]!,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildChip(sessao.nivel ?? '', nivelColor),
                    const SizedBox(width: 8),
                    if (sessao.duracaoMinutos != null)
                      _buildChip(
                        '${sessao.duracaoMinutos} min',
                        const Color(0xFF5C6BC0),
                      ),
                    const SizedBox(width: 8),
                    if (sessao.vagas != null)
                      _buildChip(
                        '${sessao.vagas} vagas',
                        const Color(0xFF26A69A),
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

  Widget _buildInfoItem(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyleMatchEstudo.bodyXS(color: color)),
      ],
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

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 17, color: color),
        ),
      ),
    );
  }
}
