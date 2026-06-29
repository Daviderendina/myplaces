import 'package:flutter/material.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/tools/extension/title_case_extension.dart';

import '../../../../src/presentation/ui/list/visual_symbol_visualizer.dart';

class SelectListPopupItem extends StatefulWidget {
  final MyList myList;
  final bool isEnabled;
  final ValueChanged<bool>? onChanged;

  const SelectListPopupItem({
    super.key,
    required this.myList,
    this.isEnabled = false,
    this.onChanged,
  });

  @override
  State<SelectListPopupItem> createState() => _SelectListPopupItemState();
}

class _SelectListPopupItemState extends State<SelectListPopupItem> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(isSelected);
        }
      },
      child: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),

            SizedBox(
              width: 35,
              height: 35,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: VisualSymbolVisualizer(
                    symbol: widget.myList.visualSymbol,
                    colored: isSelected,
                  ),
                ),
              ),
            ),

            SizedBox(width: 20),

            Expanded(
              child: Text(
                widget.myList.name.toTitleCase(),
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: isSelected ? Colors.white : Colors.white24,
                  fontSize: 16,
                ),
              ),
            ),

            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
