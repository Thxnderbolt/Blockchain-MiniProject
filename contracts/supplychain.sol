// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {

    // Roles
    enum Role { None, Manufacturer, Distributor, Retailer }

    mapping(address => Role) public roles;

    // Product structure
    struct Product {
        uint256 batchId;
        string name;
        string manufacturer;
        address currentOwner;
        bool isAuthentic;
    }

    // Checkpoint structure
    struct Checkpoint {
        string location;
        uint256 timestamp;
        address updatedBy;
    }

    // Storage
    mapping(uint256 => Product) public products;
    mapping(uint256 => Checkpoint[]) public history;

    // Events
    event ProductCreated(uint256 batchId);
    event OwnershipTransferred(uint256 batchId, address newOwner);
    event CheckpointAdded(uint256 batchId, string location);
    event RoleAssigned(address user, Role role);

    // ------------------ MODIFIERS ------------------

    modifier onlyOwner(uint256 _batchId) {
        require(msg.sender == products[_batchId].currentOwner, "Not owner");
        _;
    }

    modifier onlyRole(Role _role) {
        require(roles[msg.sender] == _role, "Access denied");
        _;
    }

    // ------------------ ROLE MANAGEMENT ------------------

    function assignRole(address _user, Role _role) public {
        roles[_user] = _role;
        emit RoleAssigned(_user, _role);
    }

    // ------------------ CORE FUNCTIONS ------------------

    // Create Product (Only Manufacturer)
    function createProduct(
        uint256 _batchId,
        string memory _name,
        string memory _manufacturer
    ) public onlyRole(Role.Manufacturer) {

        require(products[_batchId].batchId == 0, "Product already exists");

        products[_batchId] = Product({
            batchId: _batchId,
            name: _name,
            manufacturer: _manufacturer,
            currentOwner: msg.sender,
            isAuthentic: true
        });

        emit ProductCreated(_batchId);
    }

    // Transfer Ownership
    function transferProduct(uint256 _batchId, address _newOwner)
        public
        onlyOwner(_batchId)
    {
        require(products[_batchId].batchId != 0, "Product does not exist");

        products[_batchId].currentOwner = _newOwner;

        emit OwnershipTransferred(_batchId, _newOwner);
    }

    // Add Checkpoint (Only current owner)
    function addCheckpoint(uint256 _batchId, string memory _location)
        public
        onlyOwner(_batchId)
    {
        require(products[_batchId].batchId != 0, "Product does not exist");

        history[_batchId].push(Checkpoint({
            location: _location,
            timestamp: block.timestamp,
            updatedBy: msg.sender
        }));

        emit CheckpointAdded(_batchId, _location);
    }

    // Get Full History
    function getHistory(uint256 _batchId)
        public
        view
        returns (Checkpoint[] memory)
    {
        return history[_batchId];
    }

    // Verify Product (FOR QR / FRONTEND)
    function verifyProduct(uint256 _batchId)
        public
        view
        returns (
            string memory name,
            string memory manufacturer,
            address owner,
            bool isAuthentic
        )
    {
        require(products[_batchId].batchId != 0, "Product does not exist");

        Product memory p = products[_batchId];

        return (p.name, p.manufacturer, p.currentOwner, p.isAuthentic);
    }
}