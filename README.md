
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
import VisenzeApi from 'react-native-visenze-bridge';
```

### Start/init The ViSearch SDK
Before we use the SDK, We need to start/init the visearch sdk. You can get your `APP_KEY` from ViSenze dashboard.
```javascript
VisenzeApi.start("APP_KEY")
```

### Search Similar Images
**1. Search similar image based on its ID:**
```javascript
VisenzeApi.searchById("INSERT_ID_HERE", (result) => {
    //get the metadata result here, which is in array format
});
```

**2. Search similar image based by URL:**
```javascript
VisenzeApi.searchByUrl("INSERT_URL_HERE", (result) => {
    //get the metadata result here, which is in array format
});
```

**3. Search similar image based by local Path:**
```javascript
VisenzeApi.searchByPath("INSERT_PATH_HERE", (result) => {
    //get the metadata result here, which is in array format
});
```

**4. Search similar image using color:**
```javascript
VisenzeApi.searchByColor("INSERT_HEX_COLOR_STRING HERE", (result) => {
    //get the metadata result here, which is in array format
});
```
Example:
```javascript
VisenzeApi.searchByColor("000000", (result) => {
    //get the metadata result here, which is in array format
});
```

**5. Limit Search to a certain object in the image:**
```javascript
// This will limit the search to a certain object which is 'bag'
VisenzeApi.searchByUrl("https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/03/01/11/spring-handbags-lifestyle.jpg", (result) => {
    //get the metadata result here, which is in array format
}, "bag"); // Specify the limit here
```
Currently support these item : 
- `top`
- `dress` 
- `bottom`
- `shoe`
- `bag`
- `watch` 
- and `indian ethnic wear`

**NOTE**: If you didn't specify what to limit, then it will use `all` as default.


## Tracking
Track Event of clicked search result from the SDK.
```javascript
VisenzeApi.trackSearchResultClickEvent("IMAGE_NAME", "REQUEST_ID");
```