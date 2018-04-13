
import { NativeModules, NativeEventEmitter } from 'react-native';

const { RNVisenzeBridge } = NativeModules;

let resultListener = {}

const ReactNativeVisenze = {
        /**
         * Initiate Visearch with app key
         * @param {string} appkey
         */
        start: function start(appkey) {
            RNVisenzeBridge.start(appkey);
        },
        /**
         * Initiate Visearch with app key
         * @param {string} appkey
         */
        searchById: function searchById(id, callback) {
            resultListener = callback;
            new NativeEventEmitter(RNVisenzeBridge).addListener('VisenzeResultEvent', (result) => {
                console.log("VisenzeResultEvent", result)
                resultListener(result);
                // campaignHandlers[target](data);
            });
            RNVisenzeBridge.searchById(id);
        },
};

// const calendarManagerEmitter = new NativeEventEmitter(CalendarManager);

// const subscription = calendarManagerEmitter.addListener(
//   'EventReminder',
//   (reminder) => console.log(reminder.name)
// );

export default ReactNativeVisenze;
