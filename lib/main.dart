// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/gestures/pan_zoom.dart';
import 'package:subdivide/model/generate.dart';
import 'package:subdivide/view/main_page.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/model/shape_notifier.dart';
import 'package:subdivide/view/hue.dart';
import 'package:subdivide/view/screen_adjust.dart';

/// prevent 'organise imports' from removing imports
/// when temporarily commenting out.
const noWarn = out;

void main() => runApp(createApp());

Widget createApp() => const TheApp();

/// The only App in this app.
class TheApp extends StatelessWidget {
  const TheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PanZoomNotifier()),
        ChangeNotifierProvider(create: (_) => ShapeNotifier()),
      ],
      child: MaterialApp(
        theme: _buildThemeData(context),
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxHeight == 0) {
              return Container();
            } else {
              final panZoomNotifier =
                  getPanZoomNotifier(context, listen: false);

              // Initialize once only
              if (panZoomNotifier.scale == 0) {
                panZoomNotifier.initializeScale(screenAdjust(0.06494, context));

                final shapeNotifier= getShapeNotifier(context, listen: false);

                shapeNotifier.init(generateShapeData());
              }

              // final
              return WillPopScope(
                onWillPop: () async => false,
                child: Stack(
                  children: const [
                    MainPage(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      canvasColor: Hue.menu,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Hue.text),
      // for icon buttons only atm
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: Hue.enabledIcon,
          ),
      tooltipTheme: TooltipThemeData(
        /// TODO Responsive to screen size - removed magic numbers
        verticalOffset: 55,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Hue.tip),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: Hue.button,
      )),
    );
  }
}

