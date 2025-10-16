package dev.fluttercommunity.age_signals_flutter.age_signals_flutter

import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.play.agesignals.AgeSignalsManagerFactory
import com.google.android.play.agesignals.AgeSignalsRequest
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

class AgeSignalsFlutterPlugin: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private val  TAG = "AgeSignalsFlutterPlugin"

  override fun onAttachedToEngine(@NonNull binding: FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "age_signals_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    if (call.method == "getUserStatus") {
      checkAgeSignals(result)
    } else {
      result.notImplemented()
    }
  }

  private fun checkAgeSignals(result: MethodChannel.Result) {
    val ctx = activity ?: return result.error("NO_ACTIVITY", "Activity not attached", null)
    val manager = AgeSignalsManagerFactory.create(ctx.applicationContext)
    val request = AgeSignalsRequest.builder().build()

    manager.checkAgeSignals(request)
      .addOnSuccessListener { res ->
        val data: MutableMap<String, Any?> = HashMap()
        data["userStatus"] = res.userStatus().toString()
        data["ageLower"] = res.ageLower()
        data["ageUpper"] = res.ageUpper()
        data["installId"] = res.installId()
        data["mostRecentApprovalDate"] = res.mostRecentApprovalDate()
        Log.d(TAG, "AgeSignals Result: $data")
        result.success(data)
      }
      .addOnFailureListener { e ->
        Log.e(TAG, "Failed to fetch Age Signals", e)
        result.error("AGE_SIGNALS_FAILED", e.message, null)
      }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() { activity = null }
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) { activity = binding.activity }
  override fun onDetachedFromActivityForConfigChanges() { activity = null }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
