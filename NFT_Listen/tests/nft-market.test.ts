import {
  assert,
  describe,
  test,
  clearStore,
  beforeAll,
  afterAll
} from "matchstick-as/assembly/index"
import { Address, BigInt, Bytes } from "@graphprotocol/graph-ts"
import { log } from "../generated/schema"
import { log as logEvent } from "../generated/NFT_Market/NFT_Market"
import { handlelog } from "../src/nft-market"
import { createlogEvent } from "./nft-market-utils"

// Tests structure (matchstick-as >=0.5.0)
// https://thegraph.com/docs/en/developer/matchstick/#tests-structure-0-5-0

describe("Describe entity assertions", () => {
  beforeAll(() => {
    let param0 = "Example string value"
    let newlogEvent = createlogEvent(param0)
    handlelog(newlogEvent)
  })

  afterAll(() => {
    clearStore()
  })

  // For more test scenarios, see:
  // https://thegraph.com/docs/en/developer/matchstick/#write-a-unit-test

  test("log created and stored", () => {
    assert.entityCount("log", 1)

    // 0xa16081f360e3847006db660bae1c6d1b2e17ec2a is the default address used in newMockEvent() function
    assert.fieldEquals(
      "log",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "param0",
      "Example string value"
    )

    // More assert options:
    // https://thegraph.com/docs/en/developer/matchstick/#asserts
  })
})
