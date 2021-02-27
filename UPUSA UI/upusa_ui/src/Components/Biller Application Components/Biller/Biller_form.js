import React, {Component} from 'react'
import {Link} from "react-router-dom";
import BillerService from "../../../services/BillerService";

export default class Biller_form extends Component {

	constructor(props) {
		super(props);
	}

	addBill = () => {
		BillerService.getInstance().generateBill(
			document.getElementById("user-name-login-page").value,
			document.getElementById("user-name-login-page").value,
			document.getElementById("contact-login-page").value
		).then(response => console.log("response from biller: ", response));
	}

	render() {
		return(
			<div>
				<nav className={"navbar navbar-expand-sm navbar-dark bg-light"}>
					<div className="container-fluid">
						<div className="row input-group">
							<Link to={"/"}>
								<div className="navbar-brand text-dark">
									BILLER
								</div>
								<div className="col-8 col-md-8 input-group">
								</div>
							</Link>
						</div>
					</div>
				</nav>
				<div className={'container-fluid'}>
					<div className={"row"}>
						<div className={"col-sm-6 mt-3 mx-auto"}>
							<div className={"form-group"}>
								<label htmlFor={"user-name-login-page"}>Account Number </label>
								<input type={"text"}
								       className={"form-control"}
								       id={"user-name-login-page"}
								       name={"username"}
								       aria-placeholder={"Enter user account number"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"password-login-page"}> Bill Amount </label>
								<input type={"text"}
								       id={"password-login-page"}
								       className={"form-control"}
								       name={"password"}
								       aria-placeholder={"Enter bill amount"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"contact-login-page"}> Service Name </label>
								<input type={"text"}
								       id={"contact-login-page"}
								       className={"form-control"}
								       name={"contact"}
								       aria-placeholder={"Enter service name"}/>
							</div>
							<div className={"row"}>
								<div className={"col-sm-6"}>
									<button onClick={this.addBill}
									        className={"btn btn-success"}>Generate
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		)
	}
}
