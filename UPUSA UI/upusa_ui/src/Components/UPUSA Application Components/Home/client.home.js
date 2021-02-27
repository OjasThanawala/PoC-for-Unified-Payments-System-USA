import React, {Component} from 'react'
import {Link} from "react-router-dom";
import CurrentBill from "../../Biller Application Components/Bill/CurrentBill";
import BillHistory from "../../Biller Application Components/Bill/BillHistory";

export default class Home extends Component {

	constructor(props) {
		super(props);
		console.log("props received: ", props);
		console.log("test of props: ", props.props);
		this.state = {
			username: props.match.params.userName,
			currentView: this.props.currentView
		}
	}

	render() {
		return (
			<div>
				<nav className={"navbar navbar-expand-sm navbar-dark bg-light"}>
					<div className="container-fluid">
						<div className="row input-group">
							<div className={"col-sm-2 col-md-2"}>
								<Link to={"/"}>
									<div className="navbar-brand text-dark">
										U.P.U.S.A
									</div>
								</Link>
							</div>
							<div className="col-sm-10 col-md-10 input-group">
								<div className={"container-fluid"}>
									<div className={"row mt-2"}>
										<div className={"col-sm-2"}>
											<Link to={`/user/${this.state.username}/home/current-bills`}>
												Current Bills
											</Link>
										</div>
										<div className={"col-sm-2"}>
											<Link to={`/user/${this.state.username}/home/bill-history`}>
												Bill History
											</Link>
										</div>
										<div className={"col-sm-6"}>
										</div>
										<div className={"col-sm-2"}>
											<Link to={"/"} className={"float-right"}>
												LogOut
											</Link>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</nav>
				<div className={"container-fluid"}>
					{this.state.currentView === 'currentBills' ?
						<CurrentBill username={this.state.username}/>
						:
						<BillHistory username={this.state.username}/>}
				</div>
			</div>
		);
	}
}
