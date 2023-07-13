// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Post {
    struct PostStruct {
        address author;
        string postContent;
        uint256 timestamp;
        string[] images;
        address[] upvotes;
        address[] downvotes;
        address[] reports;
    }

    struct CommentStruct {
        string text;
        address author;
        uint256 timestamp;
    }

    struct DisplayPostStruct {
        uint256 id;
        address authorId;
        AccountStruct author;
        string postContent;
        uint256 timestamp;
        string[] images;
        address[] upvotes;
        address[] downvotes;
        address[] reports;
        DisplayCommentStruct[] comments;
    }

    struct DisplayCommentStruct {
        AccountStruct author;
        string text;
        uint256 timestamp;
    }

    mapping(uint256 => PostStruct) posts;
    uint256 postCount = 0;

    mapping(uint256 => CommentStruct[]) comments;

    struct AccountStruct {
        string username;
        string color;
        string profilePicture;
    }

    mapping(address => AccountStruct) accounts;

    function addPost(string memory postContent, string[] memory images) public {
        postCount += 1;
        posts[postCount] = PostStruct(
            msg.sender,
            postContent,
            block.timestamp,
            images,
            new address[](0),
            new address[](0),
            new address[](0)
        );
    }

    function editPost(
        uint256 postId,
        string memory postContent,
        string[] memory images
    ) public {
        posts[postId].postContent = postContent;
        posts[postId].images = images;
    }

    function addressToAccountArray(
        address[] memory addressArray
    ) private view returns (AccountStruct[] memory) {
        AccountStruct[] memory accountsArray = new AccountStruct[](
            addressArray.length
        );

        for (uint256 i = 0; i < addressArray.length; i++) {
            accountsArray[i] = accounts[addressArray[i]];
        }
        return accountsArray;
    }

    function getDetailedCommentsArray(
        CommentStruct[] memory postComments
    ) private view returns (DisplayCommentStruct[] memory) {
        DisplayCommentStruct[]
            memory detailedComments = new DisplayCommentStruct[](
                postComments.length
            );

        for (uint256 i = 0; i < postComments.length; i++) {
            detailedComments[i].author = accounts[postComments[i].author];
            detailedComments[i].text = postComments[i].text;
            detailedComments[i].timestamp = postComments[i].timestamp;
        }

        return detailedComments;
    }

    function getAllPosts() public view returns (DisplayPostStruct[] memory) {
        DisplayPostStruct[] memory detailedPosts = new DisplayPostStruct[](
            postCount
        );

        for (uint256 i = 1; i <= postCount; i++) {
            PostStruct memory post = posts[i];
            detailedPosts[i - 1] = DisplayPostStruct(
                i,
                post.author,
                accounts[post.author],
                post.postContent,
                post.timestamp,
                post.images,
                post.upvotes,
                post.downvotes,
                post.reports,
                getDetailedCommentsArray(comments[i])
            );
        }

        return detailedPosts;
    }

    function upvotePost(uint256 postId) public returns (uint256) {
        posts[postId].upvotes.push(msg.sender);
        return posts[postId].upvotes.length;
    }

    function downvotePost(uint256 postId) public returns (uint256) {
        posts[postId].downvotes.push(msg.sender);
        return posts[postId].downvotes.length;
    }

    function reportPost(uint256 postId) public returns (uint256) {
        posts[postId].reports.push(msg.sender);
        return posts[postId].reports.length;
    }

    function editAccount(
        AccountStruct memory newAccount
    ) public returns (AccountStruct memory) {
        accounts[msg.sender] = newAccount;
        return accounts[msg.sender];
    }

    function getAccount(
        address accountAddress
    ) public view returns (AccountStruct memory) {
        return accounts[accountAddress];
    }

    function addComment(uint256 postId, string memory comment) public {
        comments[postId].push(
            CommentStruct(comment, msg.sender, block.timestamp)
        );
    }
}
