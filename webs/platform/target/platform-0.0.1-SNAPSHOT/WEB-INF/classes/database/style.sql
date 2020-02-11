DROP TABLE IF EXISTS SHORT_URL;
CREATE TABLE SHORT_URL (
                           PKID               BIGINT(20)      NOT NULL AUTO_INCREMENT    COMMENT '主键',
                           SHORT_URL          VARCHAR(255)    NOT NULL                   COMMENT '短网址路径',
                           LONG_URL           VARCHAR(255)    NOT NULL                   COMMENT '长网址路径',
                           PATH_URL           VARCHAR(255)    NOT NULL                   COMMENT '请求的路径',
                           C_DATE             DATETIME        NOT NULL                   COMMENT '创建时间',
                           REDIRCT_TIME       BIGINT(20)      DEFAULT 0                  COMMENT '转发次数',
                           PRIMARY KEY (PKID)
) ENGINE=INNODB AUTO_INCREMENT=1 COMMENT = '短网址';