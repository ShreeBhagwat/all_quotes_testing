import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const double PIXEL_2_HEIGHT = 1920;
const double PIXEL_2_WIDTH = 1080;

const double PIXEL_2_X_HEIGHT = 2160;
const double PIXEL_2_X_WIDTH = 1080;

const double IPHONE_13_HEIGHT = 2532;
const double IPHONE_13_WIDTH = 1170;

const double IPHONE_13_PRO_HEIGHT = 2778;
const double IPHONE_13_PRO_WIDTH = 1284;

const double GALAXY_S21_HEIGHT = 2400;
const double GALAXY_S21_WIDTH = 1080;

const double GALAXY_TAB_HEIGHT = 2560;
const double GALAXY_TAB_WIDTH = 1600;

const double IPAD_PRO_HEIGHT = 2732;
const double IPAD_PRO_WIDTH = 2048;

const double webHeight = 1080;
const double webWidth = 1920;

const double IPHONE_13_PIXEL_RATIO = 3.0;
const double PIXEL_2_PIXEL_RATIO = 2.625;
const double IPAD_PRO_PIXEL_RATIO = 4.0;

class TestCaseScreenInfo {
  final String deviceName;
  final Size screenSize;
  final double pixelRatio;
  final double textScaleValue;

  const TestCaseScreenInfo({
    required this.deviceName,
    required this.screenSize,
    required this.pixelRatio,
    required this.textScaleValue,
  });
}

const testCaseScreenInfoList = [
  TestCaseScreenInfo(
      deviceName: 'Pixel-2-Portrait',
      screenSize: Size(PIXEL_2_WIDTH, PIXEL_2_HEIGHT),
      pixelRatio: PIXEL_2_PIXEL_RATIO,
      textScaleValue: 1.0),
  TestCaseScreenInfo(
      deviceName: 'Pixel-2-Landscape',
      screenSize: Size(PIXEL_2_HEIGHT, PIXEL_2_WIDTH),
      pixelRatio: PIXEL_2_PIXEL_RATIO,
      textScaleValue: 1.0),
  TestCaseScreenInfo(
      deviceName: 'iphone-13-Portrait',
      screenSize: Size(IPHONE_13_WIDTH, IPHONE_13_HEIGHT),
      pixelRatio: IPHONE_13_PIXEL_RATIO,
      textScaleValue: 1.0),

  // iphone 13 Landscape
  TestCaseScreenInfo(
      deviceName: 'iphone-13-Landscape',
      screenSize: Size(IPHONE_13_HEIGHT, IPHONE_13_WIDTH),
      pixelRatio: IPHONE_13_PIXEL_RATIO,
      textScaleValue: 1.0),

  // ipad pro Portrait
  TestCaseScreenInfo(
      deviceName: 'ipad-pro-Portrait',
      screenSize: Size(IPAD_PRO_WIDTH, IPAD_PRO_HEIGHT),
      pixelRatio: IPAD_PRO_PIXEL_RATIO,
      textScaleValue: 1.0),

  // ipad pro Landscape
  TestCaseScreenInfo(
      deviceName: 'ipad-pro-Landscape',
      screenSize: Size(IPAD_PRO_HEIGHT, IPAD_PRO_WIDTH),
      pixelRatio: IPAD_PRO_PIXEL_RATIO,
      textScaleValue: 1.0),

  // galaxy tab Portrait
  TestCaseScreenInfo(
      deviceName: 'galaxy-tab-Portrait',
      screenSize: Size(GALAXY_TAB_WIDTH, GALAXY_TAB_HEIGHT),
      pixelRatio: IPAD_PRO_PIXEL_RATIO,
      textScaleValue: 1.0),

  // galaxy tab Landscape
  TestCaseScreenInfo(
      deviceName: 'galaxy-tab-Landscape',
      screenSize: Size(GALAXY_TAB_HEIGHT, GALAXY_TAB_WIDTH),
      pixelRatio: IPAD_PRO_PIXEL_RATIO,
      textScaleValue: 1.0),
];

extension WidgetTesterExtension on WidgetTester {
  Future setScreenSize(TestCaseScreenInfo testCaseScreenInfo) async {
    binding.platformDispatcher.textScaleFactorTestValue =
        testCaseScreenInfo.textScaleValue;

    binding.window.physicalSizeTestValue = testCaseScreenInfo.screenSize;
    binding.window.devicePixelRatioTestValue = testCaseScreenInfo.pixelRatio;
    addTearDown(binding.window.clearPhysicalSizeTestValue);
  }
}

Future testWidgetsMultipleScreenSize(
  String testName,
  Future<void> Function(WidgetTester, TestCaseScreenInfo testCase) testFunction,
) async =>
    testCaseScreenInfoList.forEach(
      (testCase) async {
        WidgetController.hitTestWarningShouldBeFatal = false;
        testWidgets("$testName-${testCase.deviceName}", (tester) async {
          final roboto = rootBundle.load('assets/fonts/Roboto-Regular.ttf');
          final fontLoader = FontLoader('Roboto')..addFont(roboto);
          await fontLoader.load();
          await tester.setScreenSize(testCase);
          await testFunction(tester, testCase);
        });
      },
    );

Future doGoldens(
        String page, String state, TestCaseScreenInfo? testCaseScreenInfo) =>
    testCaseScreenInfo != null
        ? doGoldensGeneric<MaterialApp>(page, state, testCaseScreenInfo)
        : Future.value();

String getGoldenName(
        String page, String state, TestCaseScreenInfo testCaseScreenInfo) =>
    'goldens/$page-$state=${testCaseScreenInfo.deviceName}.png';

Future doGoldensGeneric<T>(
        String page, String state, TestCaseScreenInfo testCaseScreenInfo) =>
    expectLater(find.byType(T),
        matchesGoldenFile(getGoldenName(page, state, testCaseScreenInfo)));
