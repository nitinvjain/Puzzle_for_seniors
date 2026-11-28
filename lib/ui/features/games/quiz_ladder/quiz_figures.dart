/// The pictures some quiz questions are asked about.
///
/// Every figure here is drawn in code rather than shipped as an image. Three
/// reasons, in order of how much they mattered:
///
///   * a drawing made of lines stays sharp at any size, and these are read
///     by an eighty-four-year-old on an eleven-inch tablet;
///   * it adds no asset bundle, no image decoding and no new dependency to
///     a build that is deliberately kept to what the Flutter SDK already
///     has;
///   * and a figure defined by numbers can be checked. Each one here was
///     rendered and looked at before it shipped, which is how the half-moon
///     that was supposed to be a full one, a triangle with no obtuse angle
///     in it, and a pencil that measured seven centimetres against a ruler
///     that called it six were all caught.
///
/// Figures are authored in a 0..100 square with y running downwards, and
/// [_Pen] maps that square onto whatever canvas it is given, centred and to
/// a uniform scale. Dashes are not a pen feature: a dashed line or arc is
/// already a run of short solid pieces by the time it reaches here.
///
/// Dark ink on light paper in every theme. The senior brief asks for
/// high-contrast and dark-on-light, and geometry read light-on-dark is
/// harder on an older eye than text is.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../config/senior_strings.dart';

const Color _paper = Color(0xFFF4FAFF);
const Color _ink = Color(0xFF102A3A);
const Color _accent = Color(0xFF1D6FA8);
const Color _accent2 = Color(0xFFB3401F);
const Color _shade = Color(0xFFAFD8F4);
const Color _shade2 = Color(0xFFF6C76B);
const Color _shade3 = Color(0xFFCFD8DE);
const Color _white = Color(0xFFFFFFFF);
const Color _red = Color(0xFFCE1126);
const Color _green = Color(0xFF138808);
const Color _saffron = Color(0xFFFF9933);
const Color _navy = Color(0xFF000080);
const Color _blue = Color(0xFF0055A4);

/// The largest a figure is ever drawn, in logical pixels.
///
/// On the eleven-inch tablet he plays on, this is the size used, and the
/// question, the picture, all four answers and the lifelines are on the
/// screen together.
const double kQuizFigureMax = 220.0;

/// The smallest. Below this the labels inside a figure -- a 60 beside its
/// own arc, a 7 under its own tick -- stop being readable at arm's length,
/// and a figure that cannot be read is worse than no figure.
const double kQuizFigureMin = 130.0;

/// How big to draw a figure on this screen.
///
/// A fixed size was the obvious thing and it was wrong. At 220 on a
/// telephone the fourth answer button sits entirely below the fold: he
/// would have to know to scroll to find an option he has not been shown,
/// which for him means that option does not exist. A fifth of the screen
/// height keeps all four answers in view on a phone and still gives the
/// tablet the full size.
double quizFigureSide(BuildContext context) {
  final screen = MediaQuery.sizeOf(context);
  final byHeight = screen.height * 0.20;
  final byWidth = screen.width - 64.0;
  final side = byHeight < byWidth ? byHeight : byWidth;
  if (side > kQuizFigureMax) return kQuizFigureMax;
  if (side < kQuizFigureMin) return kQuizFigureMin;
  return side;
}

/// Draws into the 0..100 authoring square.
class _Pen {
  _Pen(this.canvas, this.scale, this.org);

  final Canvas canvas;
  final double scale;
  final Offset org;

  Offset _p(double x, double y) =>
      Offset(org.dx + x * scale, org.dy + y * scale);

  Paint _stroke(Color col, double w) => Paint()
    ..color = col
    ..strokeWidth = w * scale
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..isAntiAlias = true;

  Paint _fill(Color col) => Paint()
    ..color = col
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  Rect _box(double cx, double cy, double rx, double ry) => Rect.fromCenter(
        center: _p(cx, cy),
        width: 2.0 * rx * scale,
        height: 2.0 * ry * scale,
      );

  /// Line.
  void l(double x1, double y1, double x2, double y2, Color col, double w) {
    canvas.drawLine(_p(x1, y1), _p(x2, y2), _stroke(col, w));
  }

  /// Polygon or polyline, from a flat list of x, y pairs.
  void g(List<double> v, Color col, double w, Color? fill, bool close) {
    if (v.length < 4) return;
    final first = _p(v[0], v[1]);
    final path = Path()..moveTo(first.dx, first.dy);
    for (var i = 2; i + 1 < v.length; i += 2) {
      final q = _p(v[i], v[i + 1]);
      path.lineTo(q.dx, q.dy);
    }
    if (close) path.close();
    if (fill != null) canvas.drawPath(path, _fill(fill));
    if (w > 0) canvas.drawPath(path, _stroke(col, w));
  }

  /// Circle, or an oval when rx and ry differ -- which is what a cylinder's
  /// rim and a cone's base need to stop them reading as a capsule.
  void e(double cx, double cy, double rx, double ry, Color col, double w,
      Color? fill) {
    final box = _box(cx, cy, rx, ry);
    if (fill != null) canvas.drawOval(box, _fill(fill));
    if (w > 0) canvas.drawOval(box, _stroke(col, w));
  }

  /// Arc, in degrees, zero at three o'clock and sweeping clockwise.
  /// [centre] closes it through the centre, making a wedge.
  void a(double cx, double cy, double rx, double ry, double start,
      double sweep, Color col, double w, Color? fill, bool centre) {
    final box = _box(cx, cy, rx, ry);
    final s = start * math.pi / 180.0;
    final d = sweep * math.pi / 180.0;
    if (fill != null) canvas.drawArc(box, s, d, centre, _fill(fill));
    if (w > 0) canvas.drawArc(box, s, d, centre, _stroke(col, w));
  }

  /// A label, centred on the point given.
  ///
  /// Deliberately not scaled by the system text size. These labels are
  /// placed against the geometry around them -- a 90 beside its own arc, a
  /// 7 under its own tick -- and growing them would move them off the thing
  /// they name. The figure as a whole grows with the screen instead.
  void t(String s, double x, double y, double size, Color col) {
    final tp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(
          color: col,
          fontSize: size * scale,
          fontWeight: FontWeight.w700,
          height: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textScaler: TextScaler.noScaling,
    )..layout();
    final q = _p(x, y);
    tp.paint(canvas, Offset(q.dx - tp.width / 2.0, q.dy - tp.height / 2.0));
  }
}

typedef _QuizFigureDraw = void Function(_Pen p);

const Map<String, _QuizFigureDraw> _figures = <String, _QuizFigureDraw>{
  'ang_right': _f_ang_right,
  'ang_acute': _f_ang_acute,
  'ang_obtuse': _f_ang_obtuse,
  'ang_straight': _f_ang_straight,
  'ang_reflex': _f_ang_reflex,
  'ang_complement': _f_ang_complement,
  'ang_supplement': _f_ang_supplement,
  'ang_vertical': _f_ang_vertical,
  'tri_equi': _f_tri_equi,
  'tri_iso': _f_tri_iso,
  'tri_scalene': _f_tri_scalene,
  'tri_right': _f_tri_right,
  'tri_obtuse': _f_tri_obtuse,
  'tri_sum': _f_tri_sum,
  'tri_exterior': _f_tri_exterior,
  'tri_pythag': _f_tri_pythag,
  'tri_area': _f_tri_area,
  'tri_similar': _f_tri_similar,
  'tri_altitude': _f_tri_altitude,
  'quad_square': _f_quad_square,
  'quad_rect': _f_quad_rect,
  'quad_rhombus': _f_quad_rhombus,
  'quad_parallel': _f_quad_parallel,
  'quad_trap': _f_quad_trap,
  'quad_kite': _f_quad_kite,
  'quad_sum': _f_quad_sum,
  'quad_diag': _f_quad_diag,
  'quad_perim': _f_quad_perim,
  'quad_sq_area': _f_quad_sq_area,
  'poly_pent': _f_poly_pent,
  'poly_hex': _f_poly_hex,
  'poly_hept': _f_poly_hept,
  'poly_oct': _f_poly_oct,
  'poly_tri_name': _f_poly_tri_name,
  'poly_irregular': _f_poly_irregular,
  'cir_radius': _f_cir_radius,
  'cir_diameter': _f_cir_diameter,
  'cir_chord': _f_cir_chord,
  'cir_tangent': _f_cir_tangent,
  'cir_arc': _f_cir_arc,
  'cir_sector': _f_cir_sector,
  'cir_segment': _f_cir_segment,
  'cir_centre': _f_cir_centre,
  'cir_semi': _f_cir_semi,
  'cir_quadrant': _f_cir_quadrant,
  'cir_circum': _f_cir_circum,
  'sol_cube': _f_sol_cube,
  'sol_cube_faces': _f_sol_cube_faces,
  'sol_cube_edges': _f_sol_cube_edges,
  'sol_cuboid': _f_sol_cuboid,
  'sol_cylinder': _f_sol_cylinder,
  'sol_cone': _f_sol_cone,
  'sol_sphere': _f_sol_sphere,
  'sol_pyramid': _f_sol_pyramid,
  'sol_prism': _f_sol_prism,
  'sol_cyl_faces': _f_sol_cyl_faces,
  'line_parallel': _f_line_parallel,
  'line_perp': _f_line_perp,
  'line_intersect': _f_line_intersect,
  'line_segment': _f_line_segment,
  'line_ray': _f_line_ray,
  'line_transversal': _f_line_transversal,
  'line_bisect': _f_line_bisect,
  'sym_square': _f_sym_square,
  'sym_rect': _f_sym_rect,
  'sym_equi': _f_sym_equi,
  'sym_circle': _f_sym_circle,
  'sym_letter': _f_sym_letter,
  'sym_none': _f_sym_none,
  'frac_half': _f_frac_half,
  'frac_quarter': _f_frac_quarter,
  'frac_threequarter': _f_frac_threequarter,
  'frac_third': _f_frac_third,
  'frac_twothird': _f_frac_twothird,
  'frac_fifth': _f_frac_fifth,
  'frac_eighth': _f_frac_eighth,
  'frac_bar_half': _f_frac_bar_half,
  'frac_bar_quarter': _f_frac_bar_quarter,
  'frac_bar_threefifth': _f_frac_bar_threefifth,
  'frac_equiv': _f_frac_equiv,
  'frac_compare': _f_frac_compare,
  'grid_count': _f_grid_count,
  'grid_area_rect': _f_grid_area_rect,
  'grid_perim': _f_grid_perim,
  'grid_half_shaded': _f_grid_half_shaded,
  'grid_lshape': _f_grid_lshape,
  'grid_bigger': _f_grid_bigger,
  'num_line_7': _f_num_line_7,
  'num_line_3': _f_num_line_3,
  'num_line_half': _f_num_line_half,
  'num_line_neg': _f_num_line_neg,
  'scale_ruler': _f_scale_ruler,
  'scale_ruler2': _f_scale_ruler2,
  'scale_thermo': _f_scale_thermo,
  'scale_balance': _f_scale_balance,
  'scale_protractor': _f_scale_protractor,
  'bar_tallest': _f_bar_tallest,
  'bar_total': _f_bar_total,
  'bar_diff': _f_bar_diff,
  'bar_fewest': _f_bar_fewest,
  'chart_pie_biggest': _f_chart_pie_biggest,
  'chart_tally': _f_chart_tally,
  'chart_picto': _f_chart_picto,
  'chart_line_rising': _f_chart_line_rising,
  'dice_pips': _f_dice_pips,
  'dice_total': _f_dice_total,
  'dice_opposite': _f_dice_opposite,
  'domino': _f_domino,
  'pat_dots_next': _f_pat_dots_next,
  'pat_squares': _f_pat_squares,
  'pat_shapes_next': _f_pat_shapes_next,
  'pat_odd_one': _f_pat_odd_one,
  'pat_matchstick': _f_pat_matchstick,
  'pat_shaded_next': _f_pat_shaded_next,
  'pat_number_pyr': _f_pat_number_pyr,
  'clk_3': _f_clk_3,
  'clk_6': _f_clk_6,
  'clk_half6': _f_clk_half6,
  'clk_quarterpast9': _f_clk_quarterpast9,
  'clk_quarterto5': _f_clk_quarterto5,
  'clk_10past2': _f_clk_10past2,
  'clk_20to8': _f_clk_20to8,
  'clk_745': _f_clk_745,
  'clk_angle3': _f_clk_angle3,
  'clk_angle6': _f_clk_angle6,
  'clk_minute_hand': _f_clk_minute_hand,
  'clk_half_hour': _f_clk_half_hour,
  'flag_japan': _f_flag_japan,
  'flag_bangladesh': _f_flag_bangladesh,
  'flag_india': _f_flag_india,
  'flag_france': _f_flag_france,
  'flag_italy': _f_flag_italy,
  'flag_switzerland': _f_flag_switzerland,
  'flag_indonesia': _f_flag_indonesia,
  'flag_nepal': _f_flag_nepal,
  'flag_tricolour_bands': _f_flag_tricolour_bands,
  'flag_chakra': _f_flag_chakra,
  'sci_magnet': _f_sci_magnet,
  'sci_circuit': _f_sci_circuit,
  'sci_moon': _f_sci_moon,
  'sci_plant': _f_sci_plant,
  'sci_shadow': _f_sci_shadow,
  'sci_compass': _f_sci_compass,
  'sci_states': _f_sci_states,
  'sci_eclipse': _f_sci_eclipse,
};

void _f_ang_right(_Pen p) {
  p.l(22.0,74.0,82.0,74.0,_ink,2.2);
  p.l(22.0,74.0,22.0,18.0,_ink,2.2);
  p.g(const[31.0,74.0,31.0,65.0,22.0,65.0],_ink,1.8,null,false);
  p.a(22.0,74.0,22.0,22.0,-90.0,90.0,_accent,2.0,null,false);
  p.t('90°',43.57,52.43,8.5,_accent);
}

void _f_ang_acute(_Pen p) {
  p.l(20.0,76.0,86.0,76.0,_ink,2.2);
  p.l(20.0,76.0,68.0,26.0,_ink,2.2);
  p.a(20.0,76.0,24.0,24.0,-46.17,46.17,_accent,2.0,null,false);
  p.t('45°',49.9,63.26,8.5,_accent);
}

void _f_ang_obtuse(_Pen p) {
  p.l(50.0,74.0,92.0,74.0,_ink,2.2);
  p.l(50.0,74.0,14.0,36.0,_ink,2.2);
  p.a(50.0,74.0,22.0,22.0,-133.45,133.45,_accent,2.0,null,false);
  p.t('135°',62.05,45.98,8.5,_accent);
}

void _f_ang_straight(_Pen p) {
  p.l(12.0,52.0,88.0,52.0,_ink,2.2);
  p.e(12.0,52.0,2.0,2.0,_ink,0.0,_ink);
  p.e(50.0,52.0,2.0,2.0,_ink,0.0,_ink);
  p.e(88.0,52.0,2.0,2.0,_ink,0.0,_ink);
  p.a(50.0,52.0,20.0,20.0,0.0,180.0,_accent,2.0,null,false);
  p.t('?',50.0,80.5,8.5,_accent);
}

void _f_ang_reflex(_Pen p) {
  p.l(50.0,52.0,92.0,52.0,_ink,2.2);
  p.l(50.0,52.0,37.0,16.0,_ink,2.2);
  p.a(50.0,52.0,19.0,19.0,0.0,250.0,_accent,2.2,null,false);
  p.t('250°',30.0,80.0,9.5,_accent);
}

void _f_ang_complement(_Pen p) {
  p.l(20.0,76.0,86.0,76.0,_ink,2.2);
  p.l(20.0,76.0,20.0,20.0,_ink,2.2);
  p.l(20.0,76.0,76.0,48.0,_ink,2.2);
  p.g(const[29.0,76.0,29.0,67.0,20.0,67.0],_ink,1.8,null,false);
  p.a(20.0,76.0,26.0,26.0,-26.57,26.57,_accent,2.0,null,false);
  p.t('30°',53.58,68.07,8.5,_accent);
  p.a(20.0,76.0,14.0,14.0,-90.0,63.43,_accent2,2.0,null,false);
  p.t('?',31.83,56.86,8.5,_accent2);
}

void _f_ang_supplement(_Pen p) {
  p.l(12.0,66.0,88.0,66.0,_ink,2.2);
  p.l(50.0,66.0,76.0,20.0,_ink,2.2);
  p.a(50.0,66.0,20.0,20.0,-60.52,60.52,_accent,2.0,null,false);
  p.t('70°',74.62,51.64,8.5,_accent);
  p.a(50.0,66.0,28.0,28.0,180.0,119.48,_accent2,2.0,null,false);
  p.t('?',31.61,34.47,8.5,_accent2);
}

