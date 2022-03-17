# fellow-brawl 
 1 nft represents one fellow, within 1 year lots of schenanigans will happen! Your nft deposits might +() or -(), good luck to all!

## contract addresses
all deployed on rinkeby

- RandomnessHost 0xb65A4855C2dD416d1b98465Bd4B26235B72ffF2d
    (uses chainlink oracles to generate 2 verifyably random numbers)

- LeCryptoFellows 0x8ac2c13A1A21Ac44793576e8D01C9Dc00F4cECaA
    (ERC721 contract that also houses brawl function)

- BrawlInitiator 0xF5b8A679292129626e2c8C144a7C12602Bf0cac1
    (fetches random numbers, and feeds them to NFT contract)

RandomnessHost & BrawlInitiator are called by gelato_network every 30 mins to randomly redistribute fellow deposits :D





