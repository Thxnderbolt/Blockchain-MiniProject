# Supply Chain Product Authenticity Tracker

## Overview

This project is a blockchain-based supply chain tracking system designed to ensure product authenticity. It enables manufacturers, distributors, and retailers to record and verify the journey of a product from origin to consumer.

Consumers can verify whether a product is genuine by checking its history stored on the blockchain.

---

## Problem Statement

* Counterfeit products are common in industries such as pharmaceuticals, luxury goods, and electronics
* Product origin information can be forged
* Supply chain records are often fragmented and lack transparency
* Consumers cannot independently verify authenticity

---

## Proposed Solution

This system uses a smart contract to:

* Assign a unique batch ID to each product
* Store product details on the blockchain
* Record each supply chain step as a checkpoint
* Track ownership transfers securely
* Allow consumers to verify authenticity using a batch ID or QR code

---

## Features

* Product creation (restricted to manufacturer role)
* Ownership transfer across supply chain participants
* Checkpoint tracking for each stage of the product journey
* Retrieval of complete product history
* Product verification using batch ID

* Role-based access control (Manufacturer, Distributor, Retailer)
* Event logging for transparency and traceability
* Frontend interface using Ethers.js and MetaMask
* QR code-based verification support

---

## Technologies Used

* Solidity (Smart Contracts)
* Ethereum (Blockchain platform)
* Remix IDE (Development and deployment)
* Ethers.js (Frontend blockchain interaction)
* MetaMask (Wallet integration)
* HTML, JavaScript (Frontend)

---

## How to Run the Project

### Smart Contract Deployment

1. Open Remix IDE (https://remix.ethereum.org)
2. Compile the `SupplyChain.sol` contract
3. Select "Injected Provider - MetaMask" as the environment
4. Deploy the contract
5. Copy the deployed contract address

### Frontend Setup

1. Navigate to the `frontend` folder
2. Open `app.js`
3. Replace the contract address with the deployed address
4. Run `index.html` using Live Server

### Usage

1. Connect MetaMask wallet
2. Enter a valid batch ID
3. Click "Verify"
4. View product details and supply chain history

## Conclusion

This project demonstrates how blockchain technology can be used to improve transparency, traceability, and trust in supply chains. By leveraging smart contracts and decentralized storage, it ensures that product information remains secure and tamper-proof.
