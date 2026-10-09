import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BottomAppBar(
      height: 72,
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () => onDestinationSelected(0),
              icon: Icon(
                selectedIndex == 0
                    ? CupertinoIcons.house_fill
                    : CupertinoIcons.house,
                color: selectedIndex == 0
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 72),
          Expanded(
            child: IconButton(
              tooltip: 'Learning',
              onPressed: () => onDestinationSelected(1),
              icon: Icon(
                selectedIndex == 1
                    ? CupertinoIcons.book_fill
                    : CupertinoIcons.book,
                color: selectedIndex == 1
                    ? colors.primary
                    : colors.onSurfaceVariant,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
