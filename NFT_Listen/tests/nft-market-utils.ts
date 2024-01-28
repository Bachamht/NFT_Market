import { newMockEvent } from "matchstick-as"
import { ethereum, Address, BigInt, Bytes } from "@graphprotocol/graph-ts"
import {
  log,
  log_address,
  log_array,
  log_array1,
  log_array2,
  log_bytes,
  log_bytes32,
  log_int,
  log_named_address,
  log_named_array,
  log_named_array1,
  log_named_array2,
  log_named_bytes,
  log_named_bytes32,
  log_named_decimal_int,
  log_named_decimal_uint,
  log_named_int,
  log_named_string,
  log_named_uint,
  log_string,
  log_uint,
  logs
} from "../generated/NFT_Market/NFT_Market"

export function createlogEvent(param0: string): log {
  let logEvent = changetype<log>(newMockEvent())

  logEvent.parameters = new Array()

  logEvent.parameters.push(
    new ethereum.EventParam("param0", ethereum.Value.fromString(param0))
  )

  return logEvent
}

export function createlog_addressEvent(param0: Address): log_address {
  let logAddressEvent = changetype<log_address>(newMockEvent())

  logAddressEvent.parameters = new Array()

  logAddressEvent.parameters.push(
    new ethereum.EventParam("param0", ethereum.Value.fromAddress(param0))
  )

  return logAddressEvent
}

export function createlog_arrayEvent(val: Array<BigInt>): log_array {
  let logArrayEvent = changetype<log_array>(newMockEvent())

  logArrayEvent.parameters = new Array()

  logArrayEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromUnsignedBigIntArray(val))
  )

  return logArrayEvent
}

export function createlog_array1Event(val: Array<BigInt>): log_array1 {
  let logArray1Event = changetype<log_array1>(newMockEvent())

  logArray1Event.parameters = new Array()

  logArray1Event.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromSignedBigIntArray(val))
  )

  return logArray1Event
}

export function createlog_array2Event(val: Array<Address>): log_array2 {
  let logArray2Event = changetype<log_array2>(newMockEvent())

  logArray2Event.parameters = new Array()

  logArray2Event.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromAddressArray(val))
  )

  return logArray2Event
}

export function createlog_bytesEvent(param0: Bytes): log_bytes {
  let logBytesEvent = changetype<log_bytes>(newMockEvent())

  logBytesEvent.parameters = new Array()

  logBytesEvent.parameters.push(
    new ethereum.EventParam("param0", ethereum.Value.fromBytes(param0))
  )

  return logBytesEvent
}

export function createlog_bytes32Event(param0: Bytes): log_bytes32 {
  let logBytes32Event = changetype<log_bytes32>(newMockEvent())

  logBytes32Event.parameters = new Array()

  logBytes32Event.parameters.push(
    new ethereum.EventParam("param0", ethereum.Value.fromFixedBytes(param0))
  )

  return logBytes32Event
}

export function createlog_intEvent(param0: BigInt): log_int {
  let logIntEvent = changetype<log_int>(newMockEvent())

  logIntEvent.parameters = new Array()

  logIntEvent.parameters.push(
    new ethereum.EventParam("param0", ethereum.Value.fromSignedBigInt(param0))
  )

  return logIntEvent
}

export function createlog_named_addressEvent(
  key: string,
  val: Address
): log_named_address {
  let logNamedAddressEvent = changetype<log_named_address>(newMockEvent())

  logNamedAddressEvent.parameters = new Array()

  logNamedAddressEvent.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedAddressEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromAddress(val))
  )

  return logNamedAddressEvent
}

export function createlog_named_arrayEvent(
  key: string,
  val: Array<BigInt>
): log_named_array {
  let logNamedArrayEvent = changetype<log_named_array>(newMockEvent())

  logNamedArrayEvent.parameters = new Array()

  logNamedArrayEvent.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedArrayEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromUnsignedBigIntArray(val))
  )

  return logNamedArrayEvent
}

export function createlog_named_array1Event(
  key: string,
  val: Array<BigInt>
): log_named_array1 {
  let logNamedArray1Event = changetype<log_named_array1>(newMockEvent())

  logNamedArray1Event.parameters = new Array()

  logNamedArray1Event.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedArray1Event.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromSignedBigIntArray(val))
  )

  return logNamedArray1Event
}

