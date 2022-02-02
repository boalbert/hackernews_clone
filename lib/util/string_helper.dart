import 'package:timeago/timeago.dart' as timeago;

class StringHelper {
  String encodeComments(String text) {
    //
    // String lineBreak = text.replaceAll('<p>', '\n\n');
    // String apostrophe = lineBreak.replaceAll(, replace)
    //

    return text.replaceAll('<p>', '\n\n').replaceAll('<i>', '').replaceAll('</i>', '');
  }

  String formattedDateTime(int dateTime, {type}) {
    final DateTime postTime = DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);

    return timeago.format(postTime);
  }

  String parseBaseUrl(String url) {
    List<String> removeHttps;

    if (url.contains("https://")) {
      removeHttps = url.split("https://");
    } else {
      removeHttps = url.split("http://");
    }

    List<String> removeTrailingSlash = removeHttps[1].split("/");

    if (removeTrailingSlash[0].contains("www")) {
      var removedWWW = removeTrailingSlash[0].split("www");
      return removedWWW[0].trim().toUpperCase();
    }
    return removeTrailingSlash[0].trim().toUpperCase();
  }

  String parseHost(String url) {
    final Uri uri = Uri.parse(url);
    if (uri.toString().contains("www.")) {
      return uri.host.replaceAll("www.", "").toUpperCase();
    }
    return uri.host.toUpperCase();
  }
}
