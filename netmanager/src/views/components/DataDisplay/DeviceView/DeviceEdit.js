import React, { useState, useEffect } from "react";
import { useDispatch } from "react-redux";
import TextField from "@material-ui/core/TextField";
import Paper from "@material-ui/core/Paper";
import { Button, Grid } from "@material-ui/core";
import LabelledSelect from "../../CustomSelects/LabelledSelect";
import { isEqual } from "underscore";
import { updateMainAlert } from "redux/MainAlert/operations";
import { updateDeviceDetails } from "views/apis/deviceRegistry";
import { loadDevicesData } from "redux/DeviceRegistry/operations";
import { useSiteOptionsData } from "redux/SiteRegistry/selectors";
import DeviceDeployStatus from "./DeviceDeployStatus";
import { capitalize } from "utils/string";
import { dropEmpty } from "utils/objectManipulators";
import { filterSite } from "utils/sites";

const gridItemStyle = {
  padding: "5px",
};

const EditDeviceForm = ({ deviceData, siteOptions }) => {
  const dispatch = useDispatch();
  const [editData, setEditData] = useState({
    locationName: "",
    siteName: "",
    ...deviceData,
  });

  const [site, setSite] = useState(
    filterSite(siteOptions, deviceData.site && deviceData.site._id)
  );
  console.log("site", site);
  const [editLoading, setEditLoading] = useState(false);

  const handleTextFieldChange = (event) => {
    setEditData({
      ...editData,
      [event.target.id]: event.target.value,
    });
  };

  const handleSelectFieldChange = (id) => (event) => {
    setEditData({
      ...editData,
      [id]: event.target.value,
    });
  };

  const handleEditSubmit = async () => {
    setEditLoading(true);

    if (site && site.value) editData.site_id = site.value;

    await updateDeviceDetails(deviceData._id, dropEmpty(editData))
      .then((responseData) => {
        dispatch(loadDevicesData());
        dispatch(
          updateMainAlert({
            message: responseData.message,
            show: true,
            severity: "success",
          })
        );
      })
      .catch((err) => {
        dispatch(
          updateMainAlert({
            message: err.response.data.message,
            show: true,
            severity: "error",
          })
        );
      });
    setEditLoading(false);
  };

  const weightedBool = (primary, secondary) => {
    if (primary) {
      return primary;
    }
    return secondary;
  };

  return (
    <div>
      <Paper
        style={{
          margin: "0 auto",
          minHeight: "400px",
          padding: "20px 20px",
          maxWidth: "1500px",
        }}
      >
        <Grid container spacing={1}>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              id="long_name"
              label="Name"
              variant="outlined"
              value={editData.long_name}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="owner"
              label="Owner"
              value={editData.owner}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="description"
              label="Description"
              value={editData.description}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="device_manufacturer"
              label="Manufacturer"
              value={editData.device_manufacturer}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="locationName"
              label="Map Address"
              value={editData.locationName}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="siteName"
              label="Site Name"
              value={editData.siteName}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="product_name"
              label="Product Name"
              value={editData.product_name}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="latitude"
              label="Latitude"
              value={editData.latitude}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="longitude"
              label="Longitude"
              value={editData.longitude}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="phoneNumber"
              label="Phone Number"
              value={editData.phoneNumber}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              select
              fullWidth
              label="Data Access"
              style={{ margin: "10px 0" }}
              value={editData.visibility}
              onChange={handleSelectFieldChange("visibility")}
              SelectProps={{
                native: true,
                style: { width: "100%", height: "50px" },
              }}
              variant="outlined"
            >
              <option value={false}>Private</option>
              <option value={true}>Public</option>
            </TextField>
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              select
              fullWidth
              label="Internet Service Provider"
              style={{ margin: "10px 0" }}
              value={editData.ISP}
              onChange={handleSelectFieldChange("ISP")}
              SelectProps={{
                native: true,
                style: { width: "100%", height: "50px" },
              }}
              variant="outlined"
            >
              <option value="" />
              <option value="MTN">MTN</option>
              <option value="Airtel">Airtel</option>
              <option value="Africell">Africell</option>
            </TextField>
          </Grid>
          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <LabelledSelect
              label={"Site"}
              defaultValue={site}
              onChange={setSite}
              options={siteOptions}
            />
          </Grid>

          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              select
              fullWidth
              label="Power Type"
              style={{ margin: "10px 0" }}
              value={capitalize(editData.powerType)}
              onChange={handleSelectFieldChange("powerType")}
              SelectProps={{
                native: true,
                style: { width: "100%", height: "50px" },
              }}
              variant="outlined"
            >
              <option aria-label="None" value="" />
              <option value="Mains">Mains</option>
              <option value="Solar">Solar</option>
              <option value="Battery">Battery</option>
            </TextField>
          </Grid>

          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="mountType"
              label="Mount Type"
              value={editData.mountType}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>

          <Grid items xs={12} sm={4} style={gridItemStyle}>
            <TextField
              autoFocus
              margin="dense"
              variant="outlined"
              id="height"
              label="height"
              value={editData.height}
              onChange={handleTextFieldChange}
              fullWidth
            />
          </Grid>

          <Grid
            container
            alignItems="flex-end"
            alignContent="flex-end"
            justify="flex-end"
            xs={12}
            style={{ margin: "10px 0" }}
          >
            <Button variant="contained" onClick={() => setEditData(deviceData)}>
              Cancel
            </Button>

            <Button
              variant="contained"
              color="primary"
              disabled={weightedBool(
                editLoading,
                isEqual(deviceData, editData)
              )}
              onClick={handleEditSubmit}
              style={{ marginLeft: "10px" }}
            >
              Save Changes
            </Button>
          </Grid>
        </Grid>
      </Paper>
    </div>
  );
};

export default function DeviceEdit({ deviceData }) {
  const siteOptions = useSiteOptionsData();
  return (
    <>
      <EditDeviceForm deviceData={deviceData} siteOptions={siteOptions} />
      <DeviceDeployStatus deviceData={deviceData} />
    </>
  );
}
