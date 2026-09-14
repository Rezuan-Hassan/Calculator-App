---
name: Tactile Modern Calculator
colors:
  surface: '#faf8ff'
  surface-dim: '#d2d9f4'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e2e7ff'
  surface-container-highest: '#dae2fd'
  on-surface: '#131b2e'
  on-surface-variant: '#464555'
  inverse-surface: '#283044'
  inverse-on-surface: '#eef0ff'
  outline: '#777587'
  outline-variant: '#c7c4d8'
  surface-tint: '#4d44e3'
  primary: '#3525cd'
  on-primary: '#ffffff'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#4648d4'
  on-secondary: '#ffffff'
  secondary-container: '#6063ee'
  on-secondary-container: '#fffbff'
  tertiary: '#95002b'
  on-tertiary: '#ffffff'
  tertiary-container: '#bf0f3c'
  on-tertiary-container: '#ffd0d2'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#e1e0ff'
  secondary-fixed-dim: '#c0c1ff'
  on-secondary-fixed: '#07006c'
  on-secondary-fixed-variant: '#2f2ebe'
  tertiary-fixed: '#ffdadb'
  tertiary-fixed-dim: '#ffb2b7'
  on-tertiary-fixed: '#40000d'
  on-tertiary-fixed-variant: '#92002a'
  background: '#faf8ff'
  on-background: '#131b2e'
  surface-variant: '#dae2fd'
typography:
  display-lg:
    fontFamily: Roboto Flex
    fontSize: 56px
    fontWeight: '300'
    lineHeight: 64px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Roboto Flex
    fontSize: 40px
    fontWeight: '400'
    lineHeight: 48px
    letterSpacing: -0.02em
  display-md:
    fontFamily: Roboto Flex
    fontSize: 36px
    fontWeight: '400'
    lineHeight: 44px
    letterSpacing: -0.01em
  display-md-mobile:
    fontFamily: Roboto Flex
    fontSize: 28px
    fontWeight: '400'
    lineHeight: 36px
    letterSpacing: -0.01em
  headline-lg:
    fontFamily: Roboto Flex
    fontSize: 32px
    fontWeight: '500'
    lineHeight: 40px
  headline-md:
    fontFamily: Roboto Flex
    fontSize: 24px
    fontWeight: '500'
    lineHeight: 32px
  title-lg:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  title-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-keypad:
    fontFamily: Roboto Flex
    fontSize: 24px
    fontWeight: '500'
    lineHeight: 28px
  label-keypad-sm:
    fontFamily: Roboto Flex
    fontSize: 18px
    fontWeight: '500'
    lineHeight: 22px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.02em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 0.75rem
  gutter-desktop: 1rem
  margin: 1rem
  margin-tablet: 1.5rem
  margin-desktop: 2rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
---

## Brand & Style

This design system establishes a focused, tactile, and mathematically precise utility aesthetic rooted in Material 3 and Flutter paradigms. Designed for modern high-density touch displays, the visual identity balances functional utility with expressive physical feedback. 

The aesthetic is characterized by:
- **Material Utility:** Uncluttered layouts where numerical data and actionable operations are immediately discernible without visual noise.
- **Physical Tactility:** Micro-elevations, multi-layered ambient light rendering, and squircle geometries that provide a physical "click" impression on flat glass.
- **Operational Clarity:** High-contrast slate typography against pristine surfaces, punctuated by vivid indigo logic operators and alert-level rose modifiers to prevent misfires during rapid data entry.

## Colors

The color architecture is built around functional hierarchy, separating canvas foundation, resting tactile surfaces, numerical inputs, and computational operations.

- **Canvas & Surface Tier:**
  - `canvas`: `#F8F9FA` acts as the low-contrast foundational backdrop, providing comfortable viewing under varied ambient lighting.
  - `surface-elevated`: `#FFFFFF` forms the resting background of all tactile squircle keys, cards, and modal sheets.
  - `surface-subtle`: `#EEF2F6` provides subtle inset separation for expression display fields and secondary tool groupings.

- **Brand & Operator Accents:**
  - `primary` (`#4F46E5`): Reserved for high-priority operational controls (equals, major scientific functions) and primary application calls to action.
  - `secondary` (`#6366F1`): Utilized for standard arithmetic operators (`+`, `−`, `×`, `÷`) and active segmented state toggles.
  - `tertiary` (`#F43F5E`): Used strictly for destructive, state-clearing, or volatile interactions (`AC`, `C`, delete/backspace).

- **Typography & Neutral Tokens:**
  - `neutral-primary` (`#0F172A`): Deep slate for primary numerical readouts, totals, and primary key glyphs.
  - `neutral-secondary` (`#334155`): Muted slate for sub-expressions, history breadcrumbs, and non-numeric modifiers.
  - `neutral-tertiary` (`#64748B`): Light slate for inactive states, units, and timestamp markers.

## Typography

The typography pairs `Roboto Flex` for display readouts and keycaps with `Inter` for supporting application metadata, histories, and configuration panels.

- **Tabular Alignment:** All numerals rendered within `display-lg`, `display-md`, and `label-keypad` must enforce tabular figures (`font-variant-numeric: tabular-nums;`) to prevent layout shifts during input streaming.
- **Dynamic Downscaling:** For calculations exceeding the standard display width, `display-lg-mobile` smoothly scales down to `headline-lg` before applying truncation ellipsis or right-aligned overflow scrolling.
- **Legibility Rules:** Letter-spacing is tightened on display sizes to group numbers naturally into legible numerical values, while operational glyphs within `label-keypad` use normalized mechanical tracking.

