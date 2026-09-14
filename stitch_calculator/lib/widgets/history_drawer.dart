import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/calculator_controller.dart';
import '../theme/calculator_theme.dart';

class HistoryDrawer extends StatelessWidget {
  final CalculatorController controller;

  const HistoryDrawer({super.key, required this.controller});

  static void show(BuildContext context, CalculatorController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => HistoryDrawer(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final history = controller.history;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: const BoxDecoration(
        color: StitchColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.12),
            offset: Offset(0, -6),
            blurRadius: 24,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag indicator handle
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: StitchColors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.history_rounded,
                        color: StitchColors.primary,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Calculation History',
                        style: StitchTypography.titleLg(),
                      ),
                    ],
                  ),
                  if (history.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        controller.clearHistory();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.delete_sweep_rounded,
                        size: 18,
                        color: StitchColors.tertiary,
                      ),
                      label: Text(
                        'Clear',
                        style: StitchTypography.labelMd(
                          color: StitchColors.tertiary,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: StitchColors.tertiaryFixed,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 24, thickness: 1, color: StitchColors.surfaceContainerHigh),

            // History list
            Flexible(
              child: history.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calculate_outlined,
                            size: 54,
                            color: StitchColors.outlineVariant,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No calculations recorded yet',
                            style: StitchTypography.bodyLg(
                              color: StitchColors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your calculations will appear here',
                            style: StitchTypography.bodyMd(
                              color: StitchColors.outline,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: history.length,
                      separatorBuilder: (ctx, idx) => const Divider(
                        height: 1,
                        color: StitchColors.surfaceContainerLow,
                      ),
                      itemBuilder: (context, index) {
                        final item = history[index];
                        final timeStr = DateFormat('h:mm a').format(item.timestamp);

                        return InkWell(
                          onTap: () {
                            controller.restoreFromHistory(item);
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.expression,
                                        style: StitchTypography.bodyMd(
                                          color: StitchColors.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '= ${CalculatorController.formatForDisplay(item.result)}',
                                        style: StitchTypography.keypadLabel(
                                          color: StitchColors.primary,
                                        ).copyWith(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      timeStr,
                                      style: StitchTypography.labelMd(
                                        color: StitchColors.outline,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Icon(
                                      Icons.touch_app_rounded,
                                      size: 16,
                                      color: StitchColors.outlineVariant,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
