import Foundation
import React

@objc(AwesomeSdkModule)
class AwesomeSdkModule: RCTEventEmitter {
  
  private var hasListeners = false

  // MARK: - RCTEventEmitter overrides

  override static func requiresMainQueueSetup() -> Bool {
    // If your SDK must run on main thread, return true
    return true
  }

  override func supportedEvents() -> [String]! {
    return ["onReady", "onError"]
  }

  override func startObserving() {
    hasListeners = true
  }

  override func stopObserving() {
    hasListeners = false
  }

  // MARK: - Exported Methods

  @objc(initialize:resolver:rejecter:)
  func initialize(apiKey: String,
                  resolver: @escaping RCTPromiseResolveBlock,
                  rejecter: @escaping RCTPromiseRejectBlock) {
    // Replace this with actual SDK initialization
    print("AwesomeSdkModule.initialize called with apiKey: \(apiKey)")

    if hasListeners {
      sendEvent(withName: "onReady", body: ["message": "SDK initialized successfully"])
    }

    resolver("SDK initialized with key: \(apiKey)")
  }

  @objc(present:rejecter:)
  func present(resolver: @escaping RCTPromiseResolveBlock,
               rejecter: @escaping RCTPromiseRejectBlock) {
    // Replace this with actual SDK present logic
    print("AwesomeSdkModule.present called")

    if hasListeners {
      sendEvent(withName: "onError", body: ["code": 500, "message": "Simulated error presenting SDK UI"])
    }

    resolver("SDK UI presented (iOS)")
  }
}
