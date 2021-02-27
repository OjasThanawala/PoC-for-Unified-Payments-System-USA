import React, {Component} from "react"
import {Link, Redirect} from "react-router-dom";
import UserService from "../../../services/UserService";

export default class Register extends Component {

	constructor(props) {
		super(props);
		this.state = {
			redirectToDashboard: false,
		}
	}

	registerUser = () => {
		let registrationResult = '';
		UserService.getInstance().registerUser(document.getElementById("user-name-login-page").value,
			document.getElementById("user-name-login-page").value,
			document.getElementById("email-login-page").value,
			document.getElementById("contact-login-page").value,
			document.getElementById("fullname-login-page").value,
			document.getElementById("ssn-login-page").value,
			document.getElementById("address1-login-page").value,
			document.getElementById("address2-login-page").value,
			document.getElementById("address-city-login-page").value,
			document.getElementById("address-state-login-page").value,
		)
			.then(response => {
				registrationResult = response["message"];
				if (registrationResult === 1) {
					this.setState({
						redirectToDashboard: true
					}, () => this.render());
				}
			});
	};

	render() {
		if (this.state.redirectToDashboard) {
			return <Redirect to={`/user/${this.state.username}/home`}/>
		}
		return (
			<div>
				<nav className={"navbar navbar-expand-sm navbar-dark bg-light"}>
					<div className="container-fluid">
						<div className="row input-group">
							<Link to={"/"}>
								<div className="navbar-brand text-dark">
									U.P.U.S.A
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
								<label htmlFor={"user-name-login-page"}>User Name </label>
								<input type={"text"}
								       className={"form-control"}
								       id={"user-name-login-page"}
								       name={"username"}
								       aria-placeholder={"Enter username"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"password-login-page"}> Password </label>
								<input type={"password"}
								       id={"password-login-page"}
								       className={"form-control"}
								       name={"password"}
								       aria-placeholder={"Enter password"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"email-login-page"}> Email </label>
								<input type={"email"}
								       id={"email-login-page"}
								       className={"form-control"}
								       name={"email"}
								       aria-placeholder={"Enter Email"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"contact-login-page"}> Contact </label>
								<input type={"text"}
								       id={"contact-login-page"}
								       className={"form-control"}
								       name={"contact"}
								       aria-placeholder={"Enter Contact"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"fullname-login-page"}> Full Name </label>
								<input type={"text"}
								       id={"fullname-login-page"}
								       className={"form-control"}
								       name={"fullName"}
								       aria-placeholder={"Enter Full Name"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"ssn-login-page"}> SSN </label>
								<input type={"text"}
								       id={"ssn-login-page"}
								       className={"form-control"}
								       name={"SSN"}
								       aria-placeholder={"Enter SSN"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"address1-login-page"}> Address part 1 </label>
								<input type={"text"}
								       id={"address1-login-page"}
								       className={"form-control"}
								       name={"address1"}
								       aria-placeholder={"Enter Address"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"address2-login-page"}> Address part 2 </label>
								<input type={"text"}
								       id={"address2-login-page"}
								       className={"form-control"}
								       name={"address2"}
								       aria-placeholder={"Enter Address"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"address-city-login-page"}> City </label>
								<input type={"text"}
								       id={"address-city-login-page"}
								       className={"form-control"}
								       name={"city"}
								       aria-placeholder={"Enter City"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"address-state-login-page"}> State </label>
								<input type={"text"}
								       id={"address-state-login-page"}
								       className={"form-control"}
								       name={"state"}
								       aria-placeholder={"Enter State"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"bank-account-number-login-page"}> Bank Account Number </label>
								<input type={"text"}
								       id={"bank-account-number-login-page"}
								       className={"form-control"}
								/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"bank-name-drop-down"}>Select Bank</label>
								<div className="dropdown" id={"bank-name-drop-down"}>
									<button className="btn btn-secondary dropdown-toggle" type="button"
									        id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true"
									        aria-expanded="false">
										Choose Bank
									</button>
									<div className="dropdown-menu" aria-labelledby="dropdownMenu2">
										<button className="dropdown-item" type="button">Bank of America</button>
										<button className="dropdown-item" type="button">Another action</button>
										<button className="dropdown-item" type="button">Something else here</button>
									</div>
								</div>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"bank-account-number-state-login-page"}> Bank Account Number </label>
								<input type={"text"}
								       id={"bank-account-number-state-login-page"}
								       className={"form-control"}
								       name={"bank-account-number"}
								       aria-placeholder={"Enter Bank Account Number"}/>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"bank-name-drop-down"}>Select Biller</label>
								<div className="dropdown" id={"bank-name-drop-down"}>
									<button className="btn btn-secondary dropdown-toggle" type="button"
									        id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true"
									        aria-expanded="false">
										Choose Biller
									</button>
									<div className="dropdown-menu" aria-labelledby="dropdownMenu2">
										<button className="dropdown-item" type="button">Eversource</button>
										<button className="dropdown-item" type="button">Indira Energy</button>
										<button className="dropdown-item" type="button">Xfinity</button>
									</div>
								</div>
							</div>
							<div className={"form-group"}>
								<label htmlFor={"bank-account-number-state-login-page"}> Biller Account Number </label>
								<input type={"text"}
								       id={"bank-account-number-state-login-page"}
								       className={"form-control"}
								       name={"bank-account-number"}
								       aria-placeholder={"Enter Bank Account Number"}/>
							</div>
							<div className={"row"}>
								<div className={"col-sm-6"}>
									<button onClick={this.registerUser}
									        className={"btn btn-success"}>Register
									</button>
								</div>
								<div className={"col-sm-6"}>
									<Link to={"/"}>
										<button className={"btn btn-primary float-right"}>Login</button>
									</Link>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		);
	}

};
