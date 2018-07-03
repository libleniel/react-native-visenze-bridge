
import { NativeModules, NativeEventEmitter } from 'react-native';

const { RNVisenzeBridge } = NativeModules;

let resultListener = {}

const ReactNativeVisenze = {
    /**
     * Initiate Visearch with app key
     * Also set the listener for callback
     * @param {string} appkey
     */
    start: function start(appkey) {
        RNVisenzeBridge.start(appkey);
    },
    /**
     * Search using id
     * @param {string} id
     * @param {callback} callback - callback function to be invoked
     */
    searchById: function searchById(id, callback) {
        resultListener = callback;
        new NativeEventEmitter(RNVisenzeBridge).addListener('VisenzeResultEvent', (result) => {
            resultListener(result);
        });
        RNVisenzeBridge.searchById(id);
    },
    /**
     * Search using URL of the image
     * Example : https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/03/01/11/spring-handbags-lifestyle.jpg
     * @param {string} url - URL of the image
     * @param {callback} callback - callback function to be invoked
     * @param {string} limitDetection - limit the image detection = "all", "top", "dress", "bottom", "shoe", "bag", "watch" and "indian ethnic wear". default = "all"
     */
    searchByUrl: function searchByUrl(url, callback, limitDetection = "all") {
        resultListener = callback;
        new NativeEventEmitter(RNVisenzeBridge).addListener('VisenzeResultEvent', (result) => {
            resultListener(result);
        });
        RNVisenzeBridge.searchByUrl(url, limitDetection);
    },
    /**
     * Search using URI of the image
     * @param {string} Uri - Uri of the image
     * @param {callback} callback - callback function to be invoked
     * @param {string} limitDetection - limit the image detection = "all", "top", "dress", "bottom", "shoe", "bag", "watch" and "indian ethnic wear". default = "all"
     */
    searchByUri: function searchByUri(uri, callback, limitDetection = "all", page, filter) {
        resultListener = callback;
        new NativeEventEmitter(RNVisenzeBridge).addListener('VisenzeResultEvent', (result) => {
            resultListener(result);
        });
        RNVisenzeBridge.searchByUri(uri, limitDetection, page, filter);
    },
    /**
     * Search using local path of the image 
     * @param {string} path - local path of the image
     * @param {callback} callback - callback function to be invoked
     * @param {string} limitDetection - limit the image detection = "all", "top", "dress", "bottom", "shoe", "bag", "watch" and "indian ethnic wear". default = "all"
     */
    searchByPath: function searchByPath(path, callback, limitDetection = "all") {
        resultListener = callback;
        new NativeEventEmitter(RNVisenzeBridge).addListener('VisenzeResultEvent', (result) => {
            resultListener(result);
        });
        RNVisenzeBridge.searchByPath(path, limitDetection);
    },
    /**
     * Search using Hex color
     * @param {string} hexString - Hex Color "111111" for white, "000000" for black
     * @param {callback} callback - callback function to be invoked
     */
    searchByColor: function searchByColor(hexString, callback) {
        resultListener = callback;
        new NativeEventEmitter(RNVisenzeBridge).addListener('VisenzeResultEvent', (result) => {
            resultListener(result);
        });
        RNVisenzeBridge.searchByColor(hexString);
    },
    /**
     * Track Click Event
     * @param {string} imageName
     * @param {string} reqID
     */
    trackSearchResultClickEvent: function trackSearchResultClickEvent(imageName, reqID) {
        RNVisenzeBridge.trackSearchResultClickEvent(imageName, reqID);
    },
};

export default ReactNativeVisenze;