void _f_ang_vertical(_Pen p) {
  p.l(14.0,24.0,86.0,76.0,_ink,2.2);
  p.l(14.0,76.0,86.0,24.0,_ink,2.2);
  p.e(50.0,50.0,2.0,2.0,_ink,0.0,_ink);
  p.t('55°',68.0,46.0,9.0,_accent);
  p.t('a',50.0,28.0,10.0,_accent2);
  p.t('b',30.0,52.0,10.0,_accent2);
  p.t('c',50.0,74.0,10.0,_accent2);
}

void _f_tri_equi(_Pen p) {
  p.g(const[50.0,18.0,18.0,76.0,82.0,76.0],_ink,2.2,null,true);
  p.l(36.63,48.45,31.37,45.55,_ink,2.0);
  p.l(50.0,73.0,50.0,79.0,_ink,2.0);
  p.l(63.37,48.45,68.63,45.55,_ink,2.0);
}

void _f_tri_iso(_Pen p) {
  p.g(const[50.0,16.0,22.0,78.0,78.0,78.0],_ink,2.2,null,true);
  p.l(39.35,46.87,33.88,44.4,_ink,2.0);
  p.l(38.12,49.6,32.65,47.13,_ink,2.0);
  p.l(61.88,49.6,67.35,47.13,_ink,2.0);
  p.l(60.65,46.87,66.12,44.4,_ink,2.0);
}

void _f_tri_scalene(_Pen p) {
  p.g(const[28.0,20.0,14.0,76.0,88.0,62.0],_ink,2.2,null,true);
}

void _f_tri_right(_Pen p) {
  p.g(const[22.0,76.0,22.0,22.0,84.0,76.0],_ink,2.2,null,true);
  p.g(const[31.0,76.0,31.0,67.0,22.0,67.0],_ink,1.8,null,false);
}

void _f_tri_obtuse(_Pen p) {
  p.g(const[10.0,74.0,40.0,74.0,73.0,27.0],_ink,2.2,null,true);
  p.a(40.0,74.0,17.0,17.0,180.0,125.07,_accent,2.0,null,false);
  p.t('125°',28.24,51.37,8.5,_accent);
}

void _f_tri_sum(_Pen p) {
  p.g(const[50.0,18.0,16.0,78.0,86.0,78.0],_ink,2.2,null,true);
  p.a(16.0,78.0,17.0,17.0,-60.46,60.46,_accent,2.0,null,false);
  p.t('60°',38.03,65.16,8.5,_accent);
  p.a(86.0,78.0,17.0,17.0,180.0,59.04,_accent,2.0,null,false);
  p.t('55°',63.81,65.44,8.5,_accent);
  p.a(50.0,18.0,15.0,15.0,59.04,60.5,_accent2,2.0,null,false);
  p.t('?',50.29,41.5,8.5,_accent2);
}

void _f_tri_exterior(_Pen p) {
  p.g(const[14.0,70.0,70.0,70.0,42.0,26.0],_ink,2.2,null,true);
  p.l(70.0,70.0,94.0,70.0,_ink,2.2);
  p.a(14.0,70.0,20.0,20.0,-57.53,57.53,_accent,2.0,null,false);
  p.t('40°',38.98,56.29,8.5,_accent);
  p.a(70.0,70.0,13.0,13.0,180.0,57.53,_accent,2.0,null,false);
  p.t('70°',51.15,59.65,8.5,_accent);
  p.a(70.0,70.0,22.0,22.0,-122.47,122.47,_accent2,2.0,null,false);
  p.t('?',84.68,43.26,8.5,_accent2);
}

void _f_tri_pythag(_Pen p) {
  p.g(const[24.0,74.0,24.0,26.0,84.0,74.0],_ink,2.2,null,true);
  p.g(const[33.0,74.0,33.0,65.0,24.0,65.0],_ink,1.8,null,false);
  p.t('3',16.0,50.0,10.0,_accent2);
  p.t('4',54.0,84.0,10.0,_accent2);
  p.t('?',60.0,44.0,11.0,_accent);
}

void _f_tri_area(_Pen p) {
  p.g(const[14.0,74.0,84.0,74.0,46.0,24.0],_ink,2.2,null,true);
  p.l(46.0,24.0,46.0,26.6,_accent,1.8);
  p.l(46.0,28.6,46.0,31.2,_accent,1.8);
  p.l(46.0,33.2,46.0,35.8,_accent,1.8);
  p.l(46.0,37.8,46.0,40.4,_accent,1.8);
  p.l(46.0,42.4,46.0,45.0,_accent,1.8);
  p.l(46.0,47.0,46.0,49.6,_accent,1.8);
  p.l(46.0,51.6,46.0,54.2,_accent,1.8);
  p.l(46.0,56.2,46.0,58.8,_accent,1.8);
  p.l(46.0,60.8,46.0,63.4,_accent,1.8);
  p.l(46.0,65.4,46.0,68.0,_accent,1.8);
  p.l(46.0,70.0,46.0,72.6,_accent,1.8);
  p.g(const[52.0,74.0,52.0,68.0,46.0,68.0],_accent,1.8,null,false);
  p.t('6 cm',63.0,46.0,8.5,_accent);
  p.t('10 cm',49.0,86.0,9.0,_accent2);
}

void _f_tri_similar(_Pen p) {
  p.g(const[10.0,70.0,44.0,70.0,27.0,40.0],_ink,2.2,null,true);
  p.g(const[54.0,76.0,94.0,76.0,74.0,41.0],_ink,2.2,null,true);
  p.a(10.0,70.0,10.0,10.0,-60.46,60.46,_accent,1.6,null,false);
  p.a(54.0,76.0,11.0,11.0,-60.26,60.26,_accent,1.6,null,false);
}

void _f_tri_altitude(_Pen p) {
  p.g(const[16.0,76.0,90.0,76.0,66.0,26.0],_ink,2.2,null,true);
  p.l(66.0,26.0,66.0,28.6,_accent,2.0);
  p.l(66.0,30.6,66.0,33.2,_accent,2.0);
  p.l(66.0,35.2,66.0,37.8,_accent,2.0);
  p.l(66.0,39.8,66.0,42.4,_accent,2.0);
  p.l(66.0,44.4,66.0,47.0,_accent,2.0);
  p.l(66.0,49.0,66.0,51.6,_accent,2.0);
  p.l(66.0,53.6,66.0,56.2,_accent,2.0);
  p.l(66.0,58.2,66.0,60.8,_accent,2.0);
  p.l(66.0,62.8,66.0,65.4,_accent,2.0);
  p.l(66.0,67.4,66.0,70.0,_accent,2.0);
  p.l(66.0,72.0,66.0,74.6,_accent,2.0);
  p.g(const[72.0,76.0,72.0,70.0,66.0,70.0],_accent,1.8,null,false);
}

void _f_quad_square(_Pen p) {
  p.g(const[27.0,27.0,73.0,27.0,73.0,73.0,27.0,73.0],_ink,2.2,null,true);
  p.l(50.0,24.0,50.0,30.0,_ink,2.0);
  p.l(76.0,50.0,70.0,50.0,_ink,2.0);
  p.l(50.0,76.0,50.0,70.0,_ink,2.0);
  p.l(24.0,50.0,30.0,50.0,_ink,2.0);
  p.g(const[34.0,27.0,34.0,34.0,27.0,34.0],_ink,1.8,null,false);
}

void _f_quad_rect(_Pen p) {
  p.g(const[14.0,33.0,86.0,33.0,86.0,67.0,14.0,67.0],_ink,2.2,null,true);
  p.g(const[21.0,33.0,21.0,40.0,14.0,40.0],_ink,1.8,null,false);
  p.g(const[79.0,67.0,79.0,60.0,86.0,60.0],_ink,1.8,null,false);
}

void _f_quad_rhombus(_Pen p) {
  p.g(const[50.0,16.0,86.0,50.0,50.0,84.0,14.0,50.0],_ink,2.2,null,true);
  p.l(70.06,30.82,65.94,35.18,_ink,2.0);
  p.l(70.06,69.18,65.94,64.82,_ink,2.0);
  p.l(29.94,69.18,34.06,64.82,_ink,2.0);
  p.l(29.94,30.82,34.06,35.18,_ink,2.0);
}

void _f_quad_parallel(_Pen p) {
  p.g(const[26.0,30.0,90.0,30.0,72.0,72.0,8.0,72.0],_ink,2.2,null,true);
}

void _f_quad_trap(_Pen p) {
  p.g(const[30.0,30.0,72.0,30.0,90.0,72.0,12.0,72.0],_ink,2.2,null,true);
}

void _f_quad_kite(_Pen p) {
  p.g(const[50.0,12.0,80.0,42.0,50.0,88.0,20.0,42.0],_ink,2.2,null,true);
  p.l(67.12,24.88,62.88,29.12,_ink,2.0);
  p.l(37.12,29.12,32.88,24.88,_ink,2.0);
  p.l(61.67,64.62,66.69,67.9,_ink,2.0);
  p.l(63.31,62.1,68.33,65.38,_ink,2.0);
  p.l(33.31,67.9,38.33,64.62,_ink,2.0);
  p.l(31.67,65.38,36.69,62.1,_ink,2.0);
}

void _f_quad_sum(_Pen p) {
  p.g(const[20.0,24.0,82.0,30.0,76.0,78.0,16.0,70.0],_ink,2.2,null,true);
  p.a(20.0,24.0,15.0,15.0,5.53,89.44,_accent,2.0,null,false);
  p.t('80°',35.03,42.07,8.5,_accent);
  p.a(82.0,30.0,15.0,15.0,97.13,88.4,_accent,2.0,null,false);
  p.t('95°',63.65,44.68,8.5,_accent);
  p.a(76.0,78.0,15.0,15.0,-172.41,89.53,_accent,2.0,null,false);
  p.t('85°',61.65,59.39,8.5,_accent);
  p.a(16.0,70.0,15.0,15.0,-85.03,92.62,_accent2,2.0,null,false);
  p.t('?',34.34,55.3,8.5,_accent2);
}

void _f_quad_diag(_Pen p) {
  p.g(const[16.0,30.0,84.0,30.0,84.0,70.0,16.0,70.0],_ink,2.2,null,true);
  p.l(16.0,30.0,84.0,70.0,_accent,2.4);
}

void _f_quad_perim(_Pen p) {
  p.g(const[12.0,36.0,74.0,36.0,74.0,64.0,12.0,64.0],_ink,2.2,null,true);
  p.t('8 cm',43.0,30.0,9.0,_accent2);
  p.t('3 cm',86.0,50.0,9.0,_accent2);
}

void _f_quad_sq_area(_Pen p) {
  p.g(const[24.0,28.0,66.0,28.0,66.0,72.0,24.0,72.0],_ink,2.2,null,true);
  p.t('7 cm',45.0,22.0,9.0,_accent2);
  p.t('7 cm',81.0,50.0,9.0,_accent2);
}

void _f_poly_pent(_Pen p) {
  p.g(const[50.0,19.0,81.38,41.8,69.4,78.7,30.6,78.7,18.62,41.8],_ink,2.2,null,true);
}

void _f_poly_hex(_Pen p) {
  p.g(const[50.0,19.0,78.58,35.5,78.58,68.5,50.0,85.0,21.42,68.5,21.42,35.5],_ink,2.2,null,true);
}

void _f_poly_hept(_Pen p) {
  p.g(const[50.0,19.0,75.8,31.42,82.17,59.34,64.32,81.73,35.68,81.73,17.83,59.34,24.2,31.42],_ink,2.2,null,true);
}

void _f_poly_oct(_Pen p) {
  p.g(const[50.0,19.0,73.33,28.67,83.0,52.0,73.33,75.33,50.0,85.0,26.67,75.33,17.0,52.0,26.67,28.67],_ink,2.2,null,true);
}

void _f_poly_tri_name(_Pen p) {
  p.g(const[50.0,19.0,78.58,68.5,21.42,68.5],_ink,2.2,null,true);
}

void _f_poly_irregular(_Pen p) {
  p.g(const[50.0,14.0,88.0,38.0,74.0,82.0,22.0,78.0,10.0,40.0],_ink,2.2,null,true);
}

void _f_cir_radius(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.2,null);
  p.e(50.0,50.0,2.0,2.0,_ink,0.0,_ink);
  p.l(50.0,50.0,84.0,50.0,_accent,2.8);
}

void _f_cir_diameter(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.2,null);
  p.e(50.0,50.0,2.0,2.0,_ink,0.0,_ink);
  p.l(16.0,50.0,84.0,50.0,_accent,2.8);
}

void _f_cir_chord(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.2,null);
  p.e(50.0,50.0,2.0,2.0,_ink,0.0,_ink);
  p.l(26.0,26.0,80.0,62.0,_accent,2.8);
}

void _f_cir_tangent(_Pen p) {
  p.e(50.0,50.0,30.0,30.0,_ink,2.2,null);
  p.e(50.0,50.0,2.0,2.0,_ink,0.0,_ink);
  p.l(12.0,80.0,90.0,80.0,_accent,2.8);
  p.e(50.0,80.0,2.6,2.6,_accent,0.0,_accent);
}

void _f_cir_arc(_Pen p) {
  p.e(50.0,50.0,32.0,32.0,_ink,1.6,null);
  p.a(50.0,50.0,32.0,32.0,-100.0,80.0,_accent,4.0,null,false);
}

void _f_cir_sector(_Pen p) {
  p.a(50.0,50.0,33.0,33.0,-90.0,95.0,_accent,2.2,_shade,true);
  p.e(50.0,50.0,33.0,33.0,_ink,2.2,null);
  p.e(50.0,50.0,2.0,2.0,_ink,0.0,_ink);
}

void _f_cir_segment(_Pen p) {
  p.e(50.0,50.0,33.0,33.0,_ink,2.2,null);
  p.a(50.0,50.0,33.0,33.0,-150.0,120.0,_accent,2.2,_shade,false);
  p.l(21.4,33.0,78.6,33.0,_accent,2.4);
}

void _f_cir_centre(_Pen p) {
  p.e(50.0,50.0,33.0,33.0,_ink,2.2,null);
  p.e(50.0,50.0,3.0,3.0,_accent,0.0,_accent);
}

void _f_cir_semi(_Pen p) {
  p.a(50.0,66.0,34.0,34.0,180.0,180.0,_ink,2.4,_shade,true);
  p.l(16.0,66.0,84.0,66.0,_ink,2.4);
}

void _f_cir_quadrant(_Pen p) {
  p.a(30.0,72.0,46.0,46.0,-90.0,90.0,_ink,2.4,_shade,true);
  p.l(30.0,72.0,30.0,26.0,_ink,2.4);
  p.l(30.0,72.0,76.0,72.0,_ink,2.4);
  p.g(const[38.0,72.0,38.0,64.0,30.0,64.0],_ink,1.8,null,false);
}

void _f_cir_circum(_Pen p) {
  p.e(50.0,50.0,32.0,32.0,_accent,4.0,null);
  p.e(50.0,50.0,2.0,2.0,_ink,0.0,_ink);
  p.l(50.0,50.0,52.6,50.0,_ink,1.6);
  p.l(54.6,50.0,57.2,50.0,_ink,1.6);
  p.l(59.2,50.0,61.8,50.0,_ink,1.6);
  p.l(63.8,50.0,66.4,50.0,_ink,1.6);
  p.l(68.4,50.0,71.0,50.0,_ink,1.6);
  p.l(73.0,50.0,75.6,50.0,_ink,1.6);
  p.l(77.6,50.0,80.2,50.0,_ink,1.6);
}

