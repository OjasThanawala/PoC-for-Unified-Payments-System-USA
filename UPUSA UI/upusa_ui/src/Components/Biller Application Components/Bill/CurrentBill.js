import React, {Component} from 'react'
import CurrentBillRow from "./CurrentBillRow";
import UserService from "../../../services/UserService";

export default class CurrentBill extends Component {
	constructor(props) {
		super(props)
		this.state = {
			currentBillsList: []
		}
	}

	componentDidMount() {
		UserService.getInstance().liveBills(this.props.username)
			.then(response => {
				console.log(response);
				this.setState({
					currentBillsList: response
				});
			});
	}

	render() {
		return (
			<div>
				<div className="card border-0 bg-transparent">
					<div className="card-body">
						<div className={"container_fluid"}>
							<div className={"row font-weight-bold"}>
								<div className={"col-sm-1 mx-auto text-center"}>
									Biller Account No.
								</div>
								<div className={"col-sm-1 mx-auto text-center"}>
									Biller Bill Id
								</div>
								<div className={"col-sm-2 mx-auto text-center"}>
									Bill Payment Due Date
								</div>
								<div className={"col-sm-2 mx-auto text-center"}>
									Biller Id
								</div>
								<div className={"col-sm-2 mx-auto text-center"}>
									Service Type
								</div>
								<div className={"col-sm-2 mx-auto text-center"}>
									Bill Amount
								</div>
								<div className={"col-sm-1 mx-auto text-center"}>
									Pay
								</div>
							</div>
						</div>
					</div>
				</div>
				<CurrentBillRow bills={this.state.currentBillsList}
				                username={this.props.username}/>
			</div>
		);
	}
}

