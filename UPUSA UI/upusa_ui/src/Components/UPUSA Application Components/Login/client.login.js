import React, {Component} from 'react';
import {Link} from "react-router-dom";
import {Redirect} from 'react-router-dom';
import UserService from '../../../services/UserService'

export default class Login extends Component {

	constructor(props) {
		super(props);
		this.state = {
			username: '',
			redirectToDashboard: false,
		}
	}

	checkUserExistence = () => {
		let userExists = 0;
		let userName = document.getElementById("user-name-login-page").value;
		let password = document.getElementById("password-login-page").value;
		UserService.getInstance().checkUserPresence(userName, password)
			.then(response => {
				console.log("response from server:", response);
				userExists = response["result"];
				if (userExists) {
					this.setState({
						username: userName,
						redirectToDashboard: true
					});
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
							<div className={"row"}>
								<div className={"col-sm-6"}>
									<button onClick={this.checkUserExistence} className={"btn btn-primary"}>Login
									</button>
								</div>
								<div className={"col-sm-6"}>
									<Link to={"/register"}>
										<button
											className={"btn btn-success float-right"}>Register
										</button>
									</Link>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		)
	}
};