void _f_sol_cube(_Pen p) {
  p.g(const[22.0,34.0,68.0,34.0,68.0,80.0,22.0,80.0],_ink,2.2,null,true);
  p.l(22.0,34.0,36.0,23.0,_ink,2.2);
  p.l(68.0,34.0,82.0,23.0,_ink,2.2);
  p.l(68.0,80.0,82.0,69.0,_ink,2.2);
  p.l(36.0,23.0,82.0,23.0,_ink,2.2);
  p.l(82.0,23.0,82.0,69.0,_ink,2.2);
  p.l(22.0,80.0,24.04,78.39,_ink,1.2);
  p.l(25.62,77.16,27.66,75.55,_ink,1.2);
  p.l(29.23,74.32,31.28,72.71,_ink,1.2);
  p.l(32.85,71.47,34.9,69.87,_ink,1.2);
  p.l(36.0,69.0,36.0,66.4,_ink,1.2);
  p.l(36.0,64.4,36.0,61.8,_ink,1.2);
  p.l(36.0,59.8,36.0,57.2,_ink,1.2);
  p.l(36.0,55.2,36.0,52.6,_ink,1.2);
  p.l(36.0,50.6,36.0,48.0,_ink,1.2);
  p.l(36.0,46.0,36.0,43.4,_ink,1.2);
  p.l(36.0,41.4,36.0,38.8,_ink,1.2);
  p.l(36.0,36.8,36.0,34.2,_ink,1.2);
  p.l(36.0,32.2,36.0,29.6,_ink,1.2);
  p.l(36.0,27.6,36.0,25.0,_ink,1.2);
  p.l(36.0,69.0,38.6,69.0,_ink,1.2);
  p.l(40.6,69.0,43.2,69.0,_ink,1.2);
  p.l(45.2,69.0,47.8,69.0,_ink,1.2);
  p.l(49.8,69.0,52.4,69.0,_ink,1.2);
  p.l(54.4,69.0,57.0,69.0,_ink,1.2);
  p.l(59.0,69.0,61.6,69.0,_ink,1.2);
  p.l(63.6,69.0,66.2,69.0,_ink,1.2);
  p.l(68.2,69.0,70.8,69.0,_ink,1.2);
  p.l(72.8,69.0,75.4,69.0,_ink,1.2);
  p.l(77.4,69.0,80.0,69.0,_ink,1.2);
}

void _f_sol_cube_faces(_Pen p) {
  p.g(const[22.0,34.0,68.0,34.0,68.0,80.0,22.0,80.0],_ink,2.2,null,true);
  p.l(22.0,34.0,36.0,23.0,_ink,2.2);
  p.l(68.0,34.0,82.0,23.0,_ink,2.2);
  p.l(68.0,80.0,82.0,69.0,_ink,2.2);
  p.l(36.0,23.0,82.0,23.0,_ink,2.2);
  p.l(82.0,23.0,82.0,69.0,_ink,2.2);
  p.l(22.0,80.0,24.04,78.39,_ink,1.2);
  p.l(25.62,77.16,27.66,75.55,_ink,1.2);
  p.l(29.23,74.32,31.28,72.71,_ink,1.2);
  p.l(32.85,71.47,34.9,69.87,_ink,1.2);
  p.l(36.0,69.0,36.0,66.4,_ink,1.2);
  p.l(36.0,64.4,36.0,61.8,_ink,1.2);
  p.l(36.0,59.8,36.0,57.2,_ink,1.2);
  p.l(36.0,55.2,36.0,52.6,_ink,1.2);
  p.l(36.0,50.6,36.0,48.0,_ink,1.2);
  p.l(36.0,46.0,36.0,43.4,_ink,1.2);
  p.l(36.0,41.4,36.0,38.8,_ink,1.2);
  p.l(36.0,36.8,36.0,34.2,_ink,1.2);
  p.l(36.0,32.2,36.0,29.6,_ink,1.2);
  p.l(36.0,27.6,36.0,25.0,_ink,1.2);
  p.l(36.0,69.0,38.6,69.0,_ink,1.2);
  p.l(40.6,69.0,43.2,69.0,_ink,1.2);
  p.l(45.2,69.0,47.8,69.0,_ink,1.2);
  p.l(49.8,69.0,52.4,69.0,_ink,1.2);
  p.l(54.4,69.0,57.0,69.0,_ink,1.2);
  p.l(59.0,69.0,61.6,69.0,_ink,1.2);
  p.l(63.6,69.0,66.2,69.0,_ink,1.2);
  p.l(68.2,69.0,70.8,69.0,_ink,1.2);
  p.l(72.8,69.0,75.4,69.0,_ink,1.2);
  p.l(77.4,69.0,80.0,69.0,_ink,1.2);
}

void _f_sol_cube_edges(_Pen p) {
  p.g(const[22.0,34.0,68.0,34.0,68.0,80.0,22.0,80.0],_ink,2.2,null,true);
  p.l(22.0,34.0,36.0,23.0,_ink,2.2);
  p.l(68.0,34.0,82.0,23.0,_ink,2.2);
  p.l(68.0,80.0,82.0,69.0,_ink,2.2);
  p.l(36.0,23.0,82.0,23.0,_ink,2.2);
  p.l(82.0,23.0,82.0,69.0,_ink,2.2);
  p.l(22.0,80.0,24.04,78.39,_ink,1.2);
  p.l(25.62,77.16,27.66,75.55,_ink,1.2);
  p.l(29.23,74.32,31.28,72.71,_ink,1.2);
  p.l(32.85,71.47,34.9,69.87,_ink,1.2);
  p.l(36.0,69.0,36.0,66.4,_ink,1.2);
  p.l(36.0,64.4,36.0,61.8,_ink,1.2);
  p.l(36.0,59.8,36.0,57.2,_ink,1.2);
  p.l(36.0,55.2,36.0,52.6,_ink,1.2);
  p.l(36.0,50.6,36.0,48.0,_ink,1.2);
  p.l(36.0,46.0,36.0,43.4,_ink,1.2);
  p.l(36.0,41.4,36.0,38.8,_ink,1.2);
  p.l(36.0,36.8,36.0,34.2,_ink,1.2);
  p.l(36.0,32.2,36.0,29.6,_ink,1.2);
  p.l(36.0,27.6,36.0,25.0,_ink,1.2);
  p.l(36.0,69.0,38.6,69.0,_ink,1.2);
  p.l(40.6,69.0,43.2,69.0,_ink,1.2);
  p.l(45.2,69.0,47.8,69.0,_ink,1.2);
  p.l(49.8,69.0,52.4,69.0,_ink,1.2);
  p.l(54.4,69.0,57.0,69.0,_ink,1.2);
  p.l(59.0,69.0,61.6,69.0,_ink,1.2);
  p.l(63.6,69.0,66.2,69.0,_ink,1.2);
  p.l(68.2,69.0,70.8,69.0,_ink,1.2);
  p.l(72.8,69.0,75.4,69.0,_ink,1.2);
  p.l(77.4,69.0,80.0,69.0,_ink,1.2);
}

void _f_sol_cuboid(_Pen p) {
  p.g(const[14.0,42.0,72.0,42.0,72.0,74.0,14.0,74.0],_ink,2.2,null,true);
  p.l(14.0,42.0,28.0,31.0,_ink,2.2);
  p.l(72.0,42.0,86.0,31.0,_ink,2.2);
  p.l(72.0,74.0,86.0,63.0,_ink,2.2);
  p.l(28.0,31.0,86.0,31.0,_ink,2.2);
  p.l(86.0,31.0,86.0,63.0,_ink,2.2);
  p.l(14.0,74.0,16.04,72.39,_ink,1.2);
  p.l(17.62,71.16,19.66,69.55,_ink,1.2);
  p.l(21.23,68.32,23.28,66.71,_ink,1.2);
  p.l(24.85,65.47,26.9,63.87,_ink,1.2);
  p.l(28.0,63.0,28.0,60.4,_ink,1.2);
  p.l(28.0,58.4,28.0,55.8,_ink,1.2);
  p.l(28.0,53.8,28.0,51.2,_ink,1.2);
  p.l(28.0,49.2,28.0,46.6,_ink,1.2);
  p.l(28.0,44.6,28.0,42.0,_ink,1.2);
  p.l(28.0,40.0,28.0,37.4,_ink,1.2);
  p.l(28.0,35.4,28.0,32.8,_ink,1.2);
  p.l(28.0,63.0,30.6,63.0,_ink,1.2);
  p.l(32.6,63.0,35.2,63.0,_ink,1.2);
  p.l(37.2,63.0,39.8,63.0,_ink,1.2);
  p.l(41.8,63.0,44.4,63.0,_ink,1.2);
  p.l(46.4,63.0,49.0,63.0,_ink,1.2);
  p.l(51.0,63.0,53.6,63.0,_ink,1.2);
  p.l(55.6,63.0,58.2,63.0,_ink,1.2);
  p.l(60.2,63.0,62.8,63.0,_ink,1.2);
  p.l(64.8,63.0,67.4,63.0,_ink,1.2);
  p.l(69.4,63.0,72.0,63.0,_ink,1.2);
  p.l(74.0,63.0,76.6,63.0,_ink,1.2);
  p.l(78.6,63.0,81.2,63.0,_ink,1.2);
  p.l(83.2,63.0,85.8,63.0,_ink,1.2);
}

void _f_sol_cylinder(_Pen p) {
  p.a(50.0,30.0,26.0,9.0,180.0,180.0,_ink,2.2,null,false);
  p.a(50.0,30.0,26.0,9.0,0.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,18.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,36.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,54.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,72.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,90.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,108.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,126.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,144.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,162.0,9.9,_ink,1.2,null,false);
  p.l(24.0,30.0,24.0,72.0,_ink,2.2);
  p.l(76.0,30.0,76.0,72.0,_ink,2.2);
  p.a(50.0,72.0,26.0,9.0,0.0,180.0,_ink,2.2,null,false);
  p.a(50.0,72.0,26.0,9.0,180.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,198.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,216.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,234.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,252.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,270.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,288.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,306.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,324.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,342.0,9.9,_ink,1.2,null,false);
}

void _f_sol_cone(_Pen p) {
  p.l(50.0,20.0,24.0,70.0,_ink,2.2);
  p.l(50.0,20.0,76.0,70.0,_ink,2.2);
  p.a(50.0,70.0,26.0,9.0,0.0,180.0,_ink,2.2,null,false);
  p.a(50.0,70.0,26.0,9.0,180.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,198.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,216.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,234.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,252.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,270.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,288.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,306.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,324.0,9.9,_ink,1.2,null,false);
  p.a(50.0,70.0,26.0,9.0,342.0,9.9,_ink,1.2,null,false);
}

void _f_sol_sphere(_Pen p) {
  p.e(50.0,50.0,32.0,32.0,_ink,2.2,null);
  p.a(50.0,50.0,32.0,10.0,0.0,180.0,_ink,2.0,null,false);
  p.a(50.0,50.0,32.0,10.0,180.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,198.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,216.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,234.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,252.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,270.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,288.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,306.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,324.0,9.9,_ink,1.2,null,false);
  p.a(50.0,50.0,32.0,10.0,342.0,9.9,_ink,1.2,null,false);
}

void _f_sol_pyramid(_Pen p) {
  p.g(const[22.0,70.0,70.0,70.0,84.0,58.0,36.0,58.0],_ink,1.2,null,true);
  p.l(22.0,70.0,50.0,20.0,_ink,2.2);
  p.l(70.0,70.0,50.0,20.0,_ink,2.2);
  p.l(84.0,58.0,50.0,20.0,_ink,2.2);
  p.l(36.0,58.0,36.9,55.56,_ink,1.2);
  p.l(37.59,53.68,38.49,51.24,_ink,1.2);
  p.l(39.18,49.37,40.08,46.93,_ink,1.2);
  p.l(40.77,45.05,41.67,42.61,_ink,1.2);
  p.l(42.36,40.73,43.26,38.29,_ink,1.2);
  p.l(43.95,36.42,44.85,33.98,_ink,1.2);
  p.l(45.54,32.1,46.44,29.66,_ink,1.2);
  p.l(47.13,27.79,48.03,25.35,_ink,1.2);
  p.l(48.72,23.47,49.62,21.03,_ink,1.2);
  p.g(const[22.0,70.0,70.0,70.0,84.0,58.0],_ink,2.2,null,false);
}

void _f_sol_prism(_Pen p) {
  p.l(44.0,30.0,64.0,18.0,_ink,2.2);
  p.l(68.0,70.0,88.0,58.0,_ink,2.2);
  p.g(const[64.0,18.0,88.0,58.0],_ink,2.2,null,false);
  p.l(40.0,58.0,41.34,55.77,_ink,1.2);
  p.l(42.37,54.06,43.7,51.83,_ink,1.2);
  p.l(44.73,50.11,46.07,47.88,_ink,1.2);
  p.l(47.1,46.17,48.44,43.94,_ink,1.2);
  p.l(49.47,42.22,50.8,39.99,_ink,1.2);
  p.l(51.83,38.28,53.17,36.05,_ink,1.2);
  p.l(54.2,34.33,55.54,32.1,_ink,1.2);
  p.l(56.57,30.39,57.9,28.16,_ink,1.2);
  p.l(58.93,26.44,60.27,24.21,_ink,1.2);
  p.l(61.3,22.5,62.64,20.27,_ink,1.2);
  p.l(63.67,18.56,64.0,18.0,_ink,1.2);
  p.l(40.0,58.0,42.6,58.0,_ink,1.2);
  p.l(44.6,58.0,47.2,58.0,_ink,1.2);
  p.l(49.2,58.0,51.8,58.0,_ink,1.2);
  p.l(53.8,58.0,56.4,58.0,_ink,1.2);
  p.l(58.4,58.0,61.0,58.0,_ink,1.2);
  p.l(63.0,58.0,65.6,58.0,_ink,1.2);
  p.l(67.6,58.0,70.2,58.0,_ink,1.2);
  p.l(72.2,58.0,74.8,58.0,_ink,1.2);
  p.l(76.8,58.0,79.4,58.0,_ink,1.2);
  p.l(81.4,58.0,84.0,58.0,_ink,1.2);
  p.l(86.0,58.0,88.0,58.0,_ink,1.2);
  p.l(20.0,70.0,22.23,68.66,_ink,1.2);
  p.l(23.94,67.63,26.17,66.3,_ink,1.2);
  p.l(27.89,65.27,30.12,63.93,_ink,1.2);
  p.l(31.83,62.9,34.06,61.56,_ink,1.2);
  p.l(35.78,60.53,38.01,59.2,_ink,1.2);
  p.l(39.72,58.17,40.0,58.0,_ink,1.2);
  p.g(const[20.0,70.0,44.0,30.0,68.0,70.0],_ink,2.4,null,true);
}

void _f_sol_cyl_faces(_Pen p) {
  p.a(50.0,30.0,26.0,9.0,0.0,360.0,_accent,0.0,_shade,false);
  p.a(50.0,30.0,26.0,9.0,180.0,180.0,_ink,2.2,null,false);
  p.a(50.0,30.0,26.0,9.0,0.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,18.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,36.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,54.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,72.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,90.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,108.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,126.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,144.0,9.9,_ink,1.2,null,false);
  p.a(50.0,30.0,26.0,9.0,162.0,9.9,_ink,1.2,null,false);
  p.l(24.0,30.0,24.0,72.0,_ink,2.2);
  p.l(76.0,30.0,76.0,72.0,_ink,2.2);
  p.a(50.0,72.0,26.0,9.0,0.0,180.0,_ink,2.2,null,false);
  p.a(50.0,72.0,26.0,9.0,180.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,198.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,216.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,234.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,252.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,270.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,288.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,306.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,324.0,9.9,_ink,1.2,null,false);
  p.a(50.0,72.0,26.0,9.0,342.0,9.9,_ink,1.2,null,false);
}

void _f_line_parallel(_Pen p) {
  p.l(12.0,38.0,88.0,38.0,_ink,2.2);
  p.l(12.0,64.0,88.0,64.0,_ink,2.2);
  p.l(44.0,38.0,38.0,38.0,_accent,1.6);
  p.l(38.0,38.0,42.08,36.1,_accent,1.6);
  p.l(38.0,38.0,42.08,39.9,_accent,1.6);
  p.l(44.0,64.0,38.0,64.0,_accent,1.6);
  p.l(38.0,64.0,42.08,62.1,_accent,1.6);
  p.l(38.0,64.0,42.08,65.9,_accent,1.6);
}

void _f_line_perp(_Pen p) {
  p.l(14.0,66.0,86.0,66.0,_ink,2.2);
  p.l(50.0,18.0,50.0,86.0,_ink,2.2);
  p.g(const[58.0,66.0,58.0,58.0,50.0,58.0],_ink,1.8,null,false);
}

void _f_line_intersect(_Pen p) {
  p.l(14.0,22.0,86.0,78.0,_ink,2.2);
  p.l(14.0,78.0,86.0,22.0,_ink,2.2);
  p.e(50.0,50.0,3.0,3.0,_accent,0.0,_accent);
}

