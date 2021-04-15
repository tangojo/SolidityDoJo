# SafeTest 
SAFETEST is a Safemoon clone for testnet purposes.

Inital deployment configuration:
- _decimals = 9
- _tTotal = 1000 * 10**6 * 10**9; // 1 billion 
- _liquidityFee = 5; // provides Liquidity to Pancakeswap; original $HATE $LIQ logic
- _taxFee = 5; // auto distribute to holders; original $RFI logic
- swapAndLiquifyEnabled = true;
- _maxTxAmount = 500 * 10**6 * 10**9; // initially set to half a billion
- numTokensSellToAddToLiquidity = 500 * 10**6 * 10**9; // initially set  to half a billion

Changes made:
- Pancakeswap Router address to 0xD99D1c33F9fC3444f8101754aBC46c52416550D1 testnet