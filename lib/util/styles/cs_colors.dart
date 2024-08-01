import 'dart:ui';

enum CSColors {
  //Principais
  primarySwatch(Color(0xFF4AA6E3)),
  primarySwatchV1(Color(0xFF1D9BF0)),
  primarySwatchV2(Color(0xFF1D75DE)),
  secondarySwatch(Color(0xFF1ED760)),
  secondarySwatchV1(Color(0xFF28A745)),
  primary(Color(0xFFFFFFFF)),
  inversePrimary(Color(0xFF000000)),
  secondary(Color(0xFFF5F5F5)),
  secondaryV1(Color(0xFFA7A7A7)),
  background(Color(0xFF121212)),
  backgroundV1(Color(0xFF181818)),
  foreground(Color(0xFF232323)),
  foregroundV1(Color(0xFF282828)),
  foregroundV2(Color(0xFF333333)),
  card(Color(0xFF232323)),
  error(Color(0xFFE91429)),
  errorText(Color(0xFFF15E6C)),
  warning(Color(0xFFFFA42B)),
  hint(Color(0x00000000)),
  indicator(Color(0xAA8AB4F8)),

  //Outros
  animatedBorder(Color(0xFF1D1D1D)),
  border(Color(0xFF767676)),
  borderV1(Color(0xFF30363D)),
  textSelectionColor(Color(0xFF0438A2)),

  //Colors for light mode
  lightBackground(Color(0xFF000000));

  final Color color;

  const CSColors(this.color);

  Color get hex => color;
}

