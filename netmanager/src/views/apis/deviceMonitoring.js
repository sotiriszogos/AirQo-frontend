import axios from "axios";
import constants from "../../config/constants";

export const onlineOfflineMaintenanceStatusApi = async () => {
  return await axios
    .get(constants.GET_ONLINE_OFFLINE_MAINTENANCE_STATUS)
    .then((response) => response.data);
};

export const getDeviceUptimeApi = async (params) => {
  return await axios
    .get(constants.GET_DEVICE_UPTIME, { params })
    .then((response) => response.data);
};

export const getDeviceBatteryVoltageApi = async (params) => {
  return await axios
    .get(constants.GET_DEVICE_BATTERY_VOLTAGE, { params })
    .then((response) => response.data);
};

export const getDeviceSensorCorrelationApi = async (params) => {
  return await axios
    .get(constants.GET_DEVICE_SENSOR_CORRELATION, { params })
    .then((response) => response.data);
};

export const getDevicesStatusApi = async () => {
  return await axios
    .get(constants.ALL_DEVICES_STATUS)
    .then((response) => response.data);
};

export const getNetworkUptimeApi = async (params) => {
  return await axios
    .get(constants.GET_NETWORK_UPTIME, { params })
    .then((response) => response.data);
};

export const getDevicesUptimeApi = async (params) => {
  return await axios
    .get(constants.ALL_DEVICES_UPTIME, params)
    .then((response) => response.data);
};
