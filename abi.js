window.abi=[
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			}
		],
		"name": "accept_project",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			}
		],
		"name": "apply_for_job_evaluator",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "min_tokens",
				"type": "uint256"
			}
		],
		"name": "apply_for_job_freelancer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "buyTokens",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "freelancer_id",
				"type": "uint256"
			}
		],
		"name": "choose_freelancer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "descr",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "cost_dez",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "recompensa",
				"type": "uint256"
			}
		],
		"name": "createProduct",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "pr_id",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "tokenss",
				"type": "uint256"
			}
		],
		"name": "fintantare",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address payable",
				"name": "mngs",
				"type": "address"
			},
			{
				"internalType": "address payable",
				"name": "eval",
				"type": "address"
			},
			{
				"internalType": "address payable",
				"name": "frelancer",
				"type": "address"
			},
			{
				"internalType": "address payable",
				"name": "finat",
				"type": "address"
			}
		],
		"name": "initMarketplace",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			}
		],
		"name": "project_done",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			}
		],
		"name": "reject_project",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "applier_id",
				"type": "uint256"
			}
		],
		"name": "show_applyer",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			}
		],
		"name": "show_contract",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "result",
				"type": "bool"
			}
		],
		"name": "solve_dispute",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "project_id",
				"type": "uint256"
			}
		],
		"name": "start_project",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "tokenContract",
		"outputs": [
			{
				"internalType": "contract SampleToken",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]