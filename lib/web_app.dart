import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const WebApp());

class WebApp extends StatelessWidget
{
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(title: const Text(""), toolbarHeight: 5,),
        
        body: const Column(
          children: [
            Expanded(
              child: Website(),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Trigger an action in the WebView
            //     // Website.controller?.runJavascript("document.getElementsByClassName('site')[0].style.display='block';");
            //     Website.controller?.loadUrl('https://price-base.com/watchlist/');
            //   },
            //   child: const Text('Trigger Action in WebView'),
            // ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Website extends StatelessWidget
{
  const Website({super.key});
  static WebViewController? controller;
  
  @override
  Widget build(BuildContext context) {
    
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://price-base.com',
      onProgress: (int progress) {
        if (progress == 100) {
          String jsCode = """
            document.getElementById('app').style.paddingTop='5px';
            document.getElementsByClassName('top-search')[0].style.marginTop='-130px';
            document.getElementsByClassName('top-search')[0].style.paddingRight='22px';
            document.getElementsByClassName('right-box')[0].style.marginTop='1.5vh';
            document.getElementsByClassName('right-box')[0].style.marginButtom='1.2vh';
            document.querySelector('.logo a:first-child').style.display='none';
            elements = document.querySelectorAll('.top-category-wrapper a').forEach(element => {
              element.style.textDecoration = 'none';
            });
            if(document.getElementsByClassName('top-user')[0] !== undefined){
              document.getElementsByClassName('top-user')[0].style.display='none';
            }
            if(document.getElementsByClassName('top-user-auth')[0] !== undefined){
              document.getElementsByClassName('top-user-auth')[0].style.display='none';
            }
          """;
          controller?.runJavascript(jsCode);
        }
      },
      onPageFinished: (String string) {

        String jsCode = """
          document.getElementById('app').style.paddingTop='5px';
          document.getElementsByClassName('top-search')[0].style.marginTop='-130px';
          document.getElementsByClassName('top-search')[0].style.paddingRight='22px';
          document.getElementsByClassName('right-box')[0].style.marginTop='1.5vh';
          document.getElementsByClassName('right-box')[0].style.marginButtom='1.2vh';
          document.querySelector('.logo a:first-child').style.display='none';
          elements = document.querySelectorAll('.top-category-wrapper a').forEach(element => {
            element.style.textDecoration = 'none';
          });
          if(document.getElementsByClassName('top-user')[0] !== undefined){
            document.getElementsByClassName('top-user')[0].style.display='none';
          }
          if(document.getElementsByClassName('top-user-auth')[0] !== undefined){
            document.getElementsByClassName('top-user-auth')[0].style.display='none';
          }
        """;
        controller?.runJavascript(jsCode);

      },
      onWebViewCreated: (WebViewController webViewController) {
        controller = webViewController;
      },
    );
  }
}