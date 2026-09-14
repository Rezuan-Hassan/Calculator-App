import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/calculator_controller.dart';
import '../theme/calculator_theme.dart';

class CalculatorDisplay extends StatelessWidget {
  final CalculatorController controller;
  final VoidCallback onOpenHistory;

  const CalculatorDisplay({
    super.key,
    required this.controller,
    required this.onOpenHistory,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: controller.primaryDisplay));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Copied ${controller.primaryDisplay} to clipboard',
          style: StitchTypography.bodyMd(color: Colors.white),
        ),
        backgroundColor: StitchColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedPrimary = CalculatorController.formatForDisplay(controller.primaryDisplay);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < -100) {
          // Swipe left: trigger backspace
          HapticFeedback.mediumImpact();
          controller.backspace();
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: StitchColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          boxShadow: StitchColors.cardInsetShadow,
          border: Border.all(
            color: const Color.fromARGB(89, 199, 196, 216),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // Ambient Soft Glow inside display
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(64, 195, 192, 255),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top control bar inside display: Copy badge, Clear tape, History
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Mode / History badge
                    InkWell(
                      onTap: onOpenHistory,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: StitchColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.history_rounded,
                              size: 15,
                              color: StitchColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'History (${controller.history.length})',
                              style: StitchTypography.labelMd(
                                color: StitchColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Quick Action Badges
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _copyToClipboard(context),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: StitchColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.content_copy_rounded,
                                  size: 14,
                                  color: StitchColors.onSurfaceVariant,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Copy',
                                  style: StitchTypography.labelMd(
                                    color: StitchColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            controller.clearTape();
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: StitchColors.surfaceContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.clear_all_rounded,
                              size: 16,
                              color: StitchColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Expression Line
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    controller.expressionDisplay.isEmpty
                        ? ' '
                        : controller.expressionDisplay,
                    style: StitchTypography.bodyLg(
                      color: StitchColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                // Primary Output Readout
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    formattedPrimary,
                    style: StitchTypography.displayMobile(
                      color: StitchColors.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Ans Memory Chip & Swipe Hint
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(178, 225, 224, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.bookmark_added_rounded,
                            size: 13,
                            color: StitchColors.onSecondaryFixedVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Ans = ${CalculatorController.formatForDisplay(controller.lastResult)}',
                            style: StitchTypography.labelMd(
                              color: StitchColors.onSecondaryFixedVariant,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.swipe_left_rounded,
                          size: 14,
                          color: StitchColors.outline,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Swipe back',
                          style: StitchTypography.labelMd(
                            color: StitchColors.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
