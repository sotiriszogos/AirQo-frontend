/* eslint-disable */
import React, { Component } from "react";
import "./App.css";
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Redirect,
} from "react-router-dom";

import jwt_decode from "jwt-decode";
import setAuthToken from "./utils/setAuthToken";
import { setCurrentUser, logoutUser } from "./redux/Join/actions";

import { Provider } from "react-redux";
import store from "./store";
import { ThemeProvider } from "@material-ui/styles";
import theme from "./assets/theme";

import Navbar from "./views/components/Navbars/Navbar";
import Landing from "./views/layouts/Landing";
import Admin from "./views/layouts/Admin";
import {
  Main as MainLayout,
  Maps as MapLayout,
  Minimal as MinimalLayout,
} from "views/layouts/";
// import Profile from "./views/components/Inputs/UserProfile";
// import Settings from "./views/components/Inputs/Settings";
import PrivateRoute from "./views/components/PrivateRoute/PrivateRoute";
import Dashboard from "./views/components/Dashboard/Dashboard";
import Map from "./views/components/Map";
import Devices from "./views/components/DataDisplay/Devices";
import DeviceView from "./views/components/DataDisplay/DeviceView";

import Manager from "./views/components/DataDisplay/DeviceManagement";
import AnalyticsDashboard from "./views/pages/Dashboard";
import Incentives from "./views/components/DataDisplay/Incentives";
import {
  LocationList,
  LocationRegister,
  LocationView,
  LocationEdit,
} from "./views/components/LocationList";

import {
  SignUp as SignUpView,
  Login as LoginView,
  Register as RegisterView,
} from "./views/pages/SignUp";
import { Settings as SettingsView } from "./views/pages/Settings";
import { Account as AccountView } from "./views/pages/Account";
import { Download as DownloadView } from "./views/pages/Download";
import { ReportTemplate as ReportTemplateView } from "./views/pages/ReportTemplate";
import { Reports as ReportView } from "./views/pages/Reports";
import { NotFound as NotFoundView } from "./views/pages/NotFound";
import { LocationList as LocationListView } from "./views/pages/LocationList";

import { IndexRoute } from "react-router";

import { RouteWithLayout } from "./views/components/RouteWithLayout";

import {
  connectedUserList as ConnectedUserList,
  connectedCandidateList as ConnectedCandidateList,
  connectedSetDefaults as ConnectedSetDefaults,
  connectedSignUp as ConnectedSignUp,
  connectedSignIn as ConnectedSignIn,
  connectedLogin as ConnectedLogin,
  connectedRegister as ConnectedRegister,
  connectedDashboard as DashboardView,
} from "views/hocs/Users";

import ForgotPassword from "./views/pages/ForgotPassword";
import ResetPassword from "./views/pages/ResetPassword";
import Login from "./views/pages/SignUp/Login";
import { loadUserDefaultGraphData } from "./redux/Dashboard/operations";

// Check for token to keep user logged in
if (localStorage.jwtToken) {
  // Set auth token header auth
  const token = localStorage.jwtToken;
  setAuthToken(token);
  // Decode token and get user info and exp
  const decoded = jwt_decode(token);
  // Set user and isAuthenticated
  store.dispatch(setCurrentUser(decoded));
  // Check for expired token
  const currentTime = Date.now() / 1000; // to get in milliseconds
  if (decoded.exp < currentTime) {
    // Logout user
    store.dispatch(logoutUser());
    // Redirect to the landing page
    window.location.href = "./";
  }
  store.dispatch(loadUserDefaultGraphData())
}

class App extends Component {
  render() {
    return (
      <Provider store={store}>
        <ThemeProvider theme={theme}>
          <Router>
            <div className="App">
              <Route exact path="/" component={Landing} />
              <Route exact path="/request-access" component={ConnectedRegister} />
              {/*<Route exact path="/sign-up" component={ConnectedSignUp} />*/}
              <Route exact path="/login" component={ConnectedLogin} />
              <Route exact path="/forgot" component={ForgotPassword} />
              <Route exact path="/reset/:token" component={ResetPassword} />
              <Switch>
                <PrivateRoute
                  exact
                  path="/dashboard"
                  component={AnalyticsDashboard}
                  layout={MainLayout}
                />

                {/*<RouteWithLayout*/}
                {/*  component={ConnectedSignIn}*/}
                {/*  exact*/}
                {/*  layout={MinimalLayout}*/}
                {/*  path="/sign-in"*/}
                {/*/>*/}
                <PrivateRoute
                  exact
                  path="/overview"
                  component={Dashboard}
                  layout={MainLayout}
                />

                <PrivateRoute
                  exact
                  path="/download"
                  component={DownloadView}
                  layout={MainLayout}
                />

                <PrivateRoute
                  exact
                  path="/locate"
                  component={Map}
                  layout={MainLayout}
                />
                <PrivateRoute
                  extact
                  path="/registry"
                  component={Devices}
                  layout={MainLayout}
                />
                <PrivateRoute
                  exact
                  path="/device/:channelId"
                  component={DeviceView}
                  layout={MainLayout}
                />
                <PrivateRoute
                  extact
                  path="/location"
                  component={LocationList}
                  layout={MainLayout}
                />

                <PrivateRoute
                  component={NotFoundView}
                  exact
                  layout={MinimalLayout}
                  path="/not-found"
                />
                <PrivateRoute
                  component={ConnectedCandidateList}
                  exact
                  layout={MainLayout}
                  path="/candidates"
                />

                <PrivateRoute
                  extact
                  path="/register_location"
                  component={LocationRegister}
                  layout={MainLayout}
                />
                <PrivateRoute
                  exact
                  path="/edit/:loc_ref"
                  component={LocationEdit}
                  layout={MainLayout}
                />
                <PrivateRoute
                  exact
                  path="/locations/:loc_ref"
                  component={LocationView}
                  layout={MainLayout}
                />
                <PrivateRoute
                  exact
                  path="/admin/users"
                  component={ConnectedUserList}
                  layout={MainLayout}
                />

                <PrivateRoute
                  component={ReportView}
                  exact
                  layout={MainLayout}
                  path="/reports"
                />
                <PrivateRoute
                  component={AccountView}
                  exact
                  layout={MainLayout}
                  path="/account"
                />
                <PrivateRoute
                  component={SettingsView}
                  exact
                  layout={MainLayout}
                  path="/settings"
                />
                <PrivateRoute
                  exact
                  path="/manager"
                  component={Manager}
                  layout={MainLayout}
                />
              </Switch>
            </div>
          </Router>
        </ThemeProvider>
      </Provider>
    );
  }
}
export default App;