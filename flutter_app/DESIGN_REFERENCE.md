# 🎨 Visual Design Reference

## Color Palette

### Primary Colors

```
Primary:        #007AFF  ████████  iOS Blue
Primary Dark:   #0051D5  ████████  Darker Blue
Primary Light:  #5AC8FA  ████████  Light Blue
```

### Light Mode

```
Background:     #F2F2F7  ████████  Light Gray
Card:           #FFFFFF  ████████  White
Text:           #000000  ████████  Black
Text Secondary: #8E8E93  ████████  Gray
Border:         #E5E5EA  ████████  Light Gray
```

### Dark Mode

```
Background:     #000000  ████████  True Black
Card:           #1C1C1E  ████████  Dark Gray
Text:           #FFFFFF  ████████  White
Text Secondary: #98989D  ████████  Gray
Border:         #38383A  ████████  Dark Gray
```

---

## Typography Scale

```
Display Large:    56px / Bold      Melodify
Display Medium:   34px / Bold      Page Titles
Display Small:    28px / Bold      Section Headers
Headline Large:   24px / SemiBold  Card Titles
Headline Medium:  20px / SemiBold  List Headers
Title Large:      18px / SemiBold  Item Titles
Title Medium:     17px / SemiBold  Buttons
Body Large:       17px / Regular   Body Text
Body Medium:      15px / Regular   Descriptions
Body Small:       13px / Regular   Captions
```

Font: **Inter** (via Google Fonts)

---

## Spacing System

```
4px   ·        Tiny gaps
8px   ··       Small spacing
12px  ···      Medium-small
16px  ····     Standard padding
24px  ······   Large spacing
32px  ········ Extra large
48px  ············ Section gaps
```

---

## Border Radius

```
Small:  12px  ╭──╮  Icons, small cards
Medium: 16px  ╭───╮ Buttons, cards
Large:  24px  ╭────╮ Modals, sheets
Round:  50%   ●     Avatars, badges
```

---

## Shadows

### Light Mode

```
Standard:
  color: rgba(0, 0, 0, 0.05)
  blur: 20px
  offset: 0, 4px

Glow:
  color: rgba(0, 122, 255, 0.3)
  blur: 24px
  offset: 0, 0
```

### Dark Mode

```
Standard:
  color: rgba(0, 0, 0, 0.3)
  blur: 20px
  offset: 0, 4px

Glow:
  color: rgba(0, 122, 255, 0.3)
  blur: 24px
  offset: 0, 0
```

---

## Glass Effect Values

### Subtle Glass (Backgrounds)

```
Opacity: 0.05-0.08
Blur:    10px
Use:     Containers, backgrounds
```

### Medium Glass (Cards)

```
Opacity: 0.10-0.12
Blur:    10px
Use:     Cards, sidebars
```

### Strong Glass (Overlays)

```
Opacity: 0.15-0.20
Blur:    20px
Use:     Modals, headers
```

---

## Animation Timings

### Quick Feedback

```
Duration: 100ms
Curve:    easeInOut
Use:      Button press, icon tap
```

### Standard Transitions

```
Duration: 200ms
Curve:    easeOut
Use:      Hover, focus states
```

### Page Transitions

```
Duration: 300ms
Curve:    easeInOutCubic
Use:      Screen changes
```

### Entrance Animations

```
Duration: 400ms
Curve:    easeOut
Stagger:  50ms between items
Use:      List items, welcome screen
```

---

## Component Sizes

### Buttons

```
Height:  56px (standard)
Padding: 24px horizontal, 16px vertical
Radius:  16px
```

### Icon Buttons

```
Size:    48x48px (touch target)
Icon:    24px
Radius:  24px (circular)
```

### Cards

```
Padding: 16px
Radius:  16px
Gap:     8-16px between elements
```

### Headers

```
Height:  64px
Padding: 24px horizontal, 16px vertical
```

---

## Grid System

### Mobile (< 768px)

```
Columns:  1-2
Gutter:   16px
Margin:   16px
```

### Tablet (768px - 1024px)

```
Columns:  2-3
Gutter:   24px
Margin:   24px
```

### Desktop (> 1024px)

```
Columns:  3-4
Gutter:   32px
Margin:   32px
```

---

## Touch Targets

```
Minimum:  48x48px
Optimal:  56x56px
Spacing:  8px minimum between targets
```

---

## Icon Sizes

```
Small:   16px  Navigation, inline
Medium:  24px  Standard buttons
Large:   32px  Feature highlights
XLarge:  48px  Hero sections
Huge:    64px  Welcome screens
```

---

## Gradients

### Primary Gradient

```
Colors:  #007AFF → #5AC8FA
Angle:   45° (diagonal)
Use:     Buttons, badges, avatars
```

### Background Gradient

```
Light:   #F2F2F7 → #E5E5EA → #F2F2F7
Dark:    #000000 → #1C1C1E → #000000
Angle:   135° (diagonal)
Use:     Screen backgrounds
```

### Welcome Screen

```
Colors:  #007AFF → #5856D6 → #0051D5
Angle:   135°
Use:     Welcome/onboarding
```

---

## States

### Default

```
Opacity: 1.0
Scale:   1.0
```

### Hover (Desktop)

```
Opacity: 1.0
Scale:   1.05
Transition: 200ms
```

### Pressed

```
Opacity: 1.0
Scale:   0.95
Transition: 100ms
```

### Disabled

```
Opacity: 0.5
Scale:   1.0
```

### Loading

```
Opacity: 0.7
Spinner: Show
```

---

## Elevation Levels

```
Level 0: No shadow         Ground level
Level 1: Light shadow      Cards
Level 2: Medium shadow     Buttons
Level 3: Strong shadow     Modals
Level 4: Heavy shadow      Popups
```

---

## Z-Index Layers

```
-1:  Background gradients
0:   Base content
1:   Cards, sidebars
2:   Headers, navigation
3:   Dropdowns, tooltips
4:   Modals, sheets
5:   Toast notifications
```

---

## Opacity Scale

```
5%   Subtle backgrounds
8%   Glass containers
10%  Cards, buttons
15%  Strong glass
20%  Overlays
30%  Shadows, glow
50%  Disabled states
70%  Loading states
```

---

## Responsive Breakpoints

```
Mobile:       < 768px
Tablet:       768px - 1024px
Desktop:      1024px - 1440px
Large:        > 1440px
```

---

## Quick Reference

### Most Common Values

- Padding: `16px`
- Border Radius: `16px`
- Font Size: `15px`
- Glass Opacity: `0.08`
- Animation: `200ms`
- Shadow Blur: `20px`

### Color Usage

- Text: Theme text color
- Links: Primary color
- Success: Green
- Error: Red
- Warning: Orange
- Info: Primary color

---

## Accessibility

### Color Contrast

- Text on Light: 4.5:1 minimum
- Text on Dark: 4.5:1 minimum
- Large Text: 3:1 minimum

### Touch Targets

- Minimum: 48x48px
- Spacing: 8px between

### Focus States

- Outline: 2px solid primary
- Offset: 2px
- Radius: 18px (border + 2px)

---

This reference guide ensures consistency across your app! 🎨
