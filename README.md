# Webview Tester

Webview Tester is simple Swift application used for testing websites within the several different web views available for iOS apps.  There are currently **Three** major ways you can display web content in your app, and each one seems to behavior a bit different.  As a web developer, you may find this APP useful for easily testing your web creations.  In addition to selecting the webview you would like to test with, you can also toggle cookies on/off.   
**NOTE: Toggling cookies will clear all cookies!**

  - UIWebview
    - This is the easiest web view to set up since it is easily dragged from the toolbox in XCode.  It is also the slowest and least secure.  
  - WKWebView
    - A bit more difficult to set up, but the increased performance and security will be worth the effort.
  - Safari Webview
    - This is the newest of them all.  Since this is a wrapper around Safari, it is the fastest and will continue to be updated as Safari is updated.  The only issue with this webview is that it comes with a toolbar that allows users to pop-out of your app.  Also, it is worth noting that All settings, cookies, history, and preferences are shared with Safari.  

Feel free to use this as you wish.  Contributions are welcome!  