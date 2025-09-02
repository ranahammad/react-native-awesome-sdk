package com.awesomesdk

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.facebook.react.modules.core.DeviceEventManagerModule

class AwesomeSdkModule(private val reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String = "AwesomeSdkModule"

    private fun sendEvent(eventName: String, params: Map<String, Any?>) {
        reactContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
            .emit(eventName, params)
    }

    @ReactMethod
    fun initialize(apiKey: String, promise: Promise) {
        // Pretend SDK init success
        sendEvent("onReady", mapOf("message" to "SDK initialized on Android"))
        promise.resolve("SDK initialized with key: $apiKey")
    }

    @ReactMethod
    fun present(promise: Promise) {
        // Pretend SDK error
        sendEvent("onError", mapOf("code" to 500, "message" to "SDK failed to present on Android"))
        promise.resolve("SDK UI presented (Android)")
    }
}
