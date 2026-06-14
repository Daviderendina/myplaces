import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/shared/widgets/app_button.dart';
import 'package:myplaces/shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/my_emoji_picker.dart';
import '../../providers.dart';

class AddCollectionModal extends ConsumerStatefulWidget {
  const AddCollectionModal({super.key});

  @override
  ConsumerState<AddCollectionModal> createState() => _AddCollectionModalState();
}

class _AddCollectionModalState extends ConsumerState<AddCollectionModal> {
  final _nameController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isSaving = true);

    final success = await ref.read(collectionsControllerProvider.notifier).addCollection(name);

    if (!mounted) return;

    setState(() => _isSaving = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Collezione salvata con successo!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Errore durante il salvataggio'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // TODO definire per bene questi spazi per fare una cosa standard su tutta la app

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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nuova Collezione',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      AppTextField(
                        label: 'NOME COLLEZIONE',
                        hintText: 'Inserisci un nome...',
                        controller: _nameController,
                      ),
                      Expanded(child: MyEmojiPicker()),
                      SizedBox(height: height * 0.06),
                      AppButton(text: 'SALVA', isLoading: _isSaving, onPressed: _handleSave),
                      const SizedBox(height: 16),
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