void _f_line_segment(_Pen p) {
  p.l(20.0,50.0,80.0,50.0,_ink,2.8);
  p.e(20.0,50.0,3.0,3.0,_ink,0.0,_ink);
  p.e(80.0,50.0,3.0,3.0,_ink,0.0,_ink);
  p.t('A',20.0,38.0,10.0,_ink);
  p.t('B',80.0,38.0,10.0,_ink);
}

void _f_line_ray(_Pen p) {
  p.e(18.0,50.0,3.0,3.0,_ink,0.0,_ink);
  p.l(18.0,50.0,88.0,50.0,_ink,2.6);
  p.l(88.0,50.0,83.92,51.9,_ink,2.6);
  p.l(88.0,50.0,83.92,48.1,_ink,2.6);
}

void _f_line_transversal(_Pen p) {
  p.l(10.0,36.0,90.0,36.0,_ink,2.2);
  p.l(10.0,68.0,90.0,68.0,_ink,2.2);
  p.l(44.0,36.0,38.0,36.0,_ink,1.4);
  p.l(38.0,36.0,42.08,34.1,_ink,1.4);
  p.l(38.0,36.0,42.08,37.9,_ink,1.4);
  p.l(44.0,68.0,38.0,68.0,_ink,1.4);
  p.l(38.0,68.0,42.08,66.1,_ink,1.4);
  p.l(38.0,68.0,42.08,69.9,_ink,1.4);
  p.l(28.0,20.0,72.0,84.0,_accent,2.6);
}

void _f_line_bisect(_Pen p) {
  p.l(16.0,56.0,84.0,56.0,_ink,2.6);
  p.l(33.0,53.0,33.0,59.0,_ink,2.0);
  p.l(67.0,53.0,67.0,59.0,_ink,2.0);
  p.l(50.0,22.0,50.0,24.6,_accent,2.2);
  p.l(50.0,26.6,50.0,29.2,_accent,2.2);
  p.l(50.0,31.2,50.0,33.8,_accent,2.2);
  p.l(50.0,35.8,50.0,38.4,_accent,2.2);
  p.l(50.0,40.4,50.0,43.0,_accent,2.2);
  p.l(50.0,45.0,50.0,47.6,_accent,2.2);
  p.l(50.0,49.6,50.0,52.2,_accent,2.2);
  p.l(50.0,54.2,50.0,56.8,_accent,2.2);
  p.l(50.0,58.8,50.0,61.4,_accent,2.2);
  p.l(50.0,63.4,50.0,66.0,_accent,2.2);
  p.l(50.0,68.0,50.0,70.6,_accent,2.2);
  p.l(50.0,72.6,50.0,75.2,_accent,2.2);
  p.l(50.0,77.2,50.0,79.8,_accent,2.2);
  p.l(50.0,81.8,50.0,84.4,_accent,2.2);
  p.l(50.0,86.4,50.0,88.0,_accent,2.2);
  p.g(const[57.0,56.0,57.0,49.0,50.0,49.0],_accent,1.8,null,false);
}

void _f_sym_square(_Pen p) {
  p.g(const[26.0,26.0,74.0,26.0,74.0,74.0,26.0,74.0],_ink,2.2,null,true);
  p.l(50.0,26.0,50.0,28.6,_accent,1.6);
  p.l(50.0,30.6,50.0,33.2,_accent,1.6);
  p.l(50.0,35.2,50.0,37.8,_accent,1.6);
  p.l(50.0,39.8,50.0,42.4,_accent,1.6);
  p.l(50.0,44.4,50.0,47.0,_accent,1.6);
  p.l(50.0,49.0,50.0,51.6,_accent,1.6);
  p.l(50.0,53.6,50.0,56.2,_accent,1.6);
  p.l(50.0,58.2,50.0,60.8,_accent,1.6);
  p.l(50.0,62.8,50.0,65.4,_accent,1.6);
  p.l(50.0,67.4,50.0,70.0,_accent,1.6);
  p.l(50.0,72.0,50.0,74.0,_accent,1.6);
  p.l(26.0,50.0,28.6,50.0,_accent,1.6);
  p.l(30.6,50.0,33.2,50.0,_accent,1.6);
  p.l(35.2,50.0,37.8,50.0,_accent,1.6);
  p.l(39.8,50.0,42.4,50.0,_accent,1.6);
  p.l(44.4,50.0,47.0,50.0,_accent,1.6);
  p.l(49.0,50.0,51.6,50.0,_accent,1.6);
  p.l(53.6,50.0,56.2,50.0,_accent,1.6);
  p.l(58.2,50.0,60.8,50.0,_accent,1.6);
  p.l(62.8,50.0,65.4,50.0,_accent,1.6);
  p.l(67.4,50.0,70.0,50.0,_accent,1.6);
  p.l(72.0,50.0,74.0,50.0,_accent,1.6);
  p.l(26.0,26.0,27.84,27.84,_accent,1.6);
  p.l(29.25,29.25,31.09,31.09,_accent,1.6);
  p.l(32.51,32.51,34.34,34.34,_accent,1.6);
  p.l(35.76,35.76,37.6,37.6,_accent,1.6);
  p.l(39.01,39.01,40.85,40.85,_accent,1.6);
  p.l(42.26,42.26,44.1,44.1,_accent,1.6);
  p.l(45.52,45.52,47.35,47.35,_accent,1.6);
  p.l(48.77,48.77,50.61,50.61,_accent,1.6);
  p.l(52.02,52.02,53.86,53.86,_accent,1.6);
  p.l(55.27,55.27,57.11,57.11,_accent,1.6);
  p.l(58.53,58.53,60.37,60.37,_accent,1.6);
  p.l(61.78,61.78,63.62,63.62,_accent,1.6);
  p.l(65.03,65.03,66.87,66.87,_accent,1.6);
  p.l(68.28,68.28,70.12,70.12,_accent,1.6);
  p.l(71.54,71.54,73.38,73.38,_accent,1.6);
  p.l(74.0,26.0,72.16,27.84,_accent,1.6);
  p.l(70.75,29.25,68.91,31.09,_accent,1.6);
  p.l(67.49,32.51,65.66,34.34,_accent,1.6);
  p.l(64.24,35.76,62.4,37.6,_accent,1.6);
  p.l(60.99,39.01,59.15,40.85,_accent,1.6);
  p.l(57.74,42.26,55.9,44.1,_accent,1.6);
  p.l(54.48,45.52,52.65,47.35,_accent,1.6);
  p.l(51.23,48.77,49.39,50.61,_accent,1.6);
  p.l(47.98,52.02,46.14,53.86,_accent,1.6);
  p.l(44.73,55.27,42.89,57.11,_accent,1.6);
  p.l(41.47,58.53,39.63,60.37,_accent,1.6);
  p.l(38.22,61.78,36.38,63.62,_accent,1.6);
  p.l(34.97,65.03,33.13,66.87,_accent,1.6);
  p.l(31.72,68.28,29.88,70.12,_accent,1.6);
  p.l(28.46,71.54,26.62,73.38,_accent,1.6);
}

void _f_sym_rect(_Pen p) {
  p.g(const[14.0,34.0,86.0,34.0,86.0,66.0,14.0,66.0],_ink,2.2,null,true);
  p.l(50.0,34.0,50.0,36.6,_accent,1.6);
  p.l(50.0,38.6,50.0,41.2,_accent,1.6);
  p.l(50.0,43.2,50.0,45.8,_accent,1.6);
  p.l(50.0,47.8,50.0,50.4,_accent,1.6);
  p.l(50.0,52.4,50.0,55.0,_accent,1.6);
  p.l(50.0,57.0,50.0,59.6,_accent,1.6);
  p.l(50.0,61.6,50.0,64.2,_accent,1.6);
  p.l(14.0,50.0,16.6,50.0,_accent,1.6);
  p.l(18.6,50.0,21.2,50.0,_accent,1.6);
  p.l(23.2,50.0,25.8,50.0,_accent,1.6);
  p.l(27.8,50.0,30.4,50.0,_accent,1.6);
  p.l(32.4,50.0,35.0,50.0,_accent,1.6);
  p.l(37.0,50.0,39.6,50.0,_accent,1.6);
  p.l(41.6,50.0,44.2,50.0,_accent,1.6);
  p.l(46.2,50.0,48.8,50.0,_accent,1.6);
  p.l(50.8,50.0,53.4,50.0,_accent,1.6);
  p.l(55.4,50.0,58.0,50.0,_accent,1.6);
  p.l(60.0,50.0,62.6,50.0,_accent,1.6);
  p.l(64.6,50.0,67.2,50.0,_accent,1.6);
  p.l(69.2,50.0,71.8,50.0,_accent,1.6);
  p.l(73.8,50.0,76.4,50.0,_accent,1.6);
  p.l(78.4,50.0,81.0,50.0,_accent,1.6);
  p.l(83.0,50.0,85.6,50.0,_accent,1.6);
}

void _f_sym_equi(_Pen p) {
  p.g(const[50.0,18.0,18.0,74.0,82.0,74.0],_ink,2.2,null,true);
  p.l(50.0,18.0,50.0,20.6,_accent,1.6);
  p.l(50.0,22.6,50.0,25.2,_accent,1.6);
  p.l(50.0,27.2,50.0,29.8,_accent,1.6);
  p.l(50.0,31.8,50.0,34.4,_accent,1.6);
  p.l(50.0,36.4,50.0,39.0,_accent,1.6);
  p.l(50.0,41.0,50.0,43.6,_accent,1.6);
  p.l(50.0,45.6,50.0,48.2,_accent,1.6);
  p.l(50.0,50.2,50.0,52.8,_accent,1.6);
  p.l(50.0,54.8,50.0,57.4,_accent,1.6);
  p.l(50.0,59.4,50.0,62.0,_accent,1.6);
  p.l(50.0,64.0,50.0,66.6,_accent,1.6);
  p.l(50.0,68.6,50.0,71.2,_accent,1.6);
  p.l(50.0,73.2,50.0,74.0,_accent,1.6);
  p.l(18.0,74.0,20.25,72.69,_accent,1.6);
  p.l(21.97,71.68,24.22,70.37,_accent,1.6);
  p.l(25.95,69.36,28.19,68.05,_accent,1.6);
  p.l(29.92,67.05,32.17,65.74,_accent,1.6);
  p.l(33.89,64.73,36.14,63.42,_accent,1.6);
  p.l(37.87,62.41,40.11,61.1,_accent,1.6);
  p.l(41.84,60.09,44.09,58.78,_accent,1.6);
  p.l(45.81,57.78,48.06,56.47,_accent,1.6);
  p.l(49.79,55.46,52.03,54.15,_accent,1.6);
  p.l(53.76,53.14,56.01,51.83,_accent,1.6);
  p.l(57.73,50.82,59.98,49.51,_accent,1.6);
  p.l(61.71,48.5,63.95,47.19,_accent,1.6);
  p.l(65.68,46.19,66.0,46.0,_accent,1.6);
  p.l(82.0,74.0,79.75,72.69,_accent,1.6);
  p.l(78.03,71.68,75.78,70.37,_accent,1.6);
  p.l(74.05,69.36,71.81,68.05,_accent,1.6);
  p.l(70.08,67.05,67.83,65.74,_accent,1.6);
  p.l(66.11,64.73,63.86,63.42,_accent,1.6);
  p.l(62.13,62.41,59.89,61.1,_accent,1.6);
  p.l(58.16,60.09,55.91,58.78,_accent,1.6);
  p.l(54.19,57.78,51.94,56.47,_accent,1.6);
  p.l(50.21,55.46,47.97,54.15,_accent,1.6);
  p.l(46.24,53.14,43.99,51.83,_accent,1.6);
  p.l(42.27,50.82,40.02,49.51,_accent,1.6);
  p.l(38.29,48.5,36.05,47.19,_accent,1.6);
  p.l(34.32,46.19,34.0,46.0,_accent,1.6);
}

void _f_sym_circle(_Pen p) {
  p.e(50.0,50.0,32.0,32.0,_ink,2.2,null);
  p.l(18.0,50.0,20.6,50.0,_accent,1.4);
  p.l(22.6,50.0,25.2,50.0,_accent,1.4);
  p.l(27.2,50.0,29.8,50.0,_accent,1.4);
  p.l(31.8,50.0,34.4,50.0,_accent,1.4);
  p.l(36.4,50.0,39.0,50.0,_accent,1.4);
  p.l(41.0,50.0,43.6,50.0,_accent,1.4);
  p.l(45.6,50.0,48.2,50.0,_accent,1.4);
  p.l(50.2,50.0,52.8,50.0,_accent,1.4);
  p.l(54.8,50.0,57.4,50.0,_accent,1.4);
  p.l(59.4,50.0,62.0,50.0,_accent,1.4);
  p.l(64.0,50.0,66.6,50.0,_accent,1.4);
  p.l(68.6,50.0,71.2,50.0,_accent,1.4);
  p.l(73.2,50.0,75.8,50.0,_accent,1.4);
  p.l(77.8,50.0,80.4,50.0,_accent,1.4);
  p.l(50.0,18.0,50.0,20.6,_accent,1.4);
  p.l(50.0,22.6,50.0,25.2,_accent,1.4);
  p.l(50.0,27.2,50.0,29.8,_accent,1.4);
  p.l(50.0,31.8,50.0,34.4,_accent,1.4);
  p.l(50.0,36.4,50.0,39.0,_accent,1.4);
  p.l(50.0,41.0,50.0,43.6,_accent,1.4);
  p.l(50.0,45.6,50.0,48.2,_accent,1.4);
  p.l(50.0,50.2,50.0,52.8,_accent,1.4);
  p.l(50.0,54.8,50.0,57.4,_accent,1.4);
  p.l(50.0,59.4,50.0,62.0,_accent,1.4);
  p.l(50.0,64.0,50.0,66.6,_accent,1.4);
  p.l(50.0,68.6,50.0,71.2,_accent,1.4);
  p.l(50.0,73.2,50.0,75.8,_accent,1.4);
  p.l(50.0,77.8,50.0,80.4,_accent,1.4);
  p.l(27.0,27.0,28.84,28.84,_accent,1.4);
  p.l(30.25,30.25,32.09,32.09,_accent,1.4);
  p.l(33.51,33.51,35.34,35.34,_accent,1.4);
  p.l(36.76,36.76,38.6,38.6,_accent,1.4);
  p.l(40.01,40.01,41.85,41.85,_accent,1.4);
  p.l(43.26,43.26,45.1,45.1,_accent,1.4);
  p.l(46.52,46.52,48.35,48.35,_accent,1.4);
  p.l(49.77,49.77,51.61,51.61,_accent,1.4);
  p.l(53.02,53.02,54.86,54.86,_accent,1.4);
  p.l(56.27,56.27,58.11,58.11,_accent,1.4);
  p.l(59.53,59.53,61.37,61.37,_accent,1.4);
  p.l(62.78,62.78,64.62,64.62,_accent,1.4);
  p.l(66.03,66.03,67.87,67.87,_accent,1.4);
  p.l(69.28,69.28,71.12,71.12,_accent,1.4);
  p.l(72.54,72.54,73.0,73.0,_accent,1.4);
  p.l(73.0,27.0,71.16,28.84,_accent,1.4);
  p.l(69.75,30.25,67.91,32.09,_accent,1.4);
  p.l(66.49,33.51,64.66,35.34,_accent,1.4);
  p.l(63.24,36.76,61.4,38.6,_accent,1.4);
  p.l(59.99,40.01,58.15,41.85,_accent,1.4);
  p.l(56.74,43.26,54.9,45.1,_accent,1.4);
  p.l(53.48,46.52,51.65,48.35,_accent,1.4);
  p.l(50.23,49.77,48.39,51.61,_accent,1.4);
  p.l(46.98,53.02,45.14,54.86,_accent,1.4);
  p.l(43.73,56.27,41.89,58.11,_accent,1.4);
  p.l(40.47,59.53,38.63,61.37,_accent,1.4);
  p.l(37.22,62.78,35.38,64.62,_accent,1.4);
  p.l(33.97,66.03,32.13,67.87,_accent,1.4);
  p.l(30.72,69.28,28.88,71.12,_accent,1.4);
  p.l(27.46,72.54,27.0,73.0,_accent,1.4);
}

