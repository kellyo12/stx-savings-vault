# STX Savings Vault Smart Contract

## Description

The **STX Savings Vault** is a Clarity smart contract designed for the Stacks blockchain. It enables users to deposit STX tokens into a secure on-chain vault and earn rewards over time. This contract provides a simple and trustless way to incentivize long-term STX holding while offering transparent accounting and reward distribution.

## Features

- 💰 **Deposit STX:** Users can lock STX into the vault to start earning.
- 📤 **Withdraw Anytime:** Users can withdraw their principal and earned rewards at any time.
- 🎁 **Reward Distribution:** Vault owner or protocol can periodically fund the vault with STX rewards.
- 📊 **Accurate Accounting:** Tracks user deposits and proportional rewards.
- 🔐 **Trustless Yield:** No intermediaries or custodians required—fully on-chain logic.

## Functions

- `deposit`: Deposit STX into the vault.
- `withdraw`: Withdraw deposited STX and earned rewards.
- `fund-rewards`: Add STX to the reward pool (by vault owner).
- `get-user-info`: View a user’s deposit and reward balance.
- `get-total-vault-info`: View total vault balance and reward pool.

## Setup & Testing

This contract is built using [Clarinet](https://docs.stacks.co/docs/clarity/clarinet/overview/), the standard tool for Clarity development.

### Run Tests

```bash
clarinet test
