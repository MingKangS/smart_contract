// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Post {
    struct PostStruct {
        address author;
        string postContent;
        uint256 timestamp;
    }

    PostStruct[] posts;

    function addPost(string memory postContent) public {
        posts.push(PostStruct(msg.sender, postContent, block.timestamp));
    }

    function getAllPosts() public view returns (PostStruct[] memory) {
        return posts;
    }
}
