# Skillz Log — Development Journal

This is the living engineering and content journal for Skillz Log. It records
what was built, why decisions were made, the tradeoffs accepted, problems
encountered, and ideas worth turning into public posts.

## Journal metadata

- Project: Skillz Log
- Platform: Flutter
- Journal created: 2026-09-24 13:40 WAT
- Current milestone: Application foundation and startup flow
- Status: In progress

## Product idea

Skillz Log is a learning journal intended to help users break skills into small
steps, record learning sessions, and make progress visible.

Current tagline:

> Small steps, visible progress.

## Current architecture

```text
Native splash
    ↓
Flutter starts
    ↓
AuthGate
    ├── checking        → SplashScreen
    ├── authenticated   → HomeScreen
    └── unauthenticated → AuthScreen
```

The current project structure is:

```text
lib/
├── auth/
│   ├── auth_controller.dart
│   └── auth_gate.dart
├── data/
│   ├── app_theme.dart
│   ├── constants.dart
│   └── theme_controller.dart
├── pages/
│   ├── auth_screen.dart
│   ├── home_screen.dart
│   └── splash_screen.dart
└── main.dart
```

## Work completed

### Native splash screen

The app uses `flutter_native_splash` to generate the native Android and iOS
launch screens shown before Flutter renders its first frame.

Current configuration:

- Background: `#133924`
- Light and dark native backgrounds currently use the same color.
- Logo: `assets/images/logo.png`
- Android 12 has its own explicit configuration.
- Web splash generation is disabled.
- Full-screen native splash is enabled.

Decision: keep the native splash simple. Android 12 controls the native splash
layout and does not allow an arbitrary Flutter-style composition. The tagline
therefore belongs on the Flutter splash rather than the native screen.

Tradeoff: the available logo began as a low-resolution raster image. Enlarging
it made it blurry. Development continued with the current asset so visual asset
polish would not block application architecture. A vector or properly exported
high-resolution logo should replace it later.

### Flutter splash screen

`SplashScreen` is now a visual, stateless widget. It does not own routing or
authentication logic.

It currently displays:

- The logo at 96×96 logical pixels
- The application name
- The tagline
- The primary green background
- Text styles and colors obtained from the active theme

Decision: keep business logic out of the splash widget. This makes the splash
easy to redesign without touching authentication behavior.

Current issue: `AppDurations.splashDisplay` is set to 12,000 milliseconds, or
12 seconds. If the intended duration is 1.2 seconds, change it to 1,200
milliseconds.

### Centralized light and dark themes

`AppTheme.light` and `AppTheme.dark` are passed to `MaterialApp`.

The current palette intentionally contains only the colors required by the
implemented interface:

| Role | Light | Dark |
|---|---|---|
| Primary | `#133924` | `#133924` |
| On primary | `#FAFAF6` | `#FAFAF6` |
| Background | `#F8F7F1` | `#0B1D14` |
| Foreground | `#133924` | `#F6F5EE` |

The theme defines:

- Material 3
- A seeded `ColorScheme`
- Explicit primary, on-primary, surface, and on-surface roles
- Scaffold backgrounds
- `headlineMedium` at 30px and semi-bold
- `bodyMedium` at 14px

Decision: use semantic theme roles instead of repeating hexadecimal colors in
screens. Widgets retrieve the active theme with `Theme.of(context)`.

Tradeoff: no custom font family has been installed yet. Android and iOS use
their system fonts. Font sizes, weights, and colors are centralized now so a
custom font can be introduced later without rewriting every screen.

Learning: `Theme.of(context)` retrieves the theme that `MaterialApp` resolved.
It does not apply colors by itself. Widgets still select an appropriate theme
role, such as `colorScheme.primary` or `textTheme.headlineMedium`.

### Theme controller

`AppThemeController.mode` is a `ValueNotifier<ThemeMode>` initialized with:

```dart
ThemeMode.system
```

`ValueListenableBuilder` in `main.dart` listens to this value and supplies it to
`MaterialApp.themeMode`.

The behavior is:

```text
ThemeMode.system → Flutter follows the device preference
ThemeMode.light  → Flutter forces AppTheme.light
ThemeMode.dark   → Flutter forces AppTheme.dark
```

Decision: use `ValueNotifier` while the app is small. It provides reactive
theme changes without introducing a state-management dependency.

Tradeoff: the setting is held only in memory. A manual selection is lost after
the app restarts. Persistence can be added later with local storage.

Current limitation: `HomeScreen` currently displays the resolved mode but no
longer contains a switch for changing it. The controller supports manual light
and dark selection, but a user-facing control must be restored if required.

### Authentication gate

Authentication is represented by an enum:

```dart
enum AuthStatus {
  checking,
  authenticated,
  unauthenticated,
}
```

`AuthController` extends `ValueNotifier<AuthStatus>`. Assigning a new `value`
notifies `AuthGate`, which rebuilds the appropriate screen.

`AuthGate` starts initialization once in `initState()` and uses a switch over
the current status:

```text
checking        → SplashScreen
authenticated   → HomeScreen
unauthenticated → AuthScreen
```

Decision: use a declarative authentication gate instead of making the splash
screen call `Navigator.pushReplacement`. The visible root screen is a function
of authentication state.

Benefits:

- Splash UI stays separate from authentication logic.
- Login automatically reveals the home screen.
- Logout automatically returns to the authentication screen.
- The user cannot navigate back to the splash screen.
- The same gate can later listen to a real authentication provider.

Current limitation: authentication is mocked. `initialize()` waits and then
manually sets `AuthStatus.unauthenticated`. The temporary Sign in button calls
`markAsAuthenticated()` without validating credentials or creating a session.

