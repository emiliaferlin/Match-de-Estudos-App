import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_estudos_app/src/core/shared/constantes.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';
import 'package:match_estudos_app/src/features/perfil/model/perfil_model.dart';
import 'package:match_estudos_app/src/features/perfil/viewmodel/perfil_viewmodel.dart';
import 'package:provider/provider.dart';

class PerfilFormView extends StatefulWidget {
  final PerfilModel? perfil;

  const PerfilFormView({super.key, this.perfil});

  @override
  State<PerfilFormView> createState() => _PerfilFormViewState();
}

class _PerfilFormViewState extends State<PerfilFormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeCtrl;
  late final TextEditingController _idadeCtrl;

  String? _disciplinaSelecionada;
  String? _nivelSelecionado;
  String? _estiloSelecionado;

  bool _salvando = false;

  bool get _isEditing => widget.perfil != null;

  static const _disciplinas = [
    'Algoritmos',
    'Estrutura de Dados',
    'Banco de Dados',
    'Redes',
    'Sistemas Operacionais',
    'Engenharia de Software',
    'Matemática',
    'Física',
    'Cálculo',
    'Outros',
  ];

  static const _niveis = ['iniciante', 'intermediário', 'avançado'];
  static const _estilos = [
    'silencioso',
    'colaborativo',
    'argumentativo',
    'visual',
  ];

  @override
  void initState() {
    super.initState();
    final p = widget.perfil;
    _nomeCtrl = TextEditingController(text: p?.nome ?? '');
    _idadeCtrl = TextEditingController(text: p?.idade?.toString() ?? '');
    _disciplinaSelecionada = p?.disciplina;
    _nivelSelecionado = p?.nivel;
    _estiloSelecionado = p?.estilo;
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _idadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);

    final vm = context.read<PerfilViewModel>();
    final novoPerfil = PerfilModel(
      id: widget.perfil?.id,
      nome: _nomeCtrl.text.trim(),
      idade: int.tryParse(_idadeCtrl.text.trim()),
      disciplina: _disciplinaSelecionada,
      nivel: _nivelSelecionado,
      estilo: _estiloSelecionado,
    );

    try {
      if (_isEditing) {
        await vm.editarPerfil(widget.perfil!.id!, novoPerfil);
      } else {
        await vm.addPerfil(novoPerfil);
      }
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing
                  ? 'Perfil atualizado com sucesso!'
                  : 'Perfil criado com sucesso!',
            ),
            backgroundColor: primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar perfil: $e'),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F0),
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar Perfil' : 'Novo Perfil',
          style: TextStyleMatchEstudo.titleSM(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildSection(
              icon: Icons.person_rounded,
              title: 'Informações Pessoais',
              children: [
                _buildTextField(
                  controller: _nomeCtrl,
                  label: 'Nome completo',
                  hint: 'Ex: Ana Silva',
                  icon: Icons.badge_rounded,
                  validator:
                      (v) =>
                          (v == null || v.trim().isEmpty)
                              ? 'Informe o nome'
                              : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _idadeCtrl,
                  label: 'Idade',
                  hint: 'Ex: 22',
                  icon: Icons.cake_rounded,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Informe a idade';
                    final n = int.tryParse(v);
                    if (n == null || n < 10 || n > 100) return 'Idade inválida';
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSection(
              icon: Icons.school_rounded,
              title: 'Preferências de Estudo',
              children: [
                _buildDropdown(
                  label: 'Disciplina',
                  icon: Icons.book_rounded,
                  value: _disciplinaSelecionada,
                  items: _disciplinas,
                  onChanged: (v) => setState(() => _disciplinaSelecionada = v),
                  validator: (v) => v == null ? 'Selecione a disciplina' : null,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Nível',
                  icon: Icons.bar_chart_rounded,
                  value: _nivelSelecionado,
                  items: _niveis,
                  onChanged: (v) => setState(() => _nivelSelecionado = v),
                  validator: (v) => v == null ? 'Selecione o nível' : null,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Estilo de estudo',
                  icon: Icons.psychology_rounded,
                  value: _estiloSelecionado,
                  items: _estilos,
                  onChanged: (v) => setState(() => _estiloSelecionado = v),
                  validator: (v) => v == null ? 'Selecione o estilo' : null,
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _salvando ? null : _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: primaryColor.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                icon:
                    _salvando
                        ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Icon(
                          _isEditing
                              ? Icons.save_rounded
                              : Icons.add_circle_rounded,
                        ),
                label: Text(
                  _salvando
                      ? 'Salvando...'
                      : (_isEditing ? 'Salvar alterações' : 'Criar perfil'),
                  style: TextStyleMatchEstudo.titleXS(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyleMatchEstudo.titleXS(color: primaryColor),
              ),
            ],
          ),
          const Divider(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: TextStyleMatchEstudo.bodySM(),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: primaryColor, size: 20),
        labelStyle: TextStyleMatchEstudo.bodySM(color: Colors.grey[600]),
        hintStyle: TextStyleMatchEstudo.bodySM(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red[400]!),
        ),
        filled: true,
        fillColor: const Color(0xFFF9F7F5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      validator: validator,
      onChanged: onChanged,
      style: TextStyleMatchEstudo.bodySM(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor, size: 20),
        labelStyle: TextStyleMatchEstudo.bodySM(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF9F7F5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      items:
          items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
    );
  }
}
