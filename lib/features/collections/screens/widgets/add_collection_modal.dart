import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/shared/widgets/app_button.dart';
import 'package:myplaces/shared/widgets/app_snack_bar.dart';
import 'package:myplaces/shared/widgets/form/app_text_field.dart';
import 'package:myplaces/shared/widgets/form/generic_form_field.dart';
import '../../../../shared/widgets/emoji/my_emoji_picker.dart';
import '../../providers.dart';

class AddCollectionModal extends ConsumerStatefulWidget {
  const AddCollectionModal({super.key});

  @override
  ConsumerState<AddCollectionModal> createState() => _AddCollectionModalState();
}

class _AddCollectionModalState extends ConsumerState<AddCollectionModal> {
  final _nameController = TextEditingController();
  bool _isSaving = false;
  String? _selectedEmoji;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!mounted) return;

    setState(() => _isSaving = true);

    String error = validateForm();
    if (error.isNotEmpty) {
      AppSnackBar.warn(context, error);
      setState(() => _isSaving = false);
      return;
    }

    String name = _nameController.text.trim();

    final success = await ref.read(collectionsControllerProvider.notifier).addCollection(name);

    setState(() => _isSaving = false);

    if (success) {
      AppSnackBar.success(context, 'Collezione salvata con successo!');
      Navigator.pop(context);
    } else {
      AppSnackBar.error(context, 'Errore durante il salvataggio');
    }
  }

  String validateForm() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return 'Inserisci il nome della collezione';

    if (_selectedEmoji == null) return 'Seleziona un emoji';

    return '';
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              Expanded(
                child: Padding(
                  padding: AppLayout.getFullscreenModalPadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nuova Collezione',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: AppLayout.form.getTitleSpacing(context)),

                      TextInputFormField(
                        label: 'Nome',
                        hintText: 'Inserisci il nome della collezione',
                        controller: _nameController,
                      ),

                      SizedBox(height: AppLayout.form.getFieldSpacing(context)),

                      GenericFormField(
                        label: "List emoji",
                        child: MyEmojiPicker(
                          height: height * .45,
                          onEmojiSelected: (emoji) => setState(() => _selectedEmoji = emoji),
                        ),
                      ),

                      const Spacer(),
                      AppButton(text: 'SALVA', isLoading: _isSaving, onPressed: _handleSave),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