Future integration should replace the manual values with a real session
provider while preserving the AuthGate interface.

### Launcher icon

The app uses `flutter_launcher_icons`.

Configuration currently generates:

- Android legacy launcher icons
- Android adaptive launcher foreground and background
- iOS app icons
- A green adaptive background using `#133924`
- An opaque green iOS background when removing PNG transparency

The generated Android adaptive icon resources are present, including
`mipmap-anydpi-v26/ic_launcher.xml` and density-specific foreground images.

Decision: use generated platform sizes instead of manually resizing and
replacing each Android and iOS file.

Tradeoff: launcher quality remains limited by the current source artwork. A
crisp vector-derived export should eventually replace the current raster.

## Key technical lessons

### `ValueNotifier` and `ValueListenableBuilder`

`ValueNotifier<T>` stores a value of type `T` and notifies listeners when that
value changes. `ValueListenableBuilder<T>` listens and rebuilds its builder with
the newest value.

This pattern currently drives both:

- Theme selection
- Authentication-state rendering

It is appropriate for this early stage because the state is small and local.
If application state becomes substantially more complex, a dedicated state
management approach may become worthwhile.

### Declarative rendering versus navigation

The authentication gate does not push HomeScreen or AuthScreen onto the
navigation stack. Instead, it returns the correct widget for the current
authentication status.

```text
UI = function of state
```

Traditional navigation is still useful for movement inside the authenticated
application. The root authentication boundary is easier to maintain as a
declarative gate.

### Native splash versus Flutter splash

They solve different problems:

```text
Native splash  → visible before Flutter is ready
Flutter splash → rendered after Flutter's first frame
```

The native layer should remain simple and platform-compliant. The Flutter layer
can contain richer typography, layout, animation, and application state.

## Problems encountered

### Splash image was missing

Cause: the configured path was `assets/images/logo.png`, while the file was
initially placed under `lib/assets/images/logo.png`.

Lesson: package configuration paths are resolved from the project root and
must match the filesystem exactly.

### Updated splash image did not appear

Cause: the source image was replaced after splash resources had already been
generated. The generated Android files still contained the previous 100×100
asset.

Resolution: rerun the generator, clean the build, and reinstall the app because
native launch resources may be cached.

### Enlarged image became blurry

Cause: a 100×100 raster image was enlarged to 1152×1152. Upscaling increases
pixel dimensions but cannot recreate missing visual detail.

Future resolution: obtain or recreate the logo as a vector, then export a
proper high-resolution PNG with platform-safe padding.

### Theme toggle initially changed only text

Cause: a local Boolean in HomeScreen changed its label but was not connected to
`MaterialApp.themeMode`.

Resolution: store the selected `ThemeMode` in a `ValueNotifier` and rebuild
`MaterialApp` with `ValueListenableBuilder`.

### Hard-coded splash navigation was replaced

The first version delayed inside SplashScreen and used
`Navigator.pushReplacement` to open HomeScreen.

This worked for a prototype but did not account for authenticated versus
unauthenticated users. It was replaced conceptually with AuthGate, where the
screen is selected from authentication state.

## Current technical debt

- Replace the mocked authentication check with a real session provider.
- Reduce the 12-second splash delay if it is accidental.
- Replace the blurry raster logo with a vector-derived source.
- Decide whether users need System, Light, and Dark choices or only a binary
  light/dark switch.
- Persist manual theme selection if it becomes a real user preference.
- Remove the unused legacy `KTextStyle` class from `constants.dart` once
  confirmed unnecessary.
- Remove the unused `SplashScreen` import from `main.dart`.
- Use `const AuthGate()` in `main.dart`.
- Add real authentication forms and validation.
- Add error handling for startup/session restoration failures.
- Expand tests for all three authentication states and both theme modes.

## Next likely milestone

Implement real authentication while keeping the existing state flow:

1. Choose and initialize the authentication provider.
2. Create an `AuthService` responsible for session operations.
3. Make `AuthController.initialize()` restore the real session.
4. Replace the temporary sign-in button with validated fields.
5. Listen for sign-in, token refresh, expiration, and sign-out events.
6. Add loading and error states without placing this logic in SplashScreen.

## Content ideas

### Short post ideas

- “Why my Flutter splash screen should not decide where users go”
- “The difference between a native splash and a Flutter splash”
- “How one local Boolean failed to switch my Flutter theme”
- “Using ValueNotifier before reaching for a state-management package”
- “How I built a declarative auth gate as a Flutter beginner”
- “Why turning a 100px logo into 1152px did not improve its quality”
- “ThemeMode.system versus manual light and dark overrides”

### Longer build-log outline

1. What Skillz Log is intended to solve.
2. Creating a two-stage startup experience.
3. Debugging asset paths and generated native resources.
4. Building a minimal design system without copying unused boilerplate.
5. Understanding semantic colors such as primary and onPrimary.
6. Introducing reactive theme selection with ValueNotifier.
7. Replacing hard-coded splash navigation with an AuthGate.
8. What is mocked today and what production authentication still requires.

### Potential hook

> I started building Skillz Log thinking the splash screen only needed a timer.
> That quickly turned into lessons about native platform constraints, reactive
> themes, declarative authentication, and why a 100px logo does not become
> high-resolution just because the canvas says 1152px.

## Journal entry template

Copy this section for future updates:

```markdown
## YYYY-MM-DD — Milestone title

### What changed

- 

### Why

- 

### Decision

- 

### Tradeoffs

- 

### Problems and fixes

- 

### What I learned

- 

### Content worth sharing

- 

### Next step

- 
```

---

Last updated: 2026-09-24 13:40 WAT
