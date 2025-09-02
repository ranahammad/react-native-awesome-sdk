const { getDefaultConfig } = require('@react-native/metro-config');

// Metro CLI sometimes expects a promise, sometimes an object.
// This shim ensures compatibility either way.
async function loadConfig() {
  return await getDefaultConfig(__dirname);
}

// Export both: Promise (newer style) and plain object (older style)
module.exports = loadConfig();
module.exports.loadConfig = loadConfig; // For Metro CLI compatibility

// This file simply re-exports the shim to ensure Metro uses the correct configuration.
// If you encounter issues with Metro bundler, consider the following steps:

// 1. Ensure you have the correct version of Metro and its dependencies.
//    You can add resolutions in your package.json to enforce specific versions:
//    "resolutions": {
//      "metro": "0.81.0",
//      "metro-config": "0.81.0",
//      "metro-runtime": "0.81.0",
//      "metro-resolver": "0.81.0"
//    }

// 2. Clear the Metro cache and reinstall node modules:
//    yarn cache clean --all
//    rm -rf node_modules example/node_modules .yarn/install-state.gz yarn.lock
//    yarn install

// 3. Start Metro with the reset cache option:
//    From the root directory:
//    yarn workspace react-native-awesome-sdk-example start --reset-cache
//    Or from the example directory:
//    cd example && yarn start --reset-cache

// These steps should help resolve common issues with Metro bundler in a React Native project.
