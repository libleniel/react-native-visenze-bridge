package com.rbzlib;

import android.util.Log;
import com.facebook.react.bridge.UiThreadUtil;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import com.visenze.visearch.android.IdSearchParams;
import com.visenze.visearch.android.ResultList;
import com.visenze.visearch.android.ViSearch;

import com.facebook.react.modules.core.RCTNativeAppEventEmitter;

public class RNVisenzeBridgeModule extends ReactContextBaseJavaModule {

    private static final String VISENZE_RESULT_EVENT = "VisenzeResultEvent";
    private final ReactApplicationContext reactContext;
    private ViSearch viSearch;
    private ViSearch.ResultListener visearchListener;
    final static String ModuleName = "RNVisenzeBridge";

    public RNVisenzeBridgeModule(ReactApplicationContext reactContext) {
      super(reactContext);
      this.reactContext = reactContext;
    }

    @Override
    public String getName() {
      return ModuleName;
    }

    @ReactMethod
    public void test() {
        Log.d("RNVisenzeBridge", "RNVisenzeBridge.test is called");
        return;
    }

    @ReactMethod
    public void start(final String appkey) {
        UiThreadUtil.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.d("RNVisenzeBridge", "start is called");
                viSearch = new ViSearch.Builder(appkey).build(reactContext);
                visearchListener = new ViSearch.ResultListener() {
                    @Override
                    public void onSearchResult(ResultList resultList) {
                        RCTNativeAppEventEmitter eventEmitter = getReactApplicationContext().getJSModule(RCTNativeAppEventEmitter.class);
                        eventEmitter.emit(VISENZE_RESULT_EVENT, "HALO MAS " + resultList.getImageList().get(0).getImageName());
                        Log.i(ModuleName, "Search Success");
                        Log.i("search result", resultList.getImageList().get(0).getImageName());
                    }

                    @Override
                    public void onSearchError(String errorMessage) {
                        Log.i(ModuleName, "Search Error");
                    }

                    @Override
                    public void onSearchCanceled() {
                        Log.i(ModuleName, "Search Canceled");
                    }
                };
                viSearch.setListener(visearchListener);
            }
        });
    }

    @ReactMethod
    public void searchById(final String id){
        UiThreadUtil.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                // ViSearch viSearch = getViSearchInstance(reactContext);
                // if (null != screen) {
                    Log.d("RNVisenzeBridge", "searchById is called " + id);
                    // viSearch.setListener(new ViSearch.ResultListener() {
                    //     @Override
                    //     public void onSearchResult(ResultList resultList) {
                    //         Log.i("search result", "suksess");
                    //         Log.i("search result", resultList.getImageList().get(0).getImageName());
                    //     }
            
                    //     @Override
                    //     public void onSearchError(String errorMessage) {
                    //         Log.i("search error", "faul");
                    //     }
            
                    //     @Override
                    //     public void onSearchCanceled() {
                    //         Log.i("search cancel", "fail");
                    //     }
                    // });
                    IdSearchParams idSearchParams = new IdSearchParams(id);
                    viSearch.idSearch(idSearchParams);
                // }
            }
        });
    }

    //Search Results Go Here


}



// import com.facebook.react.bridge.ReactApplicationContext;
// import com.facebook.react.bridge.ReactContextBaseJavaModule;
// import com.facebook.react.bridge.ReactMethod;
// import com.facebook.react.bridge.Callback;

// public class RNVisenzeBridgeModule extends ReactContextBaseJavaModule {

//   private final ReactApplicationContext reactContext;

//   public RNVisenzeBridgeModule(ReactApplicationContext reactContext) {
//     super(reactContext);
//     this.reactContext = reactContext;
//   }

//   @Override
//   public String getName() {
//     return "RNVisenzeBridge";
//   }
// }