void _f_sym_letter(_Pen p) {
  p.g(const[30.0,78.0,50.0,22.0,70.0,78.0],_ink,3.0,null,false);
  p.l(37.0,58.0,63.0,58.0,_ink,3.0);
  p.l(50.0,14.0,50.0,16.6,_accent,1.6);
  p.l(50.0,18.6,50.0,21.2,_accent,1.6);
  p.l(50.0,23.2,50.0,25.8,_accent,1.6);
  p.l(50.0,27.8,50.0,30.4,_accent,1.6);
  p.l(50.0,32.4,50.0,35.0,_accent,1.6);
  p.l(50.0,37.0,50.0,39.6,_accent,1.6);
  p.l(50.0,41.6,50.0,44.2,_accent,1.6);
  p.l(50.0,46.2,50.0,48.8,_accent,1.6);
  p.l(50.0,50.8,50.0,53.4,_accent,1.6);
  p.l(50.0,55.4,50.0,58.0,_accent,1.6);
  p.l(50.0,60.0,50.0,62.6,_accent,1.6);
  p.l(50.0,64.6,50.0,67.2,_accent,1.6);
  p.l(50.0,69.2,50.0,71.8,_accent,1.6);
  p.l(50.0,73.8,50.0,76.4,_accent,1.6);
  p.l(50.0,78.4,50.0,81.0,_accent,1.6);
  p.l(50.0,83.0,50.0,85.6,_accent,1.6);
}

void _f_sym_none(_Pen p) {
  p.g(const[8.0,38.0,34.0,38.0,34.0,64.0,8.0,64.0],_ink,2.2,null,true);
  p.e(52.0,51.0,14.0,14.0,_ink,2.2,null);
  p.g(const[70.0,64.0,92.0,64.0,86.0,38.0],_ink,2.2,null,true);
}

void _f_frac_half(_Pen p) {
  p.a(50.0,50.0,33.0,33.0,-90.0,180.0,_accent,2.2,_shade,true);
  p.e(50.0,50.0,33.0,33.0,_ink,2.4,null);
  p.l(50.0,50.0,50.0,17.0,_ink,1.6);
  p.l(50.0,50.0,50.0,83.0,_ink,1.6);
}

void _f_frac_quarter(_Pen p) {
  p.a(50.0,50.0,33.0,33.0,-90.0,90.0,_accent,2.2,_shade,true);
  p.e(50.0,50.0,33.0,33.0,_ink,2.4,null);
  p.l(50.0,50.0,50.0,17.0,_ink,1.6);
  p.l(50.0,50.0,83.0,50.0,_ink,1.6);
  p.l(50.0,50.0,50.0,83.0,_ink,1.6);
  p.l(50.0,50.0,17.0,50.0,_ink,1.6);
}

void _f_frac_threequarter(_Pen p) {
  p.a(50.0,50.0,33.0,33.0,-90.0,270.0,_accent,2.2,_shade,true);
  p.e(50.0,50.0,33.0,33.0,_ink,2.4,null);
  p.l(50.0,50.0,50.0,17.0,_ink,1.6);
  p.l(50.0,50.0,83.0,50.0,_ink,1.6);
  p.l(50.0,50.0,50.0,83.0,_ink,1.6);
  p.l(50.0,50.0,17.0,50.0,_ink,1.6);
}

void _f_frac_third(_Pen p) {
  p.a(50.0,50.0,33.0,33.0,-90.0,120.0,_accent,2.2,_shade,true);
  p.e(50.0,50.0,33.0,33.0,_ink,2.4,null);
  p.l(50.0,50.0,50.0,17.0,_ink,1.6);
  p.l(50.0,50.0,78.58,66.5,_ink,1.6);
  p.l(50.0,50.0,21.42,66.5,_ink,1.6);
}

void _f_frac_twothird(_Pen p) {
  p.a(50.0,50.0,33.0,33.0,-90.0,240.0,_accent,2.2,_shade,true);
  p.e(50.0,50.0,33.0,33.0,_ink,2.4,null);
  p.l(50.0,50.0,50.0,17.0,_ink,1.6);
  p.l(50.0,50.0,78.58,66.5,_ink,1.6);
  p.l(50.0,50.0,21.42,66.5,_ink,1.6);
}

void _f_frac_fifth(_Pen p) {
  p.a(50.0,50.0,33.0,33.0,-90.0,144.0,_accent,2.2,_shade,true);
  p.e(50.0,50.0,33.0,33.0,_ink,2.4,null);
  p.l(50.0,50.0,50.0,17.0,_ink,1.6);
  p.l(50.0,50.0,81.38,39.8,_ink,1.6);
  p.l(50.0,50.0,69.4,76.7,_ink,1.6);
  p.l(50.0,50.0,30.6,76.7,_ink,1.6);
  p.l(50.0,50.0,18.62,39.8,_ink,1.6);
}

void _f_frac_eighth(_Pen p) {
  p.a(50.0,50.0,33.0,33.0,-90.0,135.0,_accent,2.2,_shade,true);
  p.e(50.0,50.0,33.0,33.0,_ink,2.4,null);
  p.l(50.0,50.0,50.0,17.0,_ink,1.6);
  p.l(50.0,50.0,73.33,26.67,_ink,1.6);
  p.l(50.0,50.0,83.0,50.0,_ink,1.6);
  p.l(50.0,50.0,73.33,73.33,_ink,1.6);
  p.l(50.0,50.0,50.0,83.0,_ink,1.6);
  p.l(50.0,50.0,26.67,73.33,_ink,1.6);
  p.l(50.0,50.0,17.0,50.0,_ink,1.6);
  p.l(50.0,50.0,26.67,26.67,_ink,1.6);
}

void _f_frac_bar_half(_Pen p) {
  p.g(const[10.0,42.0,50.0,42.0,50.0,64.0,10.0,64.0],_accent,2.2,_shade,true);
  p.g(const[10.0,42.0,90.0,42.0,90.0,64.0,10.0,64.0],_ink,2.4,null,true);
  p.l(50.0,42.0,50.0,64.0,_ink,2.0);
}

void _f_frac_bar_quarter(_Pen p) {
  p.g(const[10.0,42.0,30.0,42.0,30.0,64.0,10.0,64.0],_accent,2.2,_shade,true);
  p.g(const[10.0,42.0,90.0,42.0,90.0,64.0,10.0,64.0],_ink,2.4,null,true);
  p.l(30.0,42.0,30.0,64.0,_ink,2.0);
  p.l(50.0,42.0,50.0,64.0,_ink,2.0);
  p.l(70.0,42.0,70.0,64.0,_ink,2.0);
}

void _f_frac_bar_threefifth(_Pen p) {
  p.g(const[10.0,42.0,58.0,42.0,58.0,64.0,10.0,64.0],_accent,2.2,_shade,true);
  p.g(const[10.0,42.0,90.0,42.0,90.0,64.0,10.0,64.0],_ink,2.4,null,true);
  p.l(26.0,42.0,26.0,64.0,_ink,2.0);
  p.l(42.0,42.0,42.0,64.0,_ink,2.0);
  p.l(58.0,42.0,58.0,64.0,_ink,2.0);
  p.l(74.0,42.0,74.0,64.0,_ink,2.0);
}

void _f_frac_equiv(_Pen p) {
  p.g(const[10.0,30.0,50.0,30.0,50.0,48.0,10.0,48.0],_accent,2.2,_shade,true);
  p.g(const[10.0,30.0,90.0,30.0,90.0,48.0,10.0,48.0],_ink,2.4,null,true);
  p.l(50.0,30.0,50.0,48.0,_ink,2.0);
  p.g(const[10.0,60.0,50.0,60.0,50.0,78.0,10.0,78.0],_accent,2.2,_shade,true);
  p.g(const[10.0,60.0,90.0,60.0,90.0,78.0,10.0,78.0],_ink,2.4,null,true);
  p.l(30.0,60.0,30.0,78.0,_ink,2.0);
  p.l(50.0,60.0,50.0,78.0,_ink,2.0);
  p.l(70.0,60.0,70.0,78.0,_ink,2.0);
}

void _f_frac_compare(_Pen p) {
  p.g(const[10.0,30.0,70.0,30.0,70.0,48.0,10.0,48.0],_accent,2.2,_shade,true);
  p.g(const[10.0,30.0,90.0,30.0,90.0,48.0,10.0,48.0],_ink,2.4,null,true);
  p.l(30.0,30.0,30.0,48.0,_ink,2.0);
  p.l(50.0,30.0,50.0,48.0,_ink,2.0);
  p.l(70.0,30.0,70.0,48.0,_ink,2.0);
  p.g(const[10.0,60.0,30.0,60.0,30.0,78.0,10.0,78.0],_accent,2.2,_shade,true);
  p.g(const[10.0,60.0,90.0,60.0,90.0,78.0,10.0,78.0],_ink,2.4,null,true);
  p.l(30.0,60.0,30.0,78.0,_ink,2.0);
  p.l(50.0,60.0,50.0,78.0,_ink,2.0);
  p.l(70.0,60.0,70.0,78.0,_ink,2.0);
}

void _f_grid_count(_Pen p) {
  p.g(const[22.0,30.0,36.0,30.0,36.0,44.0,22.0,44.0],_ink,1.5,null,true);
  p.g(const[36.0,30.0,50.0,30.0,50.0,44.0,36.0,44.0],_ink,1.5,null,true);
  p.g(const[50.0,30.0,64.0,30.0,64.0,44.0,50.0,44.0],_ink,1.5,null,true);
  p.g(const[64.0,30.0,78.0,30.0,78.0,44.0,64.0,44.0],_ink,1.5,null,true);
  p.g(const[22.0,44.0,36.0,44.0,36.0,58.0,22.0,58.0],_ink,1.5,null,true);
  p.g(const[36.0,44.0,50.0,44.0,50.0,58.0,36.0,58.0],_ink,1.5,null,true);
  p.g(const[50.0,44.0,64.0,44.0,64.0,58.0,50.0,58.0],_ink,1.5,null,true);
  p.g(const[64.0,44.0,78.0,44.0,78.0,58.0,64.0,58.0],_ink,1.5,null,true);
  p.g(const[22.0,58.0,36.0,58.0,36.0,72.0,22.0,72.0],_ink,1.5,null,true);
  p.g(const[36.0,58.0,50.0,58.0,50.0,72.0,36.0,72.0],_ink,1.5,null,true);
  p.g(const[50.0,58.0,64.0,58.0,64.0,72.0,50.0,72.0],_ink,1.5,null,true);
  p.g(const[64.0,58.0,78.0,58.0,78.0,72.0,64.0,72.0],_ink,1.5,null,true);
}

void _f_grid_area_rect(_Pen p) {
  p.g(const[22.0,30.0,36.0,30.0,36.0,44.0,22.0,44.0],_ink,1.5,_shade,true);
  p.g(const[36.0,30.0,50.0,30.0,50.0,44.0,36.0,44.0],_ink,1.5,_shade,true);
  p.g(const[50.0,30.0,64.0,30.0,64.0,44.0,50.0,44.0],_ink,1.5,_shade,true);
  p.g(const[64.0,30.0,78.0,30.0,78.0,44.0,64.0,44.0],_ink,1.5,_shade,true);
  p.g(const[22.0,44.0,36.0,44.0,36.0,58.0,22.0,58.0],_ink,1.5,_shade,true);
  p.g(const[36.0,44.0,50.0,44.0,50.0,58.0,36.0,58.0],_ink,1.5,_shade,true);
  p.g(const[50.0,44.0,64.0,44.0,64.0,58.0,50.0,58.0],_ink,1.5,_shade,true);
  p.g(const[64.0,44.0,78.0,44.0,78.0,58.0,64.0,58.0],_ink,1.5,_shade,true);
  p.g(const[22.0,58.0,36.0,58.0,36.0,72.0,22.0,72.0],_ink,1.5,_shade,true);
  p.g(const[36.0,58.0,50.0,58.0,50.0,72.0,36.0,72.0],_ink,1.5,_shade,true);
  p.g(const[50.0,58.0,64.0,58.0,64.0,72.0,50.0,72.0],_ink,1.5,_shade,true);
  p.g(const[64.0,58.0,78.0,58.0,78.0,72.0,64.0,72.0],_ink,1.5,_shade,true);
}

void _f_grid_perim(_Pen p) {
  p.g(const[22.0,30.0,36.0,30.0,36.0,44.0,22.0,44.0],_ink,1.5,_shade,true);
  p.g(const[36.0,30.0,50.0,30.0,50.0,44.0,36.0,44.0],_ink,1.5,_shade,true);
  p.g(const[50.0,30.0,64.0,30.0,64.0,44.0,50.0,44.0],_ink,1.5,_shade,true);
  p.g(const[64.0,30.0,78.0,30.0,78.0,44.0,64.0,44.0],_ink,1.5,_shade,true);
  p.g(const[22.0,44.0,36.0,44.0,36.0,58.0,22.0,58.0],_ink,1.5,_shade,true);
  p.g(const[36.0,44.0,50.0,44.0,50.0,58.0,36.0,58.0],_ink,1.5,_shade,true);
  p.g(const[50.0,44.0,64.0,44.0,64.0,58.0,50.0,58.0],_ink,1.5,_shade,true);
  p.g(const[64.0,44.0,78.0,44.0,78.0,58.0,64.0,58.0],_ink,1.5,_shade,true);
  p.g(const[22.0,58.0,36.0,58.0,36.0,72.0,22.0,72.0],_ink,1.5,_shade,true);
  p.g(const[36.0,58.0,50.0,58.0,50.0,72.0,36.0,72.0],_ink,1.5,_shade,true);
  p.g(const[50.0,58.0,64.0,58.0,64.0,72.0,50.0,72.0],_ink,1.5,_shade,true);
  p.g(const[64.0,58.0,78.0,58.0,78.0,72.0,64.0,72.0],_ink,1.5,_shade,true);
  p.g(const[22.0,30.0,78.0,30.0,78.0,72.0,22.0,72.0],_accent2,3.2,null,true);
}

void _f_grid_half_shaded(_Pen p) {
  p.g(const[22.0,22.0,36.0,22.0,36.0,36.0,22.0,36.0],_ink,1.5,_shade,true);
  p.g(const[36.0,22.0,50.0,22.0,50.0,36.0,36.0,36.0],_ink,1.5,null,true);
  p.g(const[50.0,22.0,64.0,22.0,64.0,36.0,50.0,36.0],_ink,1.5,_shade,true);
  p.g(const[64.0,22.0,78.0,22.0,78.0,36.0,64.0,36.0],_ink,1.5,null,true);
  p.g(const[22.0,36.0,36.0,36.0,36.0,50.0,22.0,50.0],_ink,1.5,null,true);
  p.g(const[36.0,36.0,50.0,36.0,50.0,50.0,36.0,50.0],_ink,1.5,_shade,true);
  p.g(const[50.0,36.0,64.0,36.0,64.0,50.0,50.0,50.0],_ink,1.5,null,true);
  p.g(const[64.0,36.0,78.0,36.0,78.0,50.0,64.0,50.0],_ink,1.5,_shade,true);
  p.g(const[22.0,50.0,36.0,50.0,36.0,64.0,22.0,64.0],_ink,1.5,_shade,true);
  p.g(const[36.0,50.0,50.0,50.0,50.0,64.0,36.0,64.0],_ink,1.5,null,true);
  p.g(const[50.0,50.0,64.0,50.0,64.0,64.0,50.0,64.0],_ink,1.5,_shade,true);
  p.g(const[64.0,50.0,78.0,50.0,78.0,64.0,64.0,64.0],_ink,1.5,null,true);
  p.g(const[22.0,64.0,36.0,64.0,36.0,78.0,22.0,78.0],_ink,1.5,null,true);
  p.g(const[36.0,64.0,50.0,64.0,50.0,78.0,36.0,78.0],_ink,1.5,_shade,true);
  p.g(const[50.0,64.0,64.0,64.0,64.0,78.0,50.0,78.0],_ink,1.5,null,true);
  p.g(const[64.0,64.0,78.0,64.0,78.0,78.0,64.0,78.0],_ink,1.5,_shade,true);
}

void _f_grid_lshape(_Pen p) {
  p.g(const[26.0,24.0,42.0,24.0,42.0,40.0,26.0,40.0],_ink,1.5,_shade,true);
  p.g(const[42.0,24.0,58.0,24.0,58.0,40.0,42.0,40.0],_ink,1.5,_shade,true);
  p.g(const[26.0,40.0,42.0,40.0,42.0,56.0,26.0,56.0],_ink,1.5,_shade,true);
  p.g(const[42.0,40.0,58.0,40.0,58.0,56.0,42.0,56.0],_ink,1.5,_shade,true);
  p.g(const[26.0,56.0,42.0,56.0,42.0,72.0,26.0,72.0],_ink,1.5,_shade,true);
  p.g(const[42.0,56.0,58.0,56.0,58.0,72.0,42.0,72.0],_ink,1.5,_shade,true);
  p.g(const[58.0,56.0,74.0,56.0,74.0,72.0,58.0,72.0],_ink,1.5,_shade,true);
  p.g(const[74.0,56.0,90.0,56.0,90.0,72.0,74.0,72.0],_ink,1.5,_shade,true);
}

