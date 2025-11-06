# Coding Standards

## Architecture Principles

1. **Separation of Concerns**: Clear boundaries between data, business logic, and UI
2. **Single Responsibility**: Each file/class has one clear purpose
3. **DRY**: Don't repeat yourself - extract common patterns
4. **Simplicity**: Prefer simple solutions over complex ones
5. **Composability**: Build complex UIs from simple, reusable widgets

## File Organization

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App-wide constants
│   ├── theme/              # Design system (colors, typography, spacing)
│   └── utils/              # Utility functions
├── data/                   # Data layer
│   ├── models/            # Data models
│   ├── repositories/       # Data access layer
│   └── mock_data/         # Mock data for MVP
├── domain/                 # Business logic
│   └── services/          # Business logic services
├── presentation/          # UI layer
│   ├── screens/           # Full screen widgets
│   ├── widgets/           # Reusable UI components
│   └── providers/         # State management
└── main.dart              # App entry point
```

## Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Methods**: `camelCase`
- **Constants**: `lowerCamelCase` (for final const values)
- **Private members**: `_leadingUnderscore`

## Code Style

- Use `const` constructors wherever possible
- Prefer `final` over `var`
- Use trailing commas for multi-line lists/maps
- Keep functions small and focused (ideally < 50 lines)
- Extract complex widget trees into separate widgets
- Use meaningful variable names (avoid abbreviations)

## Widget Guidelines

- Keep widgets small and focused
- Extract reusable widgets to separate files
- Use `StatelessWidget` unless state is needed
- Prefer composition over inheritance
- Use `const` widgets when possible

## State Management

- Use Provider for state management
- Keep providers focused on single responsibilities
- Use `ChangeNotifier` for reactive state
- Avoid deep nesting of providers

## Comments

- Minimal comments - code should be self-documenting
- Only comment when business logic is non-obvious
- Use clear naming instead of comments

