import 'package:flutter/material.dart';
import 'package:music/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({
    super.key,
    required this.child,
  });

@override
  Widget build(BuildContext context) {
    bool isDarkMode=Provider.of<ThemeProvider>(context).isDark;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black : Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),

          BoxShadow(
            color: isDarkMode ? Colors.grey.shade900 : Colors.white,
            blurRadius: 15,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}