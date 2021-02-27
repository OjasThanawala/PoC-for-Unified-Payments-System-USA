import React, {Component} from 'react'
import BillHistoryRow from "./BillHistoryRow";
import UserService from "../../../services/UserService";
import CurrentBillRow from "./CurrentBillRow";

export default class BillHistory extends Component {
	constructor(props){
		super(props);
		this.state = {
			currentBillsList:[]
		}
	}

	componentDidMount() {
		UserService.getInstance().billHistory(this.props.username)
			.then(response => {
				console.log(response);
				this.setState({
					currentBillsList: response
				});
			});
	}

	render() {
		return(<div>
			<div className="card border-0 bg-transparent">
				<div className="card-body">
					<div className={"container_fluid"}>
						<div className={"row font-weight-bold"}>
							<div className={"col-sm-2 mx-auto text-center"}>
								Biller Account No.
							</div>
							<div className={"col-sm-1 mx-auto text-center"}>
								Biller Bill Id
							</div>
							<div className={"col-sm-2 mx-auto text-center"}>
								Bill Paid On Date
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
							</div>
						</div>
					</div>
				</div>
			</div>
			<BillHistoryRow bills={this.state.currentBillsList}/>
		</div>);
	}
}