void _f_grid_bigger(_Pen p) {
  p.g(const[8.0,34.0,23.0,34.0,23.0,49.0,8.0,49.0],_ink,1.5,_shade,true);
  p.g(const[23.0,34.0,38.0,34.0,38.0,49.0,23.0,49.0],_ink,1.5,_shade,true);
  p.g(const[8.0,49.0,23.0,49.0,23.0,64.0,8.0,64.0],_ink,1.5,_shade,true);
  p.g(const[23.0,49.0,38.0,49.0,38.0,64.0,23.0,64.0],_ink,1.5,_shade,true);
  p.g(const[56.0,34.0,71.0,34.0,71.0,49.0,56.0,49.0],_ink,1.5,_shade,true);
  p.g(const[71.0,34.0,86.0,34.0,86.0,49.0,71.0,49.0],_ink,1.5,_shade,true);
  p.g(const[86.0,34.0,101.0,34.0,101.0,49.0,86.0,49.0],_ink,1.5,_shade,true);
  p.g(const[56.0,49.0,71.0,49.0,71.0,64.0,56.0,64.0],_ink,1.5,_shade,true);
  p.g(const[71.0,49.0,86.0,49.0,86.0,64.0,71.0,64.0],_ink,1.5,_shade,true);
  p.g(const[86.0,49.0,101.0,49.0,101.0,64.0,86.0,64.0],_ink,1.5,_shade,true);
}

void _f_num_line_7(_Pen p) {
  p.l(8.0,52.0,94.0,52.0,_ink,2.4);
  p.l(94.0,52.0,89.92,53.9,_ink,2.4);
  p.l(94.0,52.0,89.92,50.1,_ink,2.4);
  p.l(12.0,46.0,12.0,58.0,_ink,2.2);
  p.t('0',12.0,68.0,9.0,_ink);
  p.l(19.6,48.0,19.6,56.0,_ink,1.5);
  p.l(27.2,46.0,27.2,58.0,_ink,2.2);
  p.t('2',27.2,68.0,9.0,_ink);
  p.l(34.8,48.0,34.8,56.0,_ink,1.5);
  p.l(42.4,46.0,42.4,58.0,_ink,2.2);
  p.t('4',42.4,68.0,9.0,_ink);
  p.l(50.0,48.0,50.0,56.0,_ink,1.5);
  p.l(57.6,46.0,57.6,58.0,_ink,2.2);
  p.t('6',57.6,68.0,9.0,_ink);
  p.l(65.2,48.0,65.2,56.0,_ink,1.5);
  p.l(72.8,46.0,72.8,58.0,_ink,2.2);
  p.t('8',72.8,68.0,9.0,_ink);
  p.l(80.4,48.0,80.4,56.0,_ink,1.5);
  p.l(88.0,46.0,88.0,58.0,_ink,2.2);
  p.t('10',88.0,68.0,9.0,_ink);
  p.e(65.2,52.0,3.4,3.4,_accent2,0.0,_accent2);
  p.t('?',65.2,39.0,11.0,_accent2);
}

void _f_num_line_3(_Pen p) {
  p.l(8.0,52.0,94.0,52.0,_ink,2.4);
  p.l(94.0,52.0,89.92,53.9,_ink,2.4);
  p.l(94.0,52.0,89.92,50.1,_ink,2.4);
  p.l(12.0,46.0,12.0,58.0,_ink,2.2);
  p.t('0',12.0,68.0,9.0,_ink);
  p.l(19.6,48.0,19.6,56.0,_ink,1.5);
  p.l(27.2,46.0,27.2,58.0,_ink,2.2);
  p.t('2',27.2,68.0,9.0,_ink);
  p.l(34.8,48.0,34.8,56.0,_ink,1.5);
  p.l(42.4,46.0,42.4,58.0,_ink,2.2);
  p.t('4',42.4,68.0,9.0,_ink);
  p.l(50.0,48.0,50.0,56.0,_ink,1.5);
  p.l(57.6,46.0,57.6,58.0,_ink,2.2);
  p.t('6',57.6,68.0,9.0,_ink);
  p.l(65.2,48.0,65.2,56.0,_ink,1.5);
  p.l(72.8,46.0,72.8,58.0,_ink,2.2);
  p.t('8',72.8,68.0,9.0,_ink);
  p.l(80.4,48.0,80.4,56.0,_ink,1.5);
  p.l(88.0,46.0,88.0,58.0,_ink,2.2);
  p.t('10',88.0,68.0,9.0,_ink);
  p.e(34.8,52.0,3.4,3.4,_accent2,0.0,_accent2);
  p.t('?',34.8,39.0,11.0,_accent2);
}

void _f_num_line_half(_Pen p) {
  p.l(8.0,52.0,94.0,52.0,_ink,2.4);
  p.l(94.0,52.0,89.92,53.9,_ink,2.4);
  p.l(94.0,52.0,89.92,50.1,_ink,2.4);
  p.l(12.0,46.0,12.0,58.0,_ink,2.2);
  p.t('0',12.0,68.0,9.0,_ink);
  p.l(19.6,48.0,19.6,56.0,_ink,1.5);
  p.l(27.2,46.0,27.2,58.0,_ink,2.2);
  p.t('1',27.2,68.0,9.0,_ink);
  p.l(34.8,48.0,34.8,56.0,_ink,1.5);
  p.l(42.4,46.0,42.4,58.0,_ink,2.2);
  p.t('2',42.4,68.0,9.0,_ink);
  p.l(50.0,48.0,50.0,56.0,_ink,1.5);
  p.l(57.6,46.0,57.6,58.0,_ink,2.2);
  p.t('3',57.6,68.0,9.0,_ink);
  p.l(65.2,48.0,65.2,56.0,_ink,1.5);
  p.l(72.8,46.0,72.8,58.0,_ink,2.2);
  p.t('4',72.8,68.0,9.0,_ink);
  p.l(80.4,48.0,80.4,56.0,_ink,1.5);
  p.l(88.0,46.0,88.0,58.0,_ink,2.2);
  p.t('5',88.0,68.0,9.0,_ink);
  p.e(50.0,52.0,3.4,3.4,_accent2,0.0,_accent2);
  p.t('?',50.0,39.0,11.0,_accent2);
}

void _f_num_line_neg(_Pen p) {
  p.l(8.0,52.0,94.0,52.0,_ink,2.4);
  p.l(94.0,52.0,89.92,53.9,_ink,2.4);
  p.l(94.0,52.0,89.92,50.1,_ink,2.4);
  p.l(12.0,46.0,12.0,58.0,_ink,2.2);
  p.t('-5',12.0,68.0,9.0,_ink);
  p.l(19.6,48.0,19.6,56.0,_ink,1.5);
  p.l(27.2,46.0,27.2,58.0,_ink,2.2);
  p.t('-3',27.2,68.0,9.0,_ink);
  p.l(34.8,48.0,34.8,56.0,_ink,1.5);
  p.l(42.4,46.0,42.4,58.0,_ink,2.2);
  p.t('-1',42.4,68.0,9.0,_ink);
  p.l(50.0,48.0,50.0,56.0,_ink,1.5);
  p.l(57.6,46.0,57.6,58.0,_ink,2.2);
  p.t('1',57.6,68.0,9.0,_ink);
  p.l(65.2,48.0,65.2,56.0,_ink,1.5);
  p.l(72.8,46.0,72.8,58.0,_ink,2.2);
  p.t('3',72.8,68.0,9.0,_ink);
  p.l(80.4,48.0,80.4,56.0,_ink,1.5);
  p.l(88.0,46.0,88.0,58.0,_ink,2.2);
  p.t('5',88.0,68.0,9.0,_ink);
  p.e(34.8,52.0,3.4,3.4,_accent2,0.0,_accent2);
  p.t('?',34.8,39.0,11.0,_accent2);
}

void _f_scale_ruler(_Pen p) {
  p.g(const[6.0,56.0,92.0,56.0,92.0,74.0,6.0,74.0],_ink,2.4,_paper,true);
  p.l(12.0,56.0,12.0,66.0,_ink,2.2);
  p.t('0',12.0,70.0,7.5,_ink);
  p.l(19.2,56.0,19.2,62.0,_ink,1.4);
  p.l(26.4,56.0,26.4,62.0,_ink,1.4);
  p.l(33.6,56.0,33.6,62.0,_ink,1.4);
  p.l(40.8,56.0,40.8,62.0,_ink,1.4);
  p.l(48.0,56.0,48.0,66.0,_ink,2.2);
  p.t('5',48.0,70.0,7.5,_ink);
  p.l(55.2,56.0,55.2,62.0,_ink,1.4);
  p.l(62.4,56.0,62.4,62.0,_ink,1.4);
  p.l(69.6,56.0,69.6,62.0,_ink,1.4);
  p.l(76.8,56.0,76.8,62.0,_ink,1.4);
  p.l(84.0,56.0,84.0,66.0,_ink,2.2);
  p.t('10',84.0,70.0,7.5,_ink);
  p.g(const[12.0,34.0,48.0,34.0,48.0,47.0,12.0,47.0],_accent,2.2,_shade,true);
  p.g(const[48.0,34.0,55.2,40.5,48.0,47.0],_accent,2.0,_shade,true);
  p.l(12.0,34.0,12.0,36.6,_accent2,1.2);
  p.l(12.0,38.6,12.0,41.2,_accent2,1.2);
  p.l(12.0,43.2,12.0,45.8,_accent2,1.2);
  p.l(12.0,47.8,12.0,50.4,_accent2,1.2);
  p.l(12.0,52.4,12.0,55.0,_accent2,1.2);
  p.l(55.2,40.5,55.2,43.1,_accent2,1.2);
  p.l(55.2,45.1,55.2,47.7,_accent2,1.2);
  p.l(55.2,49.7,55.2,52.3,_accent2,1.2);
  p.l(55.2,54.3,55.2,56.0,_accent2,1.2);
}

void _f_scale_ruler2(_Pen p) {
  p.g(const[6.0,56.0,92.0,56.0,92.0,74.0,6.0,74.0],_ink,2.4,_paper,true);
  p.l(12.0,56.0,12.0,66.0,_ink,2.2);
  p.t('0',12.0,70.0,7.5,_ink);
  p.l(19.2,56.0,19.2,62.0,_ink,1.4);
  p.l(26.4,56.0,26.4,62.0,_ink,1.4);
  p.l(33.6,56.0,33.6,62.0,_ink,1.4);
  p.l(40.8,56.0,40.8,62.0,_ink,1.4);
  p.l(48.0,56.0,48.0,66.0,_ink,2.2);
  p.t('5',48.0,70.0,7.5,_ink);
  p.l(55.2,56.0,55.2,62.0,_ink,1.4);
  p.l(62.4,56.0,62.4,62.0,_ink,1.4);
  p.l(69.6,56.0,69.6,62.0,_ink,1.4);
  p.l(76.8,56.0,76.8,62.0,_ink,1.4);
  p.l(84.0,56.0,84.0,66.0,_ink,2.2);
  p.t('10',84.0,70.0,7.5,_ink);
  p.g(const[12.0,34.0,76.8,34.0,76.8,47.0,12.0,47.0],_accent,2.2,_shade,true);
  p.l(12.0,34.0,12.0,36.6,_accent2,1.2);
  p.l(12.0,38.6,12.0,41.2,_accent2,1.2);
  p.l(12.0,43.2,12.0,45.8,_accent2,1.2);
  p.l(12.0,47.8,12.0,50.4,_accent2,1.2);
  p.l(12.0,52.4,12.0,55.0,_accent2,1.2);
  p.l(76.8,34.0,76.8,36.6,_accent2,1.2);
  p.l(76.8,38.6,76.8,41.2,_accent2,1.2);
  p.l(76.8,43.2,76.8,45.8,_accent2,1.2);
  p.l(76.8,47.8,76.8,50.4,_accent2,1.2);
  p.l(76.8,52.4,76.8,55.0,_accent2,1.2);
}

void _f_scale_thermo(_Pen p) {
  p.g(const[44.0,14.0,56.0,14.0,56.0,76.0,44.0,76.0],_ink,2.4,null,true);
  p.e(50.0,82.0,9.0,9.0,_ink,2.4,_shade2);
  p.g(const[46.0,46.0,54.0,46.0,54.0,76.0,46.0,76.0],_shade2,0.0,_shade2,true);
  p.l(44.0,14.0,56.0,14.0,_ink,2.0);
  p.t('50',36.0,18.0,8.0,_ink);
  p.t('40',36.0,32.0,8.0,_ink);
  p.t('30',36.0,46.0,8.0,_ink);
  p.t('20',36.0,60.0,8.0,_ink);
  p.t('10',36.0,74.0,8.0,_ink);
  p.l(56.0,18.0,62.0,18.0,_ink,1.4);
  p.l(56.0,32.0,62.0,32.0,_ink,1.4);
  p.l(56.0,46.0,66.0,46.0,_accent2,2.4);
  p.l(56.0,60.0,62.0,60.0,_ink,1.4);
  p.l(56.0,74.0,62.0,74.0,_ink,1.4);
}

void _f_scale_balance(_Pen p) {
  p.l(14.0,70.0,86.0,46.0,_ink,3.0);
  p.g(const[50.0,58.0,42.0,84.0,58.0,84.0],_ink,2.4,null,true);
  p.g(const[12.0,51.0,32.0,51.0,32.0,67.0,12.0,67.0],_accent,2.2,_shade,true);
  p.g(const[70.0,37.0,86.0,37.0,86.0,49.0,70.0,49.0],_accent,2.2,_shade,true);
}

void _f_scale_protractor(_Pen p) {
  p.a(50.0,70.0,38.0,38.0,180.0,180.0,_ink,2.4,_paper,false);
  p.l(12.0,70.0,88.0,70.0,_ink,2.4);
  p.l(50.0,70.0,88.0,70.0,_accent,2.8);
  p.l(50.0,70.0,69.0,37.0,_accent,2.8);
  p.a(50.0,70.0,18.0,18.0,-60.07,60.07,_accent2,2.0,null,false);
  p.t('?',72.94,56.74,8.5,_accent2);
  p.t('0',84.0,62.0,7.5,_ink);
  p.t('90',50.0,27.0,7.5,_ink);
  p.t('180',19.0,62.0,7.5,_ink);
}

void _f_bar_tallest(_Pen p) {
  p.l(11.0,76.0,94.0,76.0,_ink,2.4);
  p.l(11.0,76.0,11.0,18.0,_ink,2.4);
  p.g(const[16.0,45.14,29.0,45.14,29.0,76.0,16.0,76.0],_accent,1.8,_shade,true);
  p.t('Asha',22.5,87.0,7.0,_ink);
  p.t('4',22.5,39.14,8.5,_accent);
  p.g(const[35.0,22.0,48.0,22.0,48.0,76.0,35.0,76.0],_accent,1.8,_shade,true);
  p.t('Ravi',41.5,87.0,7.0,_ink);
  p.t('7',41.5,16.0,8.5,_accent);
  p.g(const[54.0,52.86,67.0,52.86,67.0,76.0,54.0,76.0],_accent,1.8,_shade,true);
  p.t('Jai',60.5,87.0,7.0,_ink);
  p.t('3',60.5,46.86,8.5,_accent);
  p.g(const[73.0,37.43,86.0,37.43,86.0,76.0,73.0,76.0],_accent,1.8,_shade,true);
  p.t('Meera',79.5,87.0,7.0,_ink);
  p.t('5',79.5,31.43,8.5,_accent);
}

void _f_bar_total(_Pen p) {
  p.l(11.0,76.0,94.0,76.0,_ink,2.4);
  p.l(11.0,76.0,11.0,18.0,_ink,2.4);
  p.g(const[16.0,46.0,29.0,46.0,29.0,76.0,16.0,76.0],_accent,1.8,_shade,true);
  p.t('1st',22.5,87.0,7.0,_ink);
  p.t('5',22.5,40.0,8.5,_accent);
  p.g(const[35.0,22.0,48.0,22.0,48.0,76.0,35.0,76.0],_accent,1.8,_shade,true);
  p.t('2nd',41.5,87.0,7.0,_ink);
  p.t('9',41.5,16.0,8.5,_accent);
  p.g(const[54.0,52.0,67.0,52.0,67.0,76.0,54.0,76.0],_accent,1.8,_shade,true);
  p.t('3rd',60.5,87.0,7.0,_ink);
  p.t('4',60.5,46.0,8.5,_accent);
  p.g(const[73.0,28.0,86.0,28.0,86.0,76.0,73.0,76.0],_accent,1.8,_shade,true);
  p.t('4th',79.5,87.0,7.0,_ink);
  p.t('8',79.5,22.0,8.5,_accent);
}