## Layout & Spacing

The layout is optimized around vertical reachability and physical thumb arcs on handheld screens:

- **Keypad Matrix:** Formed using an 8pt architectural grid with uniform gutters (`0.75rem` / `12px` on mobile, expanding to `1rem` / `16px` on wider breakpoints). Keypads strictly enforce equal cell aspect ratios (minimum 1:1 or squircular 1.1:1 height-to-width).
- **Display vs. Controls Distribution:** On mobile portrait orientations, the readout view occupies the top 35% to 42% of the viewport height, anchoring all functional interactive keys firmly within the lower thumb reach zone.
- **Adaptation Rules:**
  - **Mobile (<600px):** Single-column stack consisting of the upper display zone and the bottom 4x5 or 5x5 keypad matrix.
  - **Tablet (600px–1024px):** Displays can switch to a split layout with standard arithmetic on the right and an expanded scientific / conversions panel on the left.
  - **Desktop / Foldable Folded (>1024px):** Fixed-width centered modal or floating tactile calculator shell (max-width `440px`), surrounded by expansive `margin-desktop` gutters.

## Elevation & Depth

Tactility is conveyed through multi-layered ambient light modeling instead of heavy physical skeumorphism. Pure white elevated surfaces sit crisply atop the off-white canvas.

- **Resting Keys (Tactile Level 1):**
  Constructed using a compound dual-shadow technique that blends directional light with soft ambient fill:
  - Top highlight: `inset 0 1px 0 0 rgba(255, 255, 255, 0.9)`
  - Direct drop: `0 2px 4px 0 rgba(15, 23, 42, 0.04)`
  - Ambient dispersion: `0 6px 12px -2px rgba(15, 23, 42, 0.06)`
- **Pressed Keys (Active State):**
  Keys compress into the canvas surface upon pointer activation:
  - Elevation collapses to `0 1px 2px 0 rgba(15, 23, 42, 0.05)`.
  - Transform scales keys subtly to `0.97` with an internal color tint overlay of `rgba(15, 23, 42, 0.04)`.
- **Raised Action Controls (Equals / Accent):**
  Colored primary buttons project a tinted chromatic ambient shadow:
  - Ambient glow: `0 8px 16px -4px rgba(79, 70, 229, 0.35)`
  - Contact drop: `0 3px 6px -1px rgba(79, 70, 229, 0.2)`
- **Overlays and Sheets (Level 2):**
  Modal history surfaces and unit selector flyouts utilize soft deep dispersion:
  - Shadow: `0 20px 25px -5px rgba(15, 23, 42, 0.08), 0 8px 10px -6px rgba(15, 23, 42, 0.04)`.

## Shapes

The design system uses Level 2 roundedness (base `0.5rem` / `8px`), scaling to higher continuous squircle curves for primary touch surfaces:

- **Tactile Keycaps:** Use `rounded-lg` (`1rem` / `16px`) up to continuous squircle `1.5rem` (`24px`) depending on key cluster density, producing a smooth, pebble-like interactive element that avoids rigid square corners.
- **Display Modules & Calculation Trays:** Outlined with `rounded-xl` (`1.5rem` / `24px`) borders to frame values within clean structural pockets.
- **Pills & Toggles:** Radian/Degree switches and scientific secondary tabs utilize full capsule radii (`rounded-full`) to differentiate mode toggles from momentary calculation buttons.

## Components

### Buttons & Keycaps
- **Numeric Keys:** `#FFFFFF` background, `#0F172A` label text, resting compound shadow, `rounded-lg` to `rounded-xl` shape. Touch targets maintain a minimum dimension of 48px × 48px (ideally 64px+ on modern smartphones).
- **Operator Keys (`+`, `−`, `×`, `÷`):** Tinted soft surface (`#EEF2FF`) with `#4F46E5` icons or rich `#6366F1` background with white glyphs. Transitions to deeper indigo on active press.
- **Primary CTA (`=`):** Filled with solid `#4F46E5`, white bold typography, accompanied by the primary indigo ambient shadow.
- **Destructive/Clear Keys (`AC`, `C`):** Subtly tinted background (`#FFF1F2`) with `#F43F5E` glyphs, signaling immediate deletion without overwhelming the neutral keys.

### Display Surface
- Single non-interactive viewing container with right-aligned content layout.
- Stacked configuration: the previous equation or calculation tape appears at the top (`body-md` in `#64748B`), while current inputs and outputs render at the bottom (`display-lg-mobile` in `#0F172A`).
- Supports horizontal back-swipe gestures directly on the display area to trigger single-character deletion.

### Segmented Buttons & Chips
- Used for mode switching (e.g., `DEG`/`RAD` toggles, `DEC`/`HEX`/`BIN`).
- Housed inside an inset track with background `#EEF2F6` and 4px internal padding. The active chip lifts onto `#FFFFFF` with Level 1 tactile elevation.

### Calculation History Drawer
- Bottom sheet slide-up component using pure white surface, pinned top drag-handle, and Level 2 elevation.
- List items feature two-line layout: calculation timestamp & expression in `#64748B`, with evaluated outcome in `#0F172A` bold.
- Tapping any historical record restores the calculation back into the live display.

### Modifiers & Toggle Controls
- Scientific extension panel includes functions like `sin`, `cos`, `tan`, `log`, `π`, `√`.
- Rendered in slightly scaled-down keypads with `label-keypad-sm` typography and secondary neutral surface fills to visually delineate them from the primary 0-9 numerical cluster.