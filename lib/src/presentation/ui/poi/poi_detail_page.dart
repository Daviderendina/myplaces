import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/presentation/ui/common/my_title.dart';
import 'package:myplaces/src/presentation/ui/common/note/note_box.dart';
import 'package:myplaces/src/presentation/ui/list/circular_flag_poi_marker.dart';
import '../../../tools/extension/title_case_extension.dart';
import 'package:myplaces/src/presentation/ui/poi/poi_button_list.dart';

import '../../../../src/domain/poi.dart';
import '../../../../src/domain/poi_image.dart';
import '../../../providers.dart';
import '../common/chips.dart';
import '../common/circular_icon_button.dart';
import '../common/my_subtitle.dart';
import '../common/note/note_dialog.dart';

class PoiDetailPage extends ConsumerStatefulWidget {
  const PoiDetailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PoiDetailPageState();
}

class PoiDetailPageState extends ConsumerState<PoiDetailPage> {
  @override
  Widget build(BuildContext context) {
    final images = [
      'https://picsum.photos/id/20/800/600',
      'https://picsum.photos/id/10/800/600',
      'https://picsum.photos/id/30/800/600',
    ];

    final poi = ref.watch(selectedPoiControllerProvider);

    if (poi == null) return SizedBox();

    poi.setImages(images.map(((i) => PoiImage(thumbnail: i))).toList());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 38),

            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    height: 420,
                    child: Image.network(
                      'https://media.istockphoto.com/id/635758088/photo/sunrise-at-the-eiffel-tower-in-paris-along-the-seine.jpg?s=612x612&w=0&k=20&c=rdy3aU1CDyh66mPyR5AAc1yJ0yEameR_v2vOXp2uuMM=',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  left: 8,
                  top: 8,
                  child: CircularIconButton(
                    icon: Icons.arrow_back_outlined,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),

                // TODO fare unico widget con il circularflag, e forse fare un widget unico circolare per tutti! che prende size SMALL MEDIUM LARGE e imposta delle dimensioni di default
                // DEVO fare una sorta di widget padre e tanti widget che utilizzano quello TODO
                if (poi.note.isEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircularIconButton(
                      icon: Icons.playlist_add,
                      onPressed: () => openNoteDialog(poi.note),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 28),
            Text(
              poi.name,
              style: const TextStyle(
                fontSize: 38,
                height: 1.1,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.6,
                color: Colors.white,
                decorationColor: Color(0xff907AE6),
                decorationThickness: 2,
              ),
            ),
            Text(
              poi.getDisplayAreaName(),
              style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
            ),

            SizedBox(height: 10),
            // TODO fare rettangolari belle
            Row(
              spacing: 8,
              children: [
                MyChip(title: poi.categoryName, icon: poi.category.icon),
                MyActionChip(title: "Phone", icon: Icons.phone, onTap: () {}),
                MyActionChip(title: "Website", icon: Icons.web, onTap: () {}),
              ],
            ),

            SizedBox(height: 16),

            Text(
              maxLines: poi.note.isNotEmpty ? 2 : 4,
              overflow: TextOverflow.ellipsis,
              "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi conLorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi con",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),

            SizedBox(height: 24),

            if (poi.note.isNotEmpty)
              NoteBox(
                actualNote: poi.note,
                onTap: () => openNoteDialog(poi.note),
              ),
            Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PoiButtonList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getInfoTextWithLeadingIcon(String text, Widget leading) {
    return Row(
      spacing: 15,
      children: [
        SizedBox(width: 20, height: 20, child: Center(child: leading)),
        Text(
          text.toTitleCase(),
          style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
        ),
      ],
    );
  }

  void openNoteDialog(String actualValue) {
    showNoteDialog(
      context,
      actualValue,
      (val) => ref.read(selectedPoiControllerProvider.notifier).updateNote(val),
    );
  }
}
