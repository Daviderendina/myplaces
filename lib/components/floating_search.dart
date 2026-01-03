import 'dart:async';
import 'package:flutter/material.dart';

class FloatingSearch extends StatefulWidget {
  final Future<List<String>> Function(String query) onSearch;
  final void Function(String result) onSelect;

  const FloatingSearch({
    required this.onSearch,
    required this.onSelect,
    super.key,
  });

  @override
  State<FloatingSearch> createState() => _FloatingSearchState();
}

class _FloatingSearchState extends State<FloatingSearch> {
  List<String> results = [];
  bool showResults = false;
  Timer? _debounce;

  void _onQueryChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 350), () async {
      if (query.isEmpty) {
        setState(() {
          results = [];
          showResults = false;
        });
        return;
      }

      final res = await widget.onSearch(query);

      setState(() {
        results = res;
        showResults = res.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Column(
        children: [
          // CARD UNICA: barra + lista
          Material(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                // 🔍 Search bar
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Cerca...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  onChanged: _onQueryChanged,
                ),

                if (showResults)
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        print("TAPPED");
                        setState(() => showResults = false);
                      },
                    ),
                  ),

                // 📄 Risultati attaccati alla barra
                if (showResults)
                  Container(
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (_, i) {
                        return ListTile(
                          title: Text(
                            results[i],
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            widget.onSelect(results[i]);
                            setState(() => showResults = false);
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
