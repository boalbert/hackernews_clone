import 'package:flutter_test/flutter_test.dart';
import 'package:hackernews/util/string_helper.dart';

void main() {
  test('HTTPS parse base String', () {
    String testUrl = 'https://arnoldgalovics.com/microservices-in-production/';
    String result = StringHelper().parseBaseUrl(testUrl);

    String expectedUrl = 'arnoldgalovics.com'.toUpperCase();

    expect(result, expectedUrl);
  });

  test('HTTP parse base String', () {
    String testUrl = 'http://arnoldgalovics.com/microservices-in-production/';
    String result = StringHelper().parseBaseUrl(testUrl);

    String expectedUrl = 'arnoldgalovics.com'.toUpperCase();

    expect(result, expectedUrl);
  });

  test('No prefix -  base String', () {
    String testUrl = 'arnoldgalovics.com/microservices-in-production/';
    String result = StringHelper().parseBaseUrl(testUrl);

    String expectedUrl = 'arnoldgalovics.com'.toUpperCase();

    expect(result, expectedUrl);
  });
}
