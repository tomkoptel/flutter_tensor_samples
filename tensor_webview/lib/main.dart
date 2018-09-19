import 'package:flutter/material.dart';
import 'package:tensor_webview/launchrl_page.dart';
import 'package:tensor_webview/home_page.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/**
 * Exploring Webviews and the Url Launcher Plugin in Dart's Flutter Framework - https://youtu.be/sK-8k1Dq1xM
 */

const URL = "https://steemit.com";

void main() => runApp(MaterialApp(theme: ThemeData.dark(), routes: {
      "/": (_) => HomePage(
            defaultUrl: URL,
          ),
      "/url_launcher": (_) => LaunchUrlPage(
            defaultUrl: URL,
          ),
      "/webview": (_) => WebviewScaffold(
            appBar: AppBar(
              title: Text("WebView"),
            ),
            url: URL,
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          )
    }));
