
# react-native-visenze-bridge

## Getting started

`$ npm install react-native-visenze-bridge --save`

### Mostly automatic installation

`$ react-native link react-native-visenze-bridge`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-visenze-bridge` and add `RNVisenzeBridge.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNVisenzeBridge.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.rbzlib.RNVisenzeBridgePackage;` to the imports at the top of the file
  - Add `new RNVisenzeBridgePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-visenze-bridge'
  	project(':react-native-visenze-bridge').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-visenze-bridge/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-visenze-bridge')
  	```


## Usage
```javascript
import RNVisenzeBridge from 'react-native-visenze-bridge';

// TODO: What to do with the module?
RNVisenzeBridge;
```
  