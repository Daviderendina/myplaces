import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/controllers/add_collection_controller.dart';
import 'package:myplaces/shared/widgets/large_button.dart';
import 'package:myplaces/shared/widgets/app_snack_bar.dart';
import 'package:myplaces/shared/widgets/form/app_text_field.dart';
import 'package:myplaces/shared/widgets/form/generic_form_field.dart';
import '../../../shared/widgets/emoji/my_emoji_picker.dart';
import '../providers.dart';

class AddCollectionModal extends ConsumerStatefulWidget {
  const AddCollectionModal({super.key});

  @override
  ConsumerState<AddCollectionModal> createState() => _AddCollectionModalState();
}

class _AddCollectionModalState extends ConsumerState<AddCollectionModal> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final controller = ref.read(addCollectionControllerProvider.notifier);

    // Sincronizzo il valore del controller locale con lo stato del Notifier
    controller.setValues(name: _nameController.text);

    ValidationStatus validationStatus = controller.validateValues();
    if (validationStatus.isValid) {
      final success = await controller.saveCollection();

      if (mounted && success) {
        AppSnackBar.success(context, 'Collezione salvata con successo!');
        Navigator.pop(context);
      }
    } else {
      AppSnackBar.warn(context, validationStatus.error!);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final state = ref.watch(addCollectionControllerProvider);
    final controller = ref.read(addCollectionControllerProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Padding(
                  padding: AppLayout.getFullscreenModalPadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nuova Collezione',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
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
                          onEmojiSelected: (emoji) =>
                              controller.setValues(emoji: emoji),
                        ),
                      ),

                      const Spacer(),

                      LargeButton(
                        text: 'SALVA',
                        isLoading: state.isSaving,
                        onPressed: _handleSave,
                      ),
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
