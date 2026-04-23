import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_estudos_app/src/core/shared/constantes.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';
import 'package:match_estudos_app/src/features/sessao/model/sessao_model.dart';
import 'package:match_estudos_app/src/features/sessao/viewmodel/sessao_viewmodel.dart';
import 'package:provider/provider.dart';

class SessaoFormView extends StatefulWidget {
  final SessaoModel? sessao;

  const SessaoFormView({super.key, this.sessao});

  @override
  State<SessaoFormView> createState() => _SessaoFormViewState();
}

class _SessaoFormViewState extends State<SessaoFormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _tituloCtrl;
  late final TextEditingController _duracaoCtrl;
  late final TextEditingController _vagasCtrl;

  String? _disciplinaSelecionada;
  String? _nivelSelecionado;
  String? _estiloSelecionado;
  DateTime? _dataHoraInicio;

  bool _salvando = false;

  bool get _isEditing => widget.sessao != null;

  static const _disciplinas = [
    'Algoritmos', 'Estrutura de Dados', 'Banco de Dados',
    'Redes', 'Sistemas Operacionais', 'Engenharia de Software',
    'Matemática', 'Física', 'Cálculo', 'Outros',
  ];
  static const _niveis = ['fácil', 'médio', 'difícil'];
  static const _estilos = ['silencioso', 'colaborativo', 'argumentativo', 'visual'];

  @override
  void initState() {
    super.initState();
    final s = widget.sessao;
    _tituloCtrl = TextEditingController(text: s?.titulo ?? '');
    _duracaoCtrl = TextEditingController(text: s?.duracaoMinutos?.toString() ?? '');
    _vagasCtrl = TextEditingController(text: s?.vagas?.toString() ?? '');
    _disciplinaSelecionada = s?.disciplina;
    _nivelSelecionado = s?.nivel;
    _estiloSelecionado = s?.estilo;
    if (s?.dataHoraInicio != null) {
      _dataHoraInicio = DateTime.tryParse(s!.dataHoraInicio!);
    }
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _duracaoCtrl.dispose();
    _vagasCtrl.dispose();
    super.dispose();
  }

  Future<void> _selecionarDataHora() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataHoraInicio ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (ctx, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(primary: primaryColor),
        ),
        child: child!,
      ),
    );
    if (data == null || !mounted) return;

    final hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dataHoraInicio ?? DateTime.now()),
      builder: (ctx, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(primary: primaryColor),
        ),
        child: child!,
      ),
    );
    if (hora == null || !mounted) return;

    setState(() {
      _dataHoraInicio = DateTime(data.year, data.month, data.day, hora.hour, hora.minute);
    });
  }

  String _formatarDataHora(DateTime? dt) {
    if (dt == null) return 'Selecionar data e hora';
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dataHoraInicio == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Selecione a data e hora de início'),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _salvando = true);

    final vm = context.read<SessaoViewModel>();
    final novaSessao = SessaoModel(
      id: widget.sessao?.id,
      titulo: _tituloCtrl.text.trim(),
      disciplina: _disciplinaSelecionada,
      nivel: _nivelSelecionado,
      estilo: _estiloSelecionado,
      dataHoraInicio: _dataHoraInicio!.toIso8601String(),
      duracaoMinutos: int.tryParse(_duracaoCtrl.text.trim()),
      vagas: int.tryParse(_vagasCtrl.text.trim()),
    );

    try {
      if (_isEditing) {
        await vm.editarSessao(widget.sessao!.id!, novaSessao);
      } else {
        await vm.addSessao(novaSessao);
      }
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing ? 'Sessão atualizada com sucesso!' : 'Sessão criada com sucesso!'),
            backgroundColor: primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar sessão: $e'),
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
          _isEditing ? 'Editar Sessão' : 'Nova Sessão',
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
              icon: Icons.info_outline_rounded,
              title: 'Informações da Sessão',
              children: [
                _buildTextField(
                  controller: _tituloCtrl,
                  label: 'Título',
                  hint: 'Ex: Revisão de Grafos',
                  icon: Icons.title_rounded,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe o título' : null,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Disciplina',
                  icon: Icons.book_rounded,
                  value: _disciplinaSelecionada,
                  items: _disciplinas,
                  onChanged: (v) => setState(() => _disciplinaSelecionada = v),
                  validator: (v) => v == null ? 'Selecione a disciplina' : null,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSection(
              icon: Icons.tune_rounded,
              title: 'Configurações',
              children: [
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
            const SizedBox(height: 20),
            _buildSection(
              icon: Icons.schedule_rounded,
              title: 'Data, Hora e Vagas',
              children: [
                // Seletor de data/hora
                GestureDetector(
                  onTap: _selecionarDataHora,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F7F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _dataHoraInicio == null ? Colors.grey[300]! : primaryColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, color: primaryColor, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _formatarDataHora(_dataHoraInicio),
                            style: TextStyleMatchEstudo.bodySM(
                              color: _dataHoraInicio == null ? Colors.grey[400] : const Color(0xFF2E2E2E),
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: Colors.grey[400], size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _duracaoCtrl,
                        label: 'Duração (min)',
                        hint: 'Ex: 60',
                        icon: Icons.timer_rounded,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Informe a duração';
                          final n = int.tryParse(v);
                          if (n == null || n <= 0) return 'Duração inválida';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _vagasCtrl,
                        label: 'Vagas',
                        hint: 'Ex: 5',
                        icon: Icons.people_rounded,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Informe as vagas';
                          final n = int.tryParse(v);
                          if (n == null || n <= 0) return 'Vagas inválidas';
                          return null;
                        },
                      ),
                    ),
                  ],
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                icon: _salvando
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Icon(_isEditing ? Icons.save_rounded : Icons.add_circle_rounded),
                label: Text(
                  _salvando ? 'Salvando...' : (_isEditing ? 'Salvar alterações' : 'Criar sessão'),
                  style: TextStyleMatchEstudo.titleXS(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required IconData icon, required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(title, style: TextStyleMatchEstudo.titleXS(color: primaryColor)),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryColor, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red[400]!)),
        filled: true,
        fillColor: const Color(0xFFF9F7F5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryColor, width: 2)),
        filled: true,
        fillColor: const Color(0xFFF9F7F5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
    );
  }
}
