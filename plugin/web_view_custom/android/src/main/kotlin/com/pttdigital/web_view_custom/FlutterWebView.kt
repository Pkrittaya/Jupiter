package com.pttdigital.web_view_custom

import android.content.Context
import android.graphics.Bitmap
import android.os.Build
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.FrameLayout
import android.widget.LinearLayout
import androidx.annotation.RequiresApi
import com.google.android.material.progressindicator.CircularProgressIndicator
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView


@RequiresApi(Build.VERSION_CODES.LOLLIPOP)
class FlutterWebView internal constructor(
    context: Context,
    messenger: BinaryMessenger,
    id: Int
) :
    PlatformView, MethodCallHandler {
   
    private val webView: WebView
    private val methodChannel: MethodChannel
    private val pd: CircularProgressIndicator

    override fun getView(): View {
        return webView
    }

    init {
        // Init WebView
        webView = WebView(context)

        pd = CircularProgressIndicator(context);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            pd.setIndicatorColor(context.getColor(android.R.color.holo_blue_dark));
        }
        pd.indicatorSize = 100
        pd.isIndeterminate = true


        println("CircularProgressIndicator")
        // Set client so that you can interact within WebView

        var client = object : WebViewClient() {
            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                println("onPageStarted")
                pd.show()
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)
                println("onPageFinished")
                pd.hide()
            }
        }

        webView.webViewClient = client
        webView.settings.domStorageEnabled = true
        webView.settings.javaScriptEnabled = true

        var layout = LinearLayout(context)
        var params = LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.FILL_PARENT);
        params.gravity = Gravity.CENTER_VERTICAL or Gravity.CENTER_HORIZONTAL
        webView.layoutParams = params
        pd.layoutParams = params

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            webView.foregroundGravity = Gravity.CENTER_VERTICAL or Gravity.CENTER_HORIZONTAL
            pd.foregroundGravity = Gravity.CENTER_VERTICAL or Gravity.CENTER_HORIZONTAL
        }

        layout.setHorizontalGravity(Gravity.CENTER_VERTICAL)
        layout.setVerticalGravity(Gravity.CENTER_VERTICAL)
        layout.gravity =  Gravity.CENTER_VERTICAL or Gravity.CENTER_HORIZONTAL

        layout.addView(pd, params)
        webView.addView(layout, params)

        methodChannel = MethodChannel(messenger, "web_view_custom/flutter_web_view_$id")
        // Init methodCall Listener
        methodChannel.setMethodCallHandler(this)
    }
    
    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "setUrl" -> setText(methodCall, result)
            "setNewUrl" -> setNewUrl(methodCall, result)
            "getToken" -> getToken(methodCall, result)
            else -> result.notImplemented()
        }
    }
    
    // set and load new Url
    private fun setText(methodCall: MethodCall, result: MethodChannel.Result ) {
        val url = methodCall.arguments as String
        pd.show()
        webView.loadUrl(url)
        result.success(null)
    }
    private fun setNewUrl(methodCall: MethodCall, result: MethodChannel.Result ) {
        val url = methodCall.arguments as String
        pd.show()
        webView.loadUrl(url)
        result.success(null)
    }
    private fun getToken(methodCall: MethodCall, result: MethodChannel.Result ) {
        webView.addJavascriptInterface(AppInterFace(result),"KPayment")
      

    }

    // Destroy WebView when PlatformView is destroyed
    override fun dispose() {
        webView.destroy()
    }
    class AppInterFace internal constructor(
        var callback: MethodChannel.Result
    ) {

        init {

        }
        @JavascriptInterface ///token step แรก
        fun tokenReceiver(jsonString: String?) {
            println("json $jsonString")
            callback.success(jsonString)
        }
        @JavascriptInterface ///token step แรก
        fun chargeReceiver(jsonString: String?) {
            println("json $jsonString")
            callback.success(jsonString)
        }
    }

}