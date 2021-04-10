// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "https://github.com/smartcontractkit/chainlink/blob/master/evm-contracts/src/v0.7/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

    AggregatorV3Interface internal priceFeed;

    /**
     * https://docs.chain.link/docs/binance-smart-chain-addresses
     * Network: BSC Testnet
     * Aggregator: BNB / USD
     * Address: 0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526
     */
    constructor() public {
        priceFeed = AggregatorV3Interface(0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
    }
}