export function createlog_named_array2Event(
  key: string,
  val: Array<Address>
): log_named_array2 {
  let logNamedArray2Event = changetype<log_named_array2>(newMockEvent())

  logNamedArray2Event.parameters = new Array()

  logNamedArray2Event.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedArray2Event.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromAddressArray(val))
  )

  return logNamedArray2Event
}

export function createlog_named_bytesEvent(
  key: string,
  val: Bytes
): log_named_bytes {
  let logNamedBytesEvent = changetype<log_named_bytes>(newMockEvent())

  logNamedBytesEvent.parameters = new Array()

  logNamedBytesEvent.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedBytesEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromBytes(val))
  )

  return logNamedBytesEvent
}

export function createlog_named_bytes32Event(
  key: string,
  val: Bytes
): log_named_bytes32 {
  let logNamedBytes32Event = changetype<log_named_bytes32>(newMockEvent())

  logNamedBytes32Event.parameters = new Array()

  logNamedBytes32Event.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedBytes32Event.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromFixedBytes(val))
  )

  return logNamedBytes32Event
}

export function createlog_named_decimal_intEvent(
  key: string,
  val: BigInt,
  decimals: BigInt
): log_named_decimal_int {
  let logNamedDecimalIntEvent = changetype<log_named_decimal_int>(
    newMockEvent()
  )

  logNamedDecimalIntEvent.parameters = new Array()

  logNamedDecimalIntEvent.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedDecimalIntEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromSignedBigInt(val))
  )
  logNamedDecimalIntEvent.parameters.push(
    new ethereum.EventParam(
      "decimals",
      ethereum.Value.fromUnsignedBigInt(decimals)
    )
  )

  return logNamedDecimalIntEvent
}

export function createlog_named_decimal_uintEvent(
  key: string,
  val: BigInt,
  decimals: BigInt
): log_named_decimal_uint {
  let logNamedDecimalUintEvent = changetype<log_named_decimal_uint>(
    newMockEvent()
  )

  logNamedDecimalUintEvent.parameters = new Array()

  logNamedDecimalUintEvent.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedDecimalUintEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromUnsignedBigInt(val))
  )
  logNamedDecimalUintEvent.parameters.push(
    new ethereum.EventParam(
      "decimals",
      ethereum.Value.fromUnsignedBigInt(decimals)
    )
  )

  return logNamedDecimalUintEvent
}

export function createlog_named_intEvent(
  key: string,
  val: BigInt
): log_named_int {
  let logNamedIntEvent = changetype<log_named_int>(newMockEvent())

  logNamedIntEvent.parameters = new Array()

  logNamedIntEvent.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedIntEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromSignedBigInt(val))
  )

  return logNamedIntEvent
}

export function createlog_named_stringEvent(
  key: string,
  val: string
): log_named_string {
  let logNamedStringEvent = changetype<log_named_string>(newMockEvent())

  logNamedStringEvent.parameters = new Array()

  logNamedStringEvent.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedStringEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromString(val))
  )

  return logNamedStringEvent
}

export function createlog_named_uintEvent(
  key: string,
  val: BigInt
): log_named_uint {
  let logNamedUintEvent = changetype<log_named_uint>(newMockEvent())

  logNamedUintEvent.parameters = new Array()

  logNamedUintEvent.parameters.push(
    new ethereum.EventParam("key", ethereum.Value.fromString(key))
  )
  logNamedUintEvent.parameters.push(
    new ethereum.EventParam("val", ethereum.Value.fromUnsignedBigInt(val))
  )

  return logNamedUintEvent
}

export function createlog_stringEvent(param0: string): log_string {
  let logStringEvent = changetype<log_string>(newMockEvent())

  logStringEvent.parameters = new Array()

  logStringEvent.parameters.push(
    new ethereum.EventParam("param0", ethereum.Value.fromString(param0))
  )

  return logStringEvent
}

export function createlog_uintEvent(param0: BigInt): log_uint {
  let logUintEvent = changetype<log_uint>(newMockEvent())

  logUintEvent.parameters = new Array()

  logUintEvent.parameters.push(
    new ethereum.EventParam("param0", ethereum.Value.fromUnsignedBigInt(param0))
  )

  return logUintEvent
}

export function createlogsEvent(param0: Bytes): logs {
  let logsEvent = changetype<logs>(newMockEvent())

  logsEvent.parameters = new Array()

  logsEvent.parameters.push(
    new ethereum.EventParam("param0", ethereum.Value.fromBytes(param0))
  )

  return logsEvent
}
