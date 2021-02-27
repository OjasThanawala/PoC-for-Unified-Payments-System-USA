import React from 'react';
import ReactDOM from 'react-dom';
import {BrowserRouter as Router, Route} from 'react-router-dom'
import Login from './Components/UPUSA Application Components/Login/client.login'
import Register from './Components/UPUSA Application Components/Register/client.register'
import './index.css';
import "../node_modules/jquery/dist/jquery"
import "../node_modules/bootstrap/dist/css/bootstrap.css"
import App from './App';
import * as serviceWorker from './serviceWorker';
import Home from "./Components/UPUSA Application Components/Home/client.home";
import PaymentPage from "./Components/UPUSA Application Components/Payment/PaymentPage";
import Biller_form from "./Components/Biller Application Components/Biller/Biller_form";

const routing = (
	<Router>
		<div>
			<Route exact path={"/"} component={Login}/>
			<Route exact path={"/register"} component={Register}/>
			<Route exact path={"/user/:userName/home"} render={(props) => (<Home  currentView={"currentBills"} {...props}/>)}/>
			<Route exact path={"/user/:userName/home/bill-history"} render={(props) => (<Home currentView={"billHistory"}{...props}/>)}/>
			<Route exact path={"/user/:userName/home/current-bills"} render={(props) => (<Home currentView={"currentBills"}{...props}/>)}/>
			<Route exact path={"/user/:userName/home/current-bills/bill-id/:billId/pay"} render={(props) => (<PaymentPage {...props}/>)}/>

			<Route exact path={"/biller/enter-data"} component={Biller_form} />
		</div>
	</Router>
);

ReactDOM.render(routing, document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
