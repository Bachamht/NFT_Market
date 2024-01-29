CREATE TABLE IF NOT EXISTS `t_nft_info`
(
    `solderAddress` VARCHAR(20)       NOT NULL COMMENT '卖家地址'
    `signature`     VARCHAR(35)       NOT NULL COMMENT '签名',
    `tokenId`   	INT               NOT NULL COMMENT 'nft的id',
    `price`         INT			      NOT NULL COMMENT '价格',
    `created_at` 	TIMESTAMP    		NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`    TIMESTAMP    		NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`phone_number`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;