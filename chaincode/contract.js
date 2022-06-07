//The purpose of "use strict" is to indicate that the code should be executed in "strict mode".
//With strict mode, you can not, for example, use undeclared variables.
// refer -- https://www.w3schools.com/js/js_strict.asp
'use strict';

const {Contract} = require('fabric-contract-api');

class PropnetContract extends Contract {
	
	constructor() {
		// Provide a custom name to refer to this smart contract
		super('org.propertyregistration-network.regnet');
	}
	
	/* ****** All custom functions are defined below ***** */
	
	// This is a basic user defined function used at the time of instantiating the smart contract
	// to print the success message on console
	async instantiate(ctx) {
		console.log('Example1 Smart Contract Instantiated');
	}
	
	/**
	 * Create a new student account on the network
	 * @param ctx - The transaction context object
	 * @param studentId - ID to be used for creating a new student account
	 * @param name - Name of the student
	 * @param email - Email ID of the student
	 * @returns
	 */
	async createStudent(ctx, studentId, name, email) {
		// Create a new composite key for the new student account
		const studentKey = ctx.stub.createCompositeKey('org.propertyregistration-network.regnet.student', [studentId]);
		let studentBuffer = await ctx.stub.getState(studentKey);
		if (!studentBuffer || studentBuffer.length === 0) {
			// Create a student object to be stored in blockchain
			let newStudentObject = {
				studentId: studentId,
				name: name,
				email: email,
				school: ctx.clientIdentity.getID(),
				createdAt: new Date(),
				updatedAt: new Date(),
			};
		
			// Convert the JSON object to a buffer and send it to blockchain for storage
			let dataBuffer = Buffer.from(JSON.stringify(newStudentObject));
			await ctx.stub.putState(studentKey, dataBuffer);
			// Return value of new student account created to user
			return newStudentObject;
		}
		else {
			//console.log("Student Already Exist");
			throw new Error ("Student with Id   " + studentId + "   Already Exist");
		}
			
	}
	
	/**
	 * Get a student account's details from the blockchain
	 * @param ctx - The transaction context
	 * @param studentId - Student ID for which to fetch details
	 * @returns
	 */
	async getStudent(ctx, studentId) {
		// Create the composite key required to fetch record from blockchain
		const studentKey = ctx.stub.createCompositeKey('org.propertyregistration-network.regnet.student', [studentId]);
		
		// Return value of student account from blockchain
		let studentBuffer = await ctx.stub
				.getState(studentKey)
				.catch(err => console.log(err));
				
				if (!studentBuffer || studentBuffer.length === 0) {
					//return "Student with Id   " + studentId + "   does not Exist";
					throw new Error(" Student with Id   " + studentId + "   does not Exist");
					//return JSON.parse(studentBuffer.toString());
				}
				else {
					return JSON.parse(studentBuffer.toString());
				}
				
	}
	
}

module.exports = PropnetContract;