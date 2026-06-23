import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/src/presentation/ui/common/note/note_box.dart';
import '../../../../shared/widgets/circular_icon_button.dart';
import '../../../tools/extension/title_case_extension.dart';
import 'package:myplaces/src/presentation/ui/poi/poi_button_list.dart';

import '../../../../src/domain/poi_image.dart';
import '../../../providers.dart';
import '../common/chips.dart';
import '../common/note/note_dialog.dart';

class PoiDetailPage extends ConsumerStatefulWidget {
  const PoiDetailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PoiDetailPageState();
}

class PoiDetailPageState extends ConsumerState<PoiDetailPage> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://picsum.photos/800/600',
      'https://picsum.photos/200',
      'https://picsum.photos/800/600',
      'https://picsum.photos/400/600',
      'https://picsum.photos/800/600',
    ];

    final poi = ref.watch(selectedPoiControllerProvider);

    if (poi == null) return SizedBox();

    poi.setImages(images.map(((i) => PoiImage(thumbnail: i))).toList());

    return Scaffold(
      body: Padding(
        padding: AppLayout.getPagePadding(context),
        //const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 38),

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 420,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: false,
                      pageSnapping: true,

                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                    items: poi.images.map((poiImage) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(
                            poiImage.thumbnail ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(color: Colors.grey.shade900);
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade900,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.white30,
                                ),
                              );
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),

                // Indicatori (pallini)
                if (poi.images.length > 1)
                  Positioned(
                    bottom: 12.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: poi.images.asMap().entries.map((entry) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                      _currentImageIndex == entry.key
                                          ? 0.9
                                          : 0.4,
                                    ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                // Bottoni esistenti
                Positioned(
                  left: 8,
                  top: 8,
                  child: CircularIconButton(
                    icon: Icons.arrow_back_outlined,
                    onPressed: () => Navigator.of(context).pop(),
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
