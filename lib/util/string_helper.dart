import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class StringHelper {
  String encodeComments(String text) {
    //Apparently from this CNN report there is a suggestion (@1:57) that DJI is feeding Russians the location of Ukranian drones used to call in artillery.<p>Is there any scheme (alternate firmware, open source app, firewall settings) that can prevent DJI from receiving this location data?<p>https:&#x2F;&#x2F;youtu.be&#x2F;b166ecyNBCw?t=117

    return text
        .replaceAll('<p>', '\n\n')
        .replaceAll('<i>', '')
        .replaceAll('</i>', '')
        .replaceAll('&#x2F;', '/')
        .replaceAll('&#x27;', "'")
        .replaceAll("&quot;", "'")
        .replaceAll('<a href="', " ")
        .replaceAll(">", "")
        .replaceAll("</a", "");
  }

  RichText htmlComment(String text, BuildContext context) {
    List<String> parsedComment = [];
    if (text.contains("<i>")) {
      print('inside');
      parsedComment.addAll(text.split('<i>'));
    }

    print(parsedComment);

    return RichText(
      text: TextSpan(
        text: 'Hello ',
        style: DefaultTextStyle.of(context).style,
        children: const [
          TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' world!'),
        ],
      ),
    );
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
