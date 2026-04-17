if (typeof ethers === "undefined") {
    alert("Ethers not loaded!");
}

const contractAddress = "0x5078022eFE3BAF84Fb883c7E632DD96e0874F350";

const abi = [
    "function verifyProduct(uint256) view returns (string,string,address,bool)",
    "function getHistory(uint256) view returns (tuple(string,uint256,address)[])"
];

let provider;
let signer;
let contract;

// Connect wallet
async function connect() {
    try {
        if (!window.ethereum) {
            alert("MetaMask not detected!");
            return;
        }

        await window.ethereum.request({ method: "eth_requestAccounts" });

        provider = new ethers.providers.Web3Provider(window.ethereum);
        signer = provider.getSigner();
        contract = new ethers.Contract(contractAddress, abi, signer);

        const address = await signer.getAddress();
        console.log("Connected:", address);

        alert("Wallet connected: " + address);

    } catch (err) {
        console.error(err);
        alert("Connection failed: " + err.message);
    }
}

// Load batchId from QR URL
function loadBatchFromURL() {
    const params = new URLSearchParams(window.location.search);
    const batchId = params.get("batchId");

    if (batchId) {
        document.getElementById("batchId").value = batchId;
    }
}

// Verify product
async function verifyProduct() {
    try {
        if (!contract) {
            alert("Please connect wallet first");
            return;
        }

        const batchId = document.getElementById("batchId").value;

        if (!batchId) {
            alert("Enter Batch ID");
            return;
        }

        // Fetch product
        const result = await contract.verifyProduct(batchId);

        document.getElementById("result").innerText =
`Name: ${result[0]}
Manufacturer: ${result[1]}
Owner: ${result[2]}
Authentic: ${result[3]}`;

        // Fetch history
        const history = await contract.getHistory(batchId);

        let historyText = "";

        history.forEach((h, index) => {
            historyText += `Step ${index + 1}
        Location: ${h[0]}
        Time: ${new Date(h[1] * 1000).toLocaleString()}
        Updated By: ${h[2]}

        `;
        });

        document.getElementById("history").innerText = historyText;

    } catch (err) {
        console.error(err);
        alert("Error fetching data (check console)");
    }
}

function generateQR() {

    const txHash = "0x558b553706291bb428a56c24f912b7d89c6efc32156539b4f09cb8d47a98ed48";

    const url = `https://sepolia.etherscan.io/tx/${txHash}`;

    document.getElementById("qrcode").innerHTML = "";

    new QRCode(document.getElementById("qrcode"), {
        text: url,
        width: 200,
        height: 200
    });
}

// Run on page load
window.onload = loadBatchFromURL;