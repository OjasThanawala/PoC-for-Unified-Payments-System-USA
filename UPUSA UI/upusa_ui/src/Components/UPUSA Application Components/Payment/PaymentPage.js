import React, {Component} from 'react'
import UserService from "../../../services/UserService";
import PaymentRow from "./PaymentRow";
import {Link, Redirect} from 'react-router-dom';
import $ from 'jquery'
import 'bootstrap'
import 'popper.js'

export default class PaymentPage extends Component {
	constructor(props) {
		super(props);
		this.state = {
			bankAccountList: [],
			redirect: false,
			transactionStatus: ''
		}
	}

	componentDidMount() {
		UserService.getInstance().getBankAccountInfo(this.props.match.params.userName)
			.then(response =>
				this.setState({
						bankAccountList: response
					}
				)
			)
	}

	payBill = (account_number, billId) => {
		UserService.getInstance().getBillData(billId).then(response => {
			console.log("response for bill amount: ", response);
			return UserService.getInstance().payBill(account_number, response[0]["bill_amount"], billId).then(response => {
				console.log("payment response: ", response);
				if(response["finalMessage"] === "update successful") {
					this.setState({
						transactionStatus: 'Transaction was successful. Please return.'
					});

				}
				else {
					this.setState({
						transactionStatus: 'Transaction was Unsuccessful. Please return.'
					});
				}
				$("#exampleModal").modal('show');
			})
		})
	};

	redirectTrue = () => {
		this.setState({
			redirect: true
		})
	}

	render() {
		if (this.state.redirect) {
			return <Redirect to={`/user/${this.props.match.params.userName}/home`}/>
		}
		return (
			<div>
				{/*MODAL START*/}
				<div className="modal fade" id="exampleModal" tabIndex="-1" role="dialog"
				     aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div className="modal-dialog" role="document">
						<div className="modal-content">
							<div className="modal-header">
								<h5 className="modal-title" id="exampleModalLabel">Modal title</h5>
								<button type="button" className="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div className="modal-body">
								{this.state.transactionStatus}
							</div>
							<div className="modal-footer">
								<button onClick={this.redirectTrue} type="button" className="btn btn-secondary" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				{/*MODAL END*/}
				<div className="card border-0 m-2">
					<div className="card-body">
						<div className={"container_fluid"}>
							<div className={"row font-weight-bold"}>
								<div className={"col-sm-2 mx-auto text-center"}>
									Payment Entity Name
								</div>
								<div className={"col-sm-2 mx-auto text-center"}>
									Account Number
								</div>
								<div className={"col-sm-2 mx-auto text-center"}>
									Payment Entity ID
								</div>
								<div className={"col-sm-2 mx-auto text-center"}>
									Pay
								</div>
							</div>
						</div>
					</div>
				</div>
				<PaymentRow bankAccountList={this.state.bankAccountList}
				            payBill={this.payBill}
				            billId={this.props.match.params.billId}/>
				<Link to={`/user/${this.props.match.params.userName}/home/current-bills`}>
					<button className={"btn btn-success btn-block m-2"} style={{width:'99%'}}>Back</button>
				</Link>
			</div>
		);
	}
}
