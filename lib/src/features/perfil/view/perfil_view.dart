import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/core/shared/constantes.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';
import 'package:match_estudos_app/src/features/perfil/model/perfil_model.dart';
import 'package:match_estudos_app/src/features/perfil/view/perfil_form_view.dart';
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

  void _abrirFormulario({PerfilModel? perfil}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ChangeNotifierProvider.value(
              value: context.read<PerfilViewModel>(),
              child: PerfilFormView(perfil: perfil),
            ),
      ),
    );
  }

  Future<void> _confirmarExclusao(
    BuildContext context,
    PerfilModel perfil,
  ) async {
    final vm = context.read<PerfilViewModel>();
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Excluir perfil?',
              style: TextStyleMatchEstudo.titleSM(),
            ),
            content: Text(
              'Deseja excluir o perfil de "${perfil.nome}"? Esta ação não pode ser desfeita.',
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

    if (confirm == true && perfil.id != null) {
      await vm.excluirPerfil(perfil.id!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Perfil "${perfil.nome}" excluído com sucesso.'),
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
      case 'iniciante':
        return const Color(0xFF4CAF50);
      case 'intermediário':
      case 'intermediario':
        return const Color(0xFFFFA726);
      case 'avançado':
      case 'avancado':
        return const Color(0xFFEF5350);
      default:
        return primaryColor;
    }
  }

  IconData _estiloIcon(String? estilo) {
    switch (estilo?.toLowerCase()) {
      case 'silencioso':
        return Icons.volume_off_rounded;
      case 'colaborativo':
        return Icons.group_rounded;
      case 'argumentativo':
        return Icons.forum_rounded;
      case 'visual':
        return Icons.visibility_rounded;
      default:
        return Icons.person_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PerfilViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F0),
      appBar: AppBar(
        title: Text(
          'Perfis',
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
              : vm.perfis.isEmpty
              ? _buildEmpty()
              : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: vm.perfis.length,
                itemBuilder: (_, i) => _buildCard(vm.perfis[i]),
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(
          'Novo Perfil',
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
          Icon(Icons.person_off_rounded, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Nenhum perfil cadastrado',
            style: TextStyleMatchEstudo.titleSM(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque em "Novo Perfil" para começar',
            style: TextStyleMatchEstudo.bodySM(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(PerfilModel perfil) {
    final nivelColor = _nivelColor(perfil.nivel);

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
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _estiloIcon(perfil.estilo),
                color: primaryColor,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${perfil.nome ?? ''} ${perfil.idade != null ? '- ${perfil.idade} anos' : ""}",
                          style: TextStyleMatchEstudo.titleXS(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    perfil.disciplina ?? '',
                    style: TextStyleMatchEstudo.bodySM(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  _buildChip(perfil.nivel ?? '', nivelColor),
                  const SizedBox(height: 6),
                  _buildChip(
                    perfil.estilo ?? '',
                    primaryColor.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                _buildActionButton(
                  icon: Icons.edit_rounded,
                  color: const Color(0xFF1565C0),
                  tooltip: 'Editar',
                  onTap: () => _abrirFormulario(perfil: perfil),
                ),
                const SizedBox(height: 8),
                _buildActionButton(
                  icon: Icons.delete_rounded,
                  color: Colors.red[600]!,
                  tooltip: 'Excluir',
                  onTap: () => _confirmarExclusao(context, perfil),
                ),
              ],
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}
