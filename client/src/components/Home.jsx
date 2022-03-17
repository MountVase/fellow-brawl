import React, { useState } from "react";
import { Card, Typography, Button, Input } from "antd";
import { useMoralis, useWeb3Contract } from "react-moralis";
import { abi } from "../contracts/LeCryptoFellows.json";

export default function QuickStart() {
  const { account } = useMoralis();
  const [address, setAddress] = useState();
  const [uri, setUri] = useState();

  const { runContractFunction, isLoading } = useWeb3Contract({
    functionName: "initializeFellow",
    abi,
    contractAddress: "0x8ac2c13A1A21Ac44793576e8D01C9Dc00F4cECaA",
    params: {
      address,
      uri
    },
  });

  return (
    <div style={{ display: "flex" }}>
      <Card
        bordered={false}
        style={{
          width: 600,
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          textAlign: "center",
        }}
      >
        <Typography.Title level={3}>LeCryptoFellows Braẃl. Enter if you're worthy!</Typography.Title>
        <img
          src="https://ipfs.moralis.io:2053/ipfs/QmebxzVBtcEznrZgSUxorrdL8Q1XEbiyRaGxHUuwWUoF1o/images/0.png"
          alt="Test"
          style={{ marginBottom: "2rem" }}
        />
        <Input placeholder="address" onChange={(e) => setAddress(e.target.value)}/>
        <Input placeholder="uri" onChange={(e) => setUri(e.target.value)} />
        <Button
          type="primary"
          shape="round"
          size="large"
          style={{ width: "100%" }}
          loading={isLoading}
          onClick={() => runContractFunction()}
        >
          JOIN
        </Button>
      </Card>
    </div>
  );
}
