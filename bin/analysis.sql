-- 根据聊天关键词找到对方的talker
select *from message where content like '%去年的聊天记录%'

-- 查看消息
select * from message where talker = 'wxid_id8oll' 
order by createTime desc

-- 删除除了主角外所有的消息
delete from message where talker != 'wxid_id8oll'
-- 删除统计外日期
delete from message where (createTime / 1000) < unix_timestamp('2021-01-01 00:00:00');

-- 验证日期是否删除正确
select from_unixtime(min(createTime)/1000) from message;

-- 获取最晚说的话
select msgId,talker,content, from_unixtime(createTime/1000), DATE_FORMAT(from_unixtime(createTime/1000),'%H') as h from message
where DATE_FORMAT(from_unixtime(createTime/1000),'%H') <= 5
order by h desc, createTime

-- 总数
select count(msgId) from message
-- 关键字
select msgId,content, from_unixtime(createTime/1000) from message
where content like '%爱你%'

select count(msgId) from message
where content like '%爱你%'

select msgId,content, from_unixtime(createTime/1000) from message
where content like '%想你%'

select count(msgId) from message
where content like '%想你%'

select msgId,content, from_unixtime(createTime/1000) from message
where content like '%喜欢你%'

select msgId,content, from_unixtime(createTime/1000) from message
where content like '%吃什么%'

select msgId,content, from_unixtime(createTime/1000) from message
where content like '%晚安%'

select count(msgId) from message
where content like '%晚安%'

select msgId,content, from_unixtime(createTime/1000) from message
where content like '%哈%'

select count(1) from message
where content like '%哈%'

-- 按月分组
select count(msgId), date_format(from_unixtime(createTime/1000),"%m") as m from message
group by m

-- 按小时分组
select count(msgId), date_format(from_unixtime(createTime/1000),"%H") as m from message 
group by m

-- 统计消息数
select count(msgId) from message ;

-- 统计语音
select count(msgId) from message where type = 34 ;
-- 统计电话
select count(msgId) from message where type = 50 ;

-- 统计图片
select count(msgId) from message where type = 3;

-- 最长的一句话
SELECT content,length( content ),from_unixtime(createTime/1000)
FROM
	message 
WHERE
	length( content ) = ( SELECT max( length( content ) ) FROM message WHERE AND type = 1) 
	AND type = 1 
	
-- 词导出
SELECT content  INTO OUTFILE 'D:\\Users\\gwjwi\\Desktop\\wechat-explore-master\\dasad.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM message where type = 1;
