-- 创建表
CREATE TABLE IF NOT EXISTS t1(
    uuid VARCHAR(64) not null,
    name VARCHAR(20) not null,
    age INTEGER,
    ts TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY(uuid)
);


-- 插入数据
INSERT INTO t1 VALUES
  ('id1','Danny',23,TIMESTAMP '1970-01-01 00:00:01'),
  ('id2','Stephen',33,TIMESTAMP '1970-01-01 00:00:02'),
  ('id3','Julian',53,TIMESTAMP '1970-01-01 00:00:03'),
  ('id4','Fabian',31,TIMESTAMP '1970-01-01 00:00:04');

INSERT INTO t1 VALUES
  ('id5','Sophia',18,TIMESTAMP '1970-01-01 00:00:05'),
  ('id6','Emma',20,TIMESTAMP '1970-01-01 00:00:06'),
  ('id7','Bob',44,TIMESTAMP '1970-01-01 00:00:07'),
  ('id8','Han',56,TIMESTAMP '1970-01-01 00:00:08');


-- 查询数据
select * from t1;


-- 删除表
DROP TABLE IF EXISTS t1;


-- 创建用户
CREATE USER dbuser WITH PASSWORD 'test@123';
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dbuser;
ALTER ROLE dbuser SUPERUSER;
\du
