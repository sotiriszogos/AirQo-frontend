import {
  LOAD_ALL_DEVICES_SUCCESS,
  RESET_DEVICE_SUCCESS,
  UPDATE_SINGLE_DEVICE_SUCCESS,
} from "../actions";

const initialState = {};

export default function (state = initialState, action) {
  switch (action.type) {
    case RESET_DEVICE_SUCCESS:
      return initialState;
    case LOAD_ALL_DEVICES_SUCCESS:
      return action.payload;
    case UPDATE_SINGLE_DEVICE_SUCCESS:
      return {
        ...state,
        [action.payload.deviceId]: {
          ...(state[action.payload.deviceId] || {}),
          ...action.payload.data,
        },
      };
    default:
      return state;
  }
}