void _f_bar_diff(_Pen p) {
  p.l(11.0,76.0,94.0,76.0,_ink,2.4);
  p.l(11.0,76.0,11.0,18.0,_ink,2.4);
  p.g(const[16.0,43.6,29.0,43.6,29.0,76.0,16.0,76.0],_accent,1.8,_shade,true);
  p.t('Hari',22.5,87.0,7.0,_ink);
  p.t('6',22.5,37.6,8.5,_accent);
  p.g(const[35.0,22.0,48.0,22.0,48.0,76.0,35.0,76.0],_accent,1.8,_shade,true);
  p.t('Sita',41.5,87.0,7.0,_ink);
  p.t('10',41.5,16.0,8.5,_accent);
}

void _f_bar_fewest(_Pen p) {
  p.l(11.0,76.0,94.0,76.0,_ink,2.4);
  p.l(11.0,76.0,11.0,18.0,_ink,2.4);
  p.g(const[16.0,35.5,29.0,35.5,29.0,76.0,16.0,76.0],_accent,1.8,_shade,true);
  p.t('1st',22.5,87.0,7.0,_ink);
  p.t('6',22.5,29.5,8.5,_accent);
  p.g(const[35.0,22.0,48.0,22.0,48.0,76.0,35.0,76.0],_accent,1.8,_shade,true);
  p.t('2nd',41.5,87.0,7.0,_ink);
  p.t('8',41.5,16.0,8.5,_accent);
  p.g(const[54.0,55.75,67.0,55.75,67.0,76.0,54.0,76.0],_accent,1.8,_shade,true);
  p.t('3rd',60.5,87.0,7.0,_ink);
  p.t('3',60.5,49.75,8.5,_accent);
  p.g(const[73.0,28.75,86.0,28.75,86.0,76.0,73.0,76.0],_accent,1.8,_shade,true);
  p.t('4th',79.5,87.0,7.0,_ink);
  p.t('7',79.5,22.75,8.5,_accent);
}

void _f_chart_pie_biggest(_Pen p) {
  p.a(50.0,50.0,21.0,21.0,-90.0,160.0,_accent,1.8,_shade,true);
  p.t('Sleep',81.51,44.62,8.0,_ink);
  p.a(50.0,50.0,21.0,21.0,70.0,110.0,_accent,1.8,_shade2,true);
  p.t('Work',31.65,75.39,8.0,_ink);
  p.a(50.0,50.0,21.0,21.0,180.0,55.0,_accent,1.8,_shade3,true);
  p.t('Eat',21.62,35.69,8.0,_ink);
  p.a(50.0,50.0,21.0,21.0,235.0,35.0,_accent,1.8,_white,true);
  p.t('Rest',40.38,20.43,8.0,_ink);
  p.e(50.0,50.0,21.0,21.0,_ink,2.4,null);
}

void _f_chart_tally(_Pen p) {
  p.t('Votes',50.0,26.0,10.0,_ink);
  p.l(18.0,40.0,18.0,64.0,_ink,2.6);
  p.l(23.0,40.0,23.0,64.0,_ink,2.6);
  p.l(28.0,40.0,28.0,64.0,_ink,2.6);
  p.l(33.0,40.0,33.0,64.0,_ink,2.6);
  p.l(16.0,62.0,35.0,42.0,_accent,2.6);
  p.l(45.0,40.0,45.0,64.0,_ink,2.6);
  p.l(50.0,40.0,50.0,64.0,_ink,2.6);
  p.l(55.0,40.0,55.0,64.0,_ink,2.6);
  p.l(60.0,40.0,60.0,64.0,_ink,2.6);
  p.l(43.0,62.0,62.0,42.0,_accent,2.6);
  p.l(72.0,40.0,72.0,64.0,_ink,2.6);
  p.l(77.0,40.0,77.0,64.0,_ink,2.6);
}

void _f_chart_picto(_Pen p) {
  p.t('Cricket',22.0,34.0,9.0,_ink);
  p.e(52.0,34.0,6.0,6.0,_accent,2.2,_shade);
  p.e(68.0,34.0,6.0,6.0,_accent,2.2,_shade);
  p.e(84.0,34.0,6.0,6.0,_accent,2.2,_shade);
  p.t('Hockey',22.0,60.0,9.0,_ink);
  p.e(52.0,60.0,6.0,6.0,_accent,2.2,_shade);
  p.e(68.0,60.0,6.0,6.0,_accent,2.2,_shade);
  p.t('= 2 children',52.0,82.0,7.5,_accent2);
}

void _f_chart_line_rising(_Pen p) {
  p.l(16.0,76.0,92.0,76.0,_ink,2.4);
  p.l(16.0,76.0,16.0,20.0,_ink,2.4);
  p.g(const[22.0,70.0,42.0,58.0,62.0,42.0,84.0,26.0],_accent,3.0,null,false);
  p.e(22.0,70.0,2.6,2.6,_accent,0.0,_accent);
  p.e(42.0,58.0,2.6,2.6,_accent,0.0,_accent);
  p.e(62.0,42.0,2.6,2.6,_accent,0.0,_accent);
  p.e(84.0,26.0,2.6,2.6,_accent,0.0,_accent);
  p.t('weeks',56.0,88.0,8.0,_ink);
  p.t('height',30.0,14.0,8.0,_ink);
}

void _f_dice_pips(_Pen p) {
  p.g(const[30.0,30.0,70.0,30.0,70.0,70.0,30.0,70.0],_ink,2.4,_paper,true);
  p.e(40.0,40.0,3.4,3.4,_ink,0.0,_ink);
  p.e(60.0,40.0,3.4,3.4,_ink,0.0,_ink);
  p.e(50.0,50.0,3.4,3.4,_ink,0.0,_ink);
  p.e(40.0,60.0,3.4,3.4,_ink,0.0,_ink);
  p.e(60.0,60.0,3.4,3.4,_ink,0.0,_ink);
}

void _f_dice_total(_Pen p) {
  p.g(const[10.0,34.0,44.0,34.0,44.0,68.0,10.0,68.0],_ink,2.4,_paper,true);
  p.e(18.5,42.5,2.89,2.89,_ink,0.0,_ink);
  p.e(35.5,42.5,2.89,2.89,_ink,0.0,_ink);
  p.e(18.5,59.5,2.89,2.89,_ink,0.0,_ink);
  p.e(35.5,59.5,2.89,2.89,_ink,0.0,_ink);
  p.g(const[56.0,34.0,90.0,34.0,90.0,68.0,56.0,68.0],_ink,2.4,_paper,true);
  p.e(64.5,42.5,2.89,2.89,_ink,0.0,_ink);
  p.e(81.5,42.5,2.89,2.89,_ink,0.0,_ink);
  p.e(73.0,51.0,2.89,2.89,_ink,0.0,_ink);
  p.e(64.5,59.5,2.89,2.89,_ink,0.0,_ink);
  p.e(81.5,59.5,2.89,2.89,_ink,0.0,_ink);
}

void _f_dice_opposite(_Pen p) {
  p.g(const[30.0,30.0,70.0,30.0,70.0,70.0,30.0,70.0],_ink,2.4,_paper,true);
  p.e(40.0,40.0,3.4,3.4,_ink,0.0,_ink);
  p.e(60.0,60.0,3.4,3.4,_ink,0.0,_ink);
}

