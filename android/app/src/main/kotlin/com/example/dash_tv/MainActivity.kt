package com.example.dash_tv

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.net.Uri

class MainActivity : FlutterActivity() {
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleDeepLink(intent)
    }

    override fun onResume() {
        super.onResume()
        handleDeepLink(intent)
    }

    private fun handleDeepLink(intent: Intent?) {
        val data: Uri? = intent?.data
        if (data != null) {
            // Example: dashtv://movie/1234
            val pathId = data.lastPathSegment
            if (pathId != null) {
                flutterEngine?.navigationChannel?.pushRoute("/detail?id=$pathId")
            }
        }
    }
}
