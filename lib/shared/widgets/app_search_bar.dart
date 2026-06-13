import 'dart:async';
import 'package:flutter/material.dart';

class GenericSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onSearch;

  const GenericSearchBar({super.key, this.hintText = 'Cerca...', required this.onSearch});

  @override
  State<GenericSearchBar> createState() => _GenericSearchBarState();
}

class _GenericSearchBarState extends State<GenericSearchBar> {
  final SearchController _controller = SearchController(); // Usiamo SearchController

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String query) {
    widget.onSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return SearchBar(
      // textStyle
      constraints: BoxConstraints(minHeight: height * 0.055, minWidth: width),
      controller: _controller,
      hintText: widget.hintText,
      onChanged: _onChanged,
      leading: const Icon(Icons.search),
      trailing: [
        if (_controller.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              _onChanged('');
            },
          ),
      ],
    );
  }
}