void _f_domino(_Pen p) {
  p.g(const[18.0,34.0,82.0,34.0,82.0,66.0,18.0,66.0],_ink,2.4,_paper,true);
  p.l(50.0,34.0,50.0,66.0,_ink,2.4);
  p.e(27.0,42.0,2.6,2.6,_ink,0.0,_ink);
  p.e(41.0,42.0,2.6,2.6,_ink,0.0,_ink);
  p.e(27.0,58.0,2.6,2.6,_ink,0.0,_ink);
  p.e(41.0,58.0,2.6,2.6,_ink,0.0,_ink);
  p.e(59.0,42.0,2.6,2.6,_ink,0.0,_ink);
  p.e(73.0,58.0,2.6,2.6,_ink,0.0,_ink);
  p.e(66.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_pat_dots_next(_Pen p) {
  p.e(12.0,72.0,2.8,2.8,_ink,0.0,_ink);
  p.e(33.0,62.0,2.8,2.8,_ink,0.0,_ink);
  p.e(27.0,74.0,2.8,2.8,_ink,0.0,_ink);
  p.e(39.0,74.0,2.8,2.8,_ink,0.0,_ink);
  p.e(64.0,50.0,2.8,2.8,_ink,0.0,_ink);
  p.e(58.0,62.0,2.8,2.8,_ink,0.0,_ink);
  p.e(70.0,62.0,2.8,2.8,_ink,0.0,_ink);
  p.e(52.0,74.0,2.8,2.8,_ink,0.0,_ink);
  p.e(64.0,74.0,2.8,2.8,_ink,0.0,_ink);
  p.e(76.0,74.0,2.8,2.8,_ink,0.0,_ink);
  p.t('1',12.0,88.0,9.0,_ink);
  p.t('3',33.0,88.0,9.0,_ink);
  p.t('6',64.0,88.0,9.0,_ink);
  p.t('?',93.0,70.0,14.0,_accent2);
}

void _f_pat_squares(_Pen p) {
  p.g(const[8.0,44.0,21.0,44.0,21.0,57.0,8.0,57.0],_ink,1.5,null,true);
  p.g(const[28.0,44.0,41.0,44.0,41.0,57.0,28.0,57.0],_ink,1.5,null,true);
  p.g(const[41.0,44.0,54.0,44.0,54.0,57.0,41.0,57.0],_ink,1.5,null,true);
  p.g(const[60.0,44.0,73.0,44.0,73.0,57.0,60.0,57.0],_ink,1.5,null,true);
  p.g(const[73.0,44.0,86.0,44.0,86.0,57.0,73.0,57.0],_ink,1.5,null,true);
  p.g(const[86.0,44.0,99.0,44.0,99.0,57.0,86.0,57.0],_ink,1.5,null,true);
  p.t('?',92.0,52.0,14.0,_accent2);
}

void _f_pat_shapes_next(_Pen p) {
  p.e(14.0,50.0,8.0,8.0,_ink,2.2,null);
  p.g(const[30.0,42.0,46.0,42.0,46.0,58.0,30.0,58.0],_ink,2.2,null,true);
  p.g(const[58.0,58.0,74.0,58.0,66.0,42.0],_ink,2.2,null,true);
  p.a(88.0,50.0,8.0,8.0,0.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,18.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,36.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,54.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,72.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,90.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,108.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,126.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,144.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,162.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,180.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,198.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,216.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,234.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,252.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,270.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,288.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,306.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,324.0,9.9,_accent,1.4,null,false);
  p.a(88.0,50.0,8.0,8.0,342.0,9.9,_accent,1.4,null,false);
  p.t('?',88.0,50.0,12.0,_accent2);
}

void _f_pat_odd_one(_Pen p) {
  p.g(const[6.0,40.0,26.0,40.0,26.0,60.0,6.0,60.0],_ink,2.2,null,true);
  p.g(const[32.0,62.0,52.0,62.0,42.0,40.0],_ink,2.2,null,true);
  p.g(const[58.0,44.0,82.0,44.0,82.0,58.0,58.0,58.0],_ink,2.2,null,true);
  p.g(const[92.0,38.0,99.0,51.0,92.0,64.0,85.0,51.0],_ink,2.2,null,true);
}

void _f_pat_matchstick(_Pen p) {
  p.g(const[20.0,40.0,40.0,40.0,40.0,60.0,20.0,60.0],_ink,1.5,null,true);
  p.g(const[40.0,40.0,60.0,40.0,60.0,60.0,40.0,60.0],_ink,1.5,null,true);
  p.g(const[60.0,40.0,80.0,40.0,80.0,60.0,60.0,60.0],_ink,1.5,null,true);
  p.t('?',50.0,76.0,12.0,_accent2);
}

void _f_pat_shaded_next(_Pen p) {
  p.g(const[14.0,22.0,31.0,22.0,31.0,39.0,14.0,39.0],_ink,1.5,_shade,true);
  p.g(const[31.0,22.0,48.0,22.0,48.0,39.0,31.0,39.0],_ink,1.5,null,true);
  p.g(const[48.0,22.0,65.0,22.0,65.0,39.0,48.0,39.0],_ink,1.5,null,true);
  p.g(const[65.0,22.0,82.0,22.0,82.0,39.0,65.0,39.0],_ink,1.5,null,true);
  p.g(const[14.0,44.0,31.0,44.0,31.0,61.0,14.0,61.0],_ink,1.5,null,true);
  p.g(const[31.0,44.0,48.0,44.0,48.0,61.0,31.0,61.0],_ink,1.5,_shade,true);
  p.g(const[48.0,44.0,65.0,44.0,65.0,61.0,48.0,61.0],_ink,1.5,null,true);
  p.g(const[65.0,44.0,82.0,44.0,82.0,61.0,65.0,61.0],_ink,1.5,null,true);
  p.g(const[14.0,66.0,31.0,66.0,31.0,83.0,14.0,83.0],_ink,1.5,null,true);
  p.g(const[31.0,66.0,48.0,66.0,48.0,83.0,31.0,83.0],_ink,1.5,null,true);
  p.g(const[48.0,66.0,65.0,66.0,65.0,83.0,48.0,83.0],_ink,1.5,_shade,true);
  p.g(const[65.0,66.0,82.0,66.0,82.0,83.0,65.0,83.0],_ink,1.5,null,true);
}

void _f_pat_number_pyr(_Pen p) {
  p.g(const[38.0,24.0,62.0,24.0,62.0,42.0,38.0,42.0],_ink,2.4,null,true);
  p.t('?',50.0,36.0,12.0,_accent2);
  p.g(const[22.0,48.0,46.0,48.0,46.0,66.0,22.0,66.0],_ink,2.4,null,true);
  p.t('5',34.0,60.0,11.0,_ink);
  p.g(const[54.0,48.0,78.0,48.0,78.0,66.0,54.0,66.0],_ink,2.4,null,true);
  p.t('7',66.0,60.0,11.0,_ink);
  p.g(const[6.0,72.0,30.0,72.0,30.0,90.0,6.0,90.0],_ink,2.4,null,true);
  p.t('2',18.0,84.0,11.0,_ink);
  p.g(const[38.0,72.0,62.0,72.0,62.0,90.0,38.0,90.0],_ink,2.4,null,true);
  p.t('3',50.0,84.0,11.0,_ink);
  p.g(const[70.0,72.0,94.0,72.0,94.0,90.0,70.0,90.0],_ink,2.4,null,true);
  p.t('4',82.0,84.0,11.0,_ink);
}

void _f_clk_3(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,67.68,50.0,_ink,4.0);
  p.l(50.0,50.0,50.0,22.8,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_6(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,50.0,67.68,_ink,4.0);
  p.l(50.0,50.0,50.0,22.8,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_half6(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,45.42,67.08,_ink,4.0);
  p.l(50.0,50.0,50.0,77.2,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_quarterpast9(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,32.47,47.69,_ink,4.0);
  p.l(50.0,50.0,77.2,50.0,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_quarterto5(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,60.76,64.03,_ink,4.0);
  p.l(50.0,50.0,22.8,50.0,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_10past2(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,66.02,42.53,_ink,4.0);
  p.l(50.0,50.0,73.56,36.4,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_20to8(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,36.46,61.36,_ink,4.0);
  p.l(50.0,50.0,26.44,63.6,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_745(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,35.97,60.76,_ink,4.0);
  p.l(50.0,50.0,22.8,50.0,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_angle3(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,67.68,50.0,_ink,4.0);
  p.l(50.0,50.0,50.0,22.8,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
  p.a(50.0,50.0,15.0,15.0,-90.0,90.0,_accent2,2.0,null,false);
}

void _f_clk_angle6(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,50.0,67.68,_ink,4.0);
  p.l(50.0,50.0,50.0,22.8,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
  p.a(50.0,50.0,13.0,13.0,-90.0,180.0,_accent2,2.0,null,false);
}

void _f_clk_minute_hand(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,35.52,39.86,_ink,4.0);
  p.l(50.0,50.0,73.56,36.4,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_clk_half_hour(_Pen p) {
  p.e(50.0,50.0,34.0,34.0,_ink,2.6,_paper);
  p.l(50.0,22.0,50.0,17.0,_ink,2.6);
  p.l(65.25,23.59,66.5,21.42,_ink,1.6);
  p.l(76.41,34.75,78.58,33.5,_ink,1.6);
  p.l(78.0,50.0,83.0,50.0,_ink,2.6);
  p.l(76.41,65.25,78.58,66.5,_ink,1.6);
  p.l(65.25,76.41,66.5,78.58,_ink,1.6);
  p.l(50.0,78.0,50.0,83.0,_ink,2.6);
  p.l(34.75,76.41,33.5,78.58,_ink,1.6);
  p.l(23.59,65.25,21.42,66.5,_ink,1.6);
  p.l(22.0,50.0,17.0,50.0,_ink,2.6);
  p.l(23.59,34.75,21.42,33.5,_ink,1.6);
  p.l(34.75,23.59,33.5,21.42,_ink,1.6);
  p.t('12',50.0,29.0,9.5,_ink);
  p.t('3',71.0,50.0,9.5,_ink);
  p.t('6',50.0,71.0,9.5,_ink);
  p.t('9',29.0,50.0,9.5,_ink);
  p.l(50.0,50.0,32.92,54.58,_ink,4.0);
  p.l(50.0,50.0,50.0,77.2,_accent,2.6);
  p.e(50.0,50.0,2.6,2.6,_ink,0.0,_ink);
}

void _f_flag_japan(_Pen p) {
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,_white,true);
  p.e(50.0,59.0,15.0,15.0,_red,0.0,_red);
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,null,true);
}

void _f_flag_bangladesh(_Pen p) {
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_green,0.0,_green,true);
  p.e(45.0,59.0,14.0,14.0,_red,0.0,_red);
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,null,true);
}

void _f_flag_india(_Pen p) {
  p.g(const[12.0,34.0,88.0,34.0,88.0,50.7,12.0,50.7],_saffron,0.0,_saffron,true);
  p.g(const[12.0,50.7,88.0,50.7,88.0,67.4,12.0,67.4],_white,0.0,_white,true);
  p.g(const[12.0,67.3,88.0,67.3,88.0,84.0,12.0,84.0],_green,0.0,_green,true);
  p.e(50.0,59.0,7.0,7.0,_navy,1.8,null);
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,null,true);
}

void _f_flag_france(_Pen p) {
  p.g(const[12.0,34.0,37.3,34.0,37.3,84.0,12.0,84.0],_blue,0.0,_blue,true);
  p.g(const[37.3,34.0,62.6,34.0,62.6,84.0,37.3,84.0],_white,0.0,_white,true);
  p.g(const[62.6,34.0,88.0,34.0,88.0,84.0,62.6,84.0],_red,0.0,_red,true);
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,null,true);
}

void _f_flag_italy(_Pen p) {
  p.g(const[12.0,34.0,37.3,34.0,37.3,84.0,12.0,84.0],_green,0.0,_green,true);
  p.g(const[37.3,34.0,62.6,34.0,62.6,84.0,37.3,84.0],_white,0.0,_white,true);
  p.g(const[62.6,34.0,88.0,34.0,88.0,84.0,62.6,84.0],_red,0.0,_red,true);
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,null,true);
}

void _f_flag_switzerland(_Pen p) {
  p.g(const[25.0,34.0,75.0,34.0,75.0,84.0,25.0,84.0],_red,0.0,_red,true);
  p.g(const[45.0,46.0,55.0,46.0,55.0,72.0,45.0,72.0],_white,0.0,_white,true);
  p.g(const[37.0,54.0,63.0,54.0,63.0,64.0,37.0,64.0],_white,0.0,_white,true);
  p.g(const[25.0,34.0,75.0,34.0,75.0,84.0,25.0,84.0],_ink,2.2,null,true);
}

void _f_flag_indonesia(_Pen p) {
  p.g(const[12.0,34.0,88.0,34.0,88.0,59.0,12.0,59.0],_red,0.0,_red,true);
  p.g(const[12.0,59.0,88.0,59.0,88.0,84.0,12.0,84.0],_white,0.0,_white,true);
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,null,true);
}

void _f_flag_nepal(_Pen p) {
  p.g(const[30.0,20.0,66.0,44.0,30.0,44.0,70.0,70.0,30.0,70.0],_navy,2.6,_red,true);
  p.l(30.0,20.0,30.0,86.0,_navy,2.6);
  p.e(40.0,36.0,4.0,4.0,_white,1.6,null);
  p.e(40.0,60.0,4.6,4.6,_white,1.6,null);
}

void _f_flag_tricolour_bands(_Pen p) {
  p.g(const[12.0,34.0,88.0,34.0,88.0,50.7,12.0,50.7],_saffron,0.0,_saffron,true);
  p.g(const[12.0,50.7,88.0,50.7,88.0,67.4,12.0,67.4],_white,0.0,_white,true);
  p.g(const[12.0,67.3,88.0,67.3,88.0,84.0,12.0,84.0],_green,0.0,_green,true);
  p.e(50.0,59.0,7.0,7.0,_navy,1.8,null);
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,null,true);
}

void _f_flag_chakra(_Pen p) {
  p.g(const[12.0,34.0,88.0,34.0,88.0,50.7,12.0,50.7],_saffron,0.0,_saffron,true);
  p.g(const[12.0,50.7,88.0,50.7,88.0,67.4,12.0,67.4],_white,0.0,_white,true);
  p.g(const[12.0,67.3,88.0,67.3,88.0,84.0,12.0,84.0],_green,0.0,_green,true);
  p.e(50.0,59.0,8.0,8.0,_navy,2.0,null);
  p.l(50.0,59.0,58.0,59.0,_navy,1.0);
  p.l(50.0,59.0,56.93,63.0,_navy,1.0);
  p.l(50.0,59.0,54.0,65.93,_navy,1.0);
  p.l(50.0,59.0,50.0,67.0,_navy,1.0);
  p.l(50.0,59.0,46.0,65.93,_navy,1.0);
  p.l(50.0,59.0,43.07,63.0,_navy,1.0);
  p.l(50.0,59.0,42.0,59.0,_navy,1.0);
  p.l(50.0,59.0,43.07,55.0,_navy,1.0);
  p.l(50.0,59.0,46.0,52.07,_navy,1.0);
  p.l(50.0,59.0,50.0,51.0,_navy,1.0);
  p.l(50.0,59.0,54.0,52.07,_navy,1.0);
  p.l(50.0,59.0,56.93,55.0,_navy,1.0);
  p.g(const[12.0,34.0,88.0,34.0,88.0,84.0,12.0,84.0],_ink,2.2,null,true);
}

void _f_sci_magnet(_Pen p) {
  p.g(const[16.0,42.0,84.0,42.0,84.0,64.0,16.0,64.0],_ink,2.4,_shade,true);
  p.g(const[16.0,42.0,38.0,42.0,38.0,64.0,16.0,64.0],_red,0.0,_red,true);
  p.g(const[62.0,42.0,84.0,42.0,84.0,64.0,62.0,64.0],_navy,0.0,_navy,true);
  p.g(const[16.0,42.0,84.0,42.0,84.0,64.0,16.0,64.0],_ink,2.4,null,true);
  p.t('N',27.0,56.0,12.0,_white);
  p.t('S',73.0,56.0,12.0,_white);
}

void _f_sci_circuit(_Pen p) {
  p.g(const[20.0,28.0,80.0,28.0,80.0,76.0,20.0,76.0],_ink,2.4,null,true);
  p.g(const[14.0,46.0,26.0,46.0,26.0,54.0,14.0,54.0],_ink,2.0,_shade,true);
  p.l(20.0,46.0,20.0,40.0,_ink,2.0);
  p.l(20.0,54.0,20.0,60.0,_ink,2.0);
  p.t('+',8.0,44.0,9.0,_ink);
  p.e(50.0,28.0,8.0,8.0,_ink,2.4,_paper);
  p.l(44.0,22.0,56.0,34.0,_ink,1.6);
  p.l(56.0,22.0,44.0,34.0,_ink,1.6);
  p.l(62.0,76.0,74.0,70.0,_ink,2.4);
  p.e(62.0,76.0,2.4,2.4,_ink,0.0,_ink);
  p.e(78.0,76.0,2.4,2.4,_ink,0.0,_ink);
}

void _f_sci_moon(_Pen p) {
  p.e(20.0,50.0,13.0,13.0,_ink,2.2,_ink);
  p.e(50.0,50.0,13.0,13.0,_ink,2.2,_ink);
  p.a(50.0,50.0,13.0,13.0,-90.0,180.0,_shade2,0.0,_shade2,true);
  p.e(50.0,50.0,13.0,13.0,_ink,2.2,null);
  p.e(80.0,50.0,13.0,13.0,_ink,2.2,_shade2);
}

void _f_sci_plant(_Pen p) {
  p.l(50.0,34.0,50.0,66.0,_ink,3.0);
  p.a(50.0,42.0,12.0,12.0,160.0,120.0,_ink,2.2,_shade,false);
  p.a(50.0,42.0,12.0,12.0,260.0,120.0,_ink,2.2,_shade,false);
  p.e(50.0,28.0,7.0,7.0,_ink,2.2,_shade2);
  p.l(50.0,66.0,42.0,82.0,_ink,2.2);
  p.l(50.0,66.0,58.0,82.0,_ink,2.2);
  p.l(50.0,66.0,50.0,86.0,_ink,2.2);
  p.l(86.0,84.0,58.0,79.0,_accent2,2.4);
  p.l(58.0,79.0,62.35,77.84,_accent2,2.4);
  p.l(58.0,79.0,61.68,81.59,_accent2,2.4);
}

void _f_sci_shadow(_Pen p) {
  p.e(14.0,24.0,9.0,9.0,_accent,2.2,_shade2);
  p.l(50.0,40.0,50.0,76.0,_ink,3.0);
  p.e(50.0,32.0,12.0,12.0,_ink,2.2,_shade);
  p.l(12.0,76.0,92.0,76.0,_ink,2.4);
  p.g(const[50.0,76.0,84.0,76.0,78.0,82.0,50.0,82.0],_accent2,1.8,_shade3,true);
}

void _f_sci_compass(_Pen p) {
  p.e(50.0,54.0,30.0,30.0,_ink,2.4,_paper);
  p.l(50.0,54.0,50.0,28.0,_accent2,3.0);
  p.l(50.0,28.0,51.9,32.08,_accent2,3.0);
  p.l(50.0,28.0,48.1,32.08,_accent2,3.0);
  p.t('N',50.0,18.0,11.0,_accent2);
  p.t('S',50.0,90.0,11.0,_ink);
  p.t('E',86.0,58.0,11.0,_ink);
  p.t('W',14.0,58.0,11.0,_ink);
  p.l(50.0,54.0,50.0,80.0,_ink,2.0);
  p.l(50.0,54.0,76.0,54.0,_ink,2.0);
  p.l(50.0,54.0,24.0,54.0,_ink,2.0);
}

void _f_sci_states(_Pen p) {
  p.g(const[8.0,34.0,32.0,34.0,32.0,68.0,8.0,68.0],_ink,2.2,null,true);
  p.e(13.0,39.0,2.4,2.4,_ink,0.0,_ink);
  p.e(20.0,39.0,2.4,2.4,_ink,0.0,_ink);
  p.e(27.0,39.0,2.4,2.4,_ink,0.0,_ink);
  p.e(13.0,47.0,2.4,2.4,_ink,0.0,_ink);
  p.e(20.0,47.0,2.4,2.4,_ink,0.0,_ink);
  p.e(27.0,47.0,2.4,2.4,_ink,0.0,_ink);
  p.e(13.0,55.0,2.4,2.4,_ink,0.0,_ink);
  p.e(20.0,55.0,2.4,2.4,_ink,0.0,_ink);
  p.e(27.0,55.0,2.4,2.4,_ink,0.0,_ink);
  p.e(13.0,63.0,2.4,2.4,_ink,0.0,_ink);
  p.e(20.0,63.0,2.4,2.4,_ink,0.0,_ink);
  p.e(27.0,63.0,2.4,2.4,_ink,0.0,_ink);
  p.g(const[38.0,34.0,62.0,34.0,62.0,68.0,38.0,68.0],_ink,2.2,null,true);
  p.g(const[38.0,52.0,62.0,52.0,62.0,68.0,38.0,68.0],_accent,1.8,_shade,true);
  p.g(const[38.0,34.0,62.0,34.0,62.0,68.0,38.0,68.0],_ink,2.2,null,true);
  p.g(const[68.0,34.0,92.0,34.0,92.0,68.0,68.0,68.0],_ink,2.2,null,true);
  p.e(74.0,40.0,2.2,2.2,_ink,0.0,_ink);
  p.e(85.0,46.0,2.2,2.2,_ink,0.0,_ink);
  p.e(72.0,54.0,2.2,2.2,_ink,0.0,_ink);
  p.e(86.0,62.0,2.2,2.2,_ink,0.0,_ink);
  p.e(78.0,66.0,2.2,2.2,_ink,0.0,_ink);
  p.e(80.0,36.0,2.2,2.2,_ink,0.0,_ink);
}

void _f_sci_eclipse(_Pen p) {
  p.e(16.0,54.0,13.0,13.0,_accent,2.2,_shade2);
  p.t('Sun',16.0,76.0,7.5,_ink);
  p.e(50.0,54.0,6.0,6.0,_ink,2.2,_ink);
  p.t('Moon',50.0,70.0,7.5,_ink);
  p.e(84.0,54.0,10.0,10.0,_ink,2.2,_shade);
  p.t('Earth',84.0,74.0,7.5,_ink);
  p.l(29.0,46.0,31.59,46.23,_ink,1.2);
  p.l(33.58,46.41,36.17,46.64,_ink,1.2);
  p.l(38.16,46.81,40.75,47.04,_ink,1.2);
  p.l(42.75,47.22,45.34,47.45,_ink,1.2);
  p.l(47.33,47.63,49.92,47.86,_ink,1.2);
  p.l(51.91,48.04,54.5,48.27,_ink,1.2);
  p.l(56.49,48.44,59.08,48.67,_ink,1.2);
  p.l(61.07,48.85,63.66,49.08,_ink,1.2);
  p.l(65.66,49.26,68.25,49.49,_ink,1.2);
  p.l(70.24,49.67,72.83,49.9,_ink,1.2);
  p.l(29.0,62.0,31.59,61.77,_ink,1.2);
  p.l(33.58,61.59,36.17,61.36,_ink,1.2);
  p.l(38.16,61.19,40.75,60.96,_ink,1.2);
  p.l(42.75,60.78,45.34,60.55,_ink,1.2);
  p.l(47.33,60.37,49.92,60.14,_ink,1.2);
  p.l(51.91,59.96,54.5,59.73,_ink,1.2);
  p.l(56.49,59.56,59.08,59.33,_ink,1.2);
  p.l(61.07,59.15,63.66,58.92,_ink,1.2);
  p.l(65.66,58.74,68.25,58.51,_ink,1.2);
  p.l(70.24,58.33,72.83,58.1,_ink,1.2);
}

/// True when [id] names a figure this build can draw.
bool hasQuizFigure(String id) => _figures.containsKey(id);

/// The picture for a question, on its own panel.
///
/// Returns an empty box for an unknown id rather than throwing: a question
/// whose figure went missing should still be answerable.
class QuizFigure extends StatelessWidget {
  const QuizFigure(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    final draw = _figures[id];
    if (draw == null) return const SizedBox.shrink();
    final side = quizFigureSide(context);
    return Semantics(
      label: SeniorStrings.of(context).figureLabel,
      child: Container(
        width: side,
        height: side,
        decoration: BoxDecoration(
          color: _paper,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: _accent, width: 2.0),
        ),
        child: CustomPaint(
          size: Size(side, side),
          painter: _FigurePainter(draw),
        ),
      ),
    );
  }
}

class _FigurePainter extends CustomPainter {
  const _FigurePainter(this.draw);

  final _QuizFigureDraw draw;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    // A uniform scale, centred, so nothing is ever stretched out of shape.
    final scale = math.min(size.width, size.height) / 100.0;
    final org = Offset(
      (size.width - 100.0 * scale) / 2.0,
      (size.height - 100.0 * scale) / 2.0,
    );
    draw(_Pen(canvas, scale, org));
  }

  @override
  bool shouldRepaint(covariant _FigurePainter old) => old.draw != draw;
}
