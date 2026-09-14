import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controllers/calculator_controller.dart';
import 'theme/calculator_theme.dart';
import 'widgets/calculator_display.dart';
import 'widgets/history_drawer.dart';
import 'widgets/tactile_button.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: StitchColors.surface,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const StitchCalculatorApp());
}

class StitchCalculatorApp extends StatelessWidget {
  const StitchCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rimon Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: StitchColors.surface,
        colorScheme: ColorScheme.fromSeed(
          seedColor: StitchColors.primary,
          surface: StitchColors.surface,
        ),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  late final CalculatorController _controller;
  bool _isScientificMode = false;

  @override
  void initState() {
    super.initState();
    _controller = CalculatorController();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onKey(String key) {
    _controller.onKeyPressed(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StitchColors.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  // App Bar / Top Navigation
                  _buildHeader(),
                  const SizedBox(height: 10),

                  // Mode Switcher Pill Bar (Standard / Scientific / Angle)
                  _buildModeSwitcher(),
                  const SizedBox(height: 12),

                  // Realtime Calculation Display
                  CalculatorDisplay(
                    controller: _controller,
                    onOpenHistory: () => HistoryDrawer.show(context, _controller),
                  ),
                  const SizedBox(height: 16),

                  // Optional Scientific Extension Drawer/Row
                  if (_isScientificMode) ...[
                    _buildScientificRow(),
                    const SizedBox(height: 10),
                  ],

                  // Keypad Matrix
                  Expanded(
                    child: _buildKeypadGrid(),
                  ),

                  // Android styled navigation pill handle indicator
                  Center(
                    child: Container(
                      width: 120,
                      height: 4,
                      margin: const EdgeInsets.only(top: 8, bottom: 6),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(51, 19, 27, 46),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: StitchColors.primaryFixed,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.calculate_rounded,
                  size: 20,
                  color: StitchColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Rimon Calculator',
                style: StitchTypography.titleLg().copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => HistoryDrawer.show(context, _controller),
            icon: const Icon(
              Icons.history_rounded,
              color: StitchColors.onSurfaceVariant,
            ),
            tooltip: 'History',
          ),
        ],
      ),
    );
  }

  Widget _buildModeSwitcher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Mode Switcher Pill
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: StitchColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _modeTabButton(
                title: 'Standard',
                isSelected: !_isScientificMode,
                onTap: () {
                  setState(() => _isScientificMode = false);
                },
              ),
              _modeTabButton(
                title: 'Sci',
                isSelected: _isScientificMode,
                onTap: () {
                  setState(() => _isScientificMode = true);
                },
              ),
            ],
          ),
        ),

        // DEG / RAD toggle chip
        InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            _controller.toggleAngleMode();
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: StitchColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _controller.angleMode == AngleMode.deg ? 'DEG' : 'RAD',
                  style: StitchTypography.labelMd(
                    color: StitchColors.primary,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.swap_horiz_rounded,
                  size: 15,
                  color: StitchColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _modeTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? StitchColors.surfaceContainerLowest : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color.fromARGB(15, 19, 27, 46),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: StitchTypography.labelMd(
            color: isSelected ? StitchColors.primary : StitchColors.onSurfaceVariant,
          ).copyWith(fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildScientificRow() {
    final funcs = ['sin', 'cos', 'tan', 'ln', 'log', '√', 'π', '^'];
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: funcs.length,
        separatorBuilder: (ctx, idx) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final fn = funcs[i];
          return TactileButton(
            label: fn,
            height: 42,
            width: 54,
            fontSize: 15,
            variant: TactileButtonVariant.function,
            onTap: () => _onKey(fn),
          );
        },
      ),
    );
  }

  Widget _buildKeypadGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 10.0;

        return Column(
          children: [
            // Row 1: AC, (), %, ÷
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TactileButton(
                      label: 'AC',
                      variant: TactileButtonVariant.destructive,
                      height: double.infinity,
                      onTap: () => _onKey('AC'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '( )',
                      variant: TactileButtonVariant.function,
                      height: double.infinity,
                      onTap: () => _onKey('()'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '%',
                      variant: TactileButtonVariant.function,
                      height: double.infinity,
                      onTap: () => _onKey('%'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '÷',
                      variant: TactileButtonVariant.operator,
                      height: double.infinity,
                      fontSize: 28,
                      onTap: () => _onKey('÷'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: spacing),

            // Row 2: 7, 8, 9, ×
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TactileButton(
                      label: '7',
                      height: double.infinity,
                      onTap: () => _onKey('7'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '8',
                      height: double.infinity,
                      onTap: () => _onKey('8'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '9',
                      height: double.infinity,
                      onTap: () => _onKey('9'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '×',
                      variant: TactileButtonVariant.operator,
                      height: double.infinity,
                      fontSize: 26,
                      onTap: () => _onKey('×'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: spacing),

            // Row 3: 4, 5, 6, −
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TactileButton(
                      label: '4',
                      height: double.infinity,
                      onTap: () => _onKey('4'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '5',
                      height: double.infinity,
                      onTap: () => _onKey('5'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '6',
                      height: double.infinity,
                      onTap: () => _onKey('6'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '−',
                      variant: TactileButtonVariant.operator,
                      height: double.infinity,
                      fontSize: 28,
                      onTap: () => _onKey('−'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: spacing),

            // Row 4: 1, 2, 3, +
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TactileButton(
                      label: '1',
                      height: double.infinity,
                      onTap: () => _onKey('1'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '2',
                      height: double.infinity,
                      onTap: () => _onKey('2'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '3',
                      height: double.infinity,
                      onTap: () => _onKey('3'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '+',
                      variant: TactileButtonVariant.operator,
                      height: double.infinity,
                      fontSize: 28,
                      onTap: () => _onKey('+'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: spacing),

            // Row 5: 0, ., ⌫, =
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TactileButton(
                      label: '0',
                      height: double.infinity,
                      onTap: () => _onKey('0'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '.',
                      height: double.infinity,
                      fontSize: 30,
                      onTap: () => _onKey('.'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '⌫',
                      icon: const Icon(
                        Icons.backspace_outlined,
                        size: 24,
                        color: StitchColors.onSurface,
                      ),
                      variant: TactileButtonVariant.function,
                      height: double.infinity,
                      onTap: () => _onKey('BACKSPACE'),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: TactileButton(
                      label: '=',
                      variant: TactileButtonVariant.primaryAction,
                      height: double.infinity,
                      fontSize: 30,
                      onTap: () => _onKey('='),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
