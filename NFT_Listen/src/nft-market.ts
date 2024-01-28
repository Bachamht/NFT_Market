import {
  log as logEvent,
  log_address as log_addressEvent,
  log_array as log_arrayEvent,
  log_array1 as log_array1Event,
  log_array2 as log_array2Event,
  log_bytes as log_bytesEvent,
  log_bytes32 as log_bytes32Event,
  log_int as log_intEvent,
  log_named_address as log_named_addressEvent,
  log_named_array as log_named_arrayEvent,
  log_named_array1 as log_named_array1Event,
  log_named_array2 as log_named_array2Event,
  log_named_bytes as log_named_bytesEvent,
  log_named_bytes32 as log_named_bytes32Event,
  log_named_decimal_int as log_named_decimal_intEvent,
  log_named_decimal_uint as log_named_decimal_uintEvent,
  log_named_int as log_named_intEvent,
  log_named_string as log_named_stringEvent,
  log_named_uint as log_named_uintEvent,
  log_string as log_stringEvent,
  log_uint as log_uintEvent,
  logs as logsEvent
} from "../generated/NFT_Market/NFT_Market"
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
} from "../generated/schema"

export function handlelog(event: logEvent): void {
  let entity = new log(event.transaction.hash.concatI32(event.logIndex.toI32()))
  entity.param0 = event.params.param0

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_address(event: log_addressEvent): void {
  let entity = new log_address(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.param0 = event.params.param0

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_array(event: log_arrayEvent): void {
  let entity = new log_array(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_array1(event: log_array1Event): void {
  let entity = new log_array1(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_array2(event: log_array2Event): void {
  let entity = new log_array2(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_bytes(event: log_bytesEvent): void {
  let entity = new log_bytes(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.param0 = event.params.param0

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_bytes32(event: log_bytes32Event): void {
  let entity = new log_bytes32(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.param0 = event.params.param0

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_int(event: log_intEvent): void {
  let entity = new log_int(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.param0 = event.params.param0

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_address(event: log_named_addressEvent): void {
  let entity = new log_named_address(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_array(event: log_named_arrayEvent): void {
  let entity = new log_named_array(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_array1(event: log_named_array1Event): void {
  let entity = new log_named_array1(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_array2(event: log_named_array2Event): void {
  let entity = new log_named_array2(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_bytes(event: log_named_bytesEvent): void {
  let entity = new log_named_bytes(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_bytes32(event: log_named_bytes32Event): void {
  let entity = new log_named_bytes32(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_decimal_int(
  event: log_named_decimal_intEvent
): void {
  let entity = new log_named_decimal_int(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val
  entity.decimals = event.params.decimals

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_decimal_uint(
  event: log_named_decimal_uintEvent
): void {
  let entity = new log_named_decimal_uint(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val
  entity.decimals = event.params.decimals

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_int(event: log_named_intEvent): void {
  let entity = new log_named_int(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_string(event: log_named_stringEvent): void {
  let entity = new log_named_string(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_named_uint(event: log_named_uintEvent): void {
  let entity = new log_named_uint(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.key = event.params.key
  entity.val = event.params.val

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_string(event: log_stringEvent): void {
  let entity = new log_string(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.param0 = event.params.param0

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelog_uint(event: log_uintEvent): void {
  let entity = new log_uint(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.param0 = event.params.param0

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelogs(event: logsEvent): void {
  let entity = new logs(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.param0 = event.params.param0

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}
