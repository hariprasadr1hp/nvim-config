// Solidity example to test editor settings

// Specify the version of Solidity
pragma solidity ^0.8.0;

// Define a simple contract
contract ExampleContract {

    // State variables
    string public name;
    uint256 public count;
    address public owner;

    // Events
    event NameChanged(string newName);
    event CountIncremented(uint256 newCount);

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Constructor to initialize contract state
    constructor(string memory _name) {
        name = _name;
        count = 0;
        owner = msg.sender;
    }

    // Public function to change the name
    function changeName(string memory _newName) public onlyOwner {
        name = _newName;
        emit NameChanged(_newName);
    }

    // Public function to increment the count
    function incrementCount() public {
        count += 1;
        emit CountIncremented(count);
    }

    // View function to get contract details
    function getDetails() public view returns (string memory, uint256, address) {
        return (name, count, owner);
    }

    // Fallback function to handle unexpected transactions
    fallback() external payable {
        // Custom fallback logic
    }

    // Function to withdraw ether from the contract (only owner)
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // Receive ether function
    receive() external payable {}
}

