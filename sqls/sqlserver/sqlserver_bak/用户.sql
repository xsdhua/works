----四、平台用户规模---

----期末数（2018年2月28日）

select top 10 * from member

---个人
select COUNT(*) from member where date_created<'2018-3-1 00:0:00' and is_admin='0' and id not in (select member_id from enterprise_info )

select COUNT(*) from member where date_created<'2017-3-1 00:0:00' and is_admin='0' and id not in (select member_id from enterprise_info )

-- 个人明细
select id,date_created
from member 
where date_created<'2018-3-1 00:0:00' 
and is_deleted=0
and is_admin='0' and id not in (select member_id from enterprise_info )


---企业
select COUNT(*) from member where date_created<'2018-3-1 00:0:00' and is_admin='0' and id  in (select member_id from enterprise_info )


-- 企业明细
select id,date_created
from member 
where date_created<'2018-3-1 00:0:00' 
and is_deleted=0
and is_admin='0' and id in (select member_id from enterprise_info )


--活跃用户（最近3月内有交易）数

--个人
select count(distinct investor_id) from borrow_invest where date_created>='2017-12-1 00:00:00' and date_created<'2018-3-1 00:0:00' and investor_id in (select id from member where date_created<'2018-3-1 00:0:00' and is_admin='0' and id not in (select member_id from enterprise_info ))
--企业
select count(distinct investor_id) from borrow_invest where date_created>='2017-12-1 00:00:00' and date_created<'2018-3-1 00:0:00' and investor_id in (select id from member where date_created<'2018-3-1 00:0:00' and is_admin='0' and id  in (select member_id from enterprise_info ))

----当前有交易余额的借款人数
--总的--606
select count(distinct loaner_id) from borrow where id in (
	
		select distinct borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
	union all
select distinct borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)

--企业
select count(distinct member_id) from enterprise_info where member_id not in (
select distinct loaner_id from borrow where id in (
	
		select distinct borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
	union all
select distinct borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)

)

select count(distinct loaner_id) from borrow where id in (
	
		select distinct borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
	union all
select distinct borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
) and loaner_id in (select member_id from enterprise_info)


select count(distinct member_id) from enterprise_info where member_id in (

		select distinct loaner_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
) or member_id in (select distinct loaner_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' )



select count(distinct r.loaner_id) from (select distinct loaner_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
	union all
select distinct loaner_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' ) r where r.loaner_id in (select member_id from enterprise_info)

----------------上年同期数（2017年2月28日）----------


---个人
select COUNT(*) from member where date_created<'2017-3-1 00:0:00' and is_admin='0' and id not in (select member_id from enterprise_info )


---企业
select COUNT(*) from member where date_created<'2017-3-1 00:0:00' and is_admin='0' and id  in (select member_id from enterprise_info )

--活跃用户（最近3月内有交易）数

--个人
select count(distinct investor_id) from borrow_invest where date_created>='2016-12-1 00:00:00' and date_created<'2017-3-1 00:0:00' and investor_id in (select id from member where date_created<'2017-3-1 00:0:00' and is_admin='0' and id not in (select member_id from enterprise_info ))
--企业
select count(distinct investor_id) from borrow_invest where date_created>='2016-12-1 00:00:00' and date_created<'2017-3-1 00:0:00' and investor_id in (select id from member where date_created<'2017-3-1 00:0:00' and is_admin='0' and id  in (select member_id from enterprise_info ))

----当前有交易余额的借款人数
--总的-438
select count(distinct loaner_id) from borrow where id in (
	
		select borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
	union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
)

--企业
select count(distinct r.loaner_id) from (select distinct loaner_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
	union all
select distinct loaner_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' ) r where r.loaner_id in (select member_id from enterprise_info)


---------------注意如果净值标算个人,结构算机构------------------------

select COUNT(*) from member where date_created<'2018-3-1 00:0:00' and is_admin='0' and id not in (select distinct loaner_id from borrow where full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and category !='worth' )

select COUNT(*) from member where date_created<'2018-3-1 00:0:00' and is_admin='0' and id  in (select distinct loaner_id from borrow where full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and category !='worth' )


select count(distinct r.loaner_id) from (select distinct loaner_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
	union all
select distinct loaner_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' ) r where r.loaner_id in (select distinct loaner_id from borrow where full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and category !='worth')


select count(distinct r.loaner_id) from (select distinct loaner_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
	union all
select distinct loaner_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' ) r where r.loaner_id in (select distinct loaner_id from borrow where full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and category ='worth')


--2017
select COUNT(*) from member where date_created<'2017-3-1 00:0:00' and is_admin='0' and id not in (select distinct loaner_id from borrow where full_time <'2017-3-1 00:00:00' and status in (4,5,6)   and category !='worth' )

select COUNT(*) from member where date_created<'2017-3-1 00:0:00' and is_admin='0' and id  in (select distinct loaner_id from borrow where full_time <'2017-3-1 00:00:00' and status in (4,5,6)   and category !='worth' )

select count(distinct r.loaner_id) from (select distinct loaner_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
	union all
select distinct loaner_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' ) r where r.loaner_id in (select distinct loaner_id from borrow where full_time <'2017-3-1 00:00:00' and status in (4,5,6)   and category !='worth')


select count(distinct r.loaner_id) from (select distinct loaner_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
	union all
select distinct loaner_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' ) r where r.loaner_id in (select distinct loaner_id from borrow where full_time <'2017-3-1 00:00:00' and status in (4,5,6)   and category ='worth')



----------------平台累计撮合借贷交易规模（报告日：2018年2月28日）------------------------------

--累计撮合成交借款项目总金额（不含平台撮合形成债权的内部转让交易）--雪银票：1633564.00

select sum(capital) as bTotal_capital,sum(capital)+22540200+242315971.90+1633564.00 from borrow_invest where activate_time is not null and activate_time<'2018-3-1 00:00:00' and borrow_id in (select id from borrow where status in (4,5,6))

---累计撮合成交借款项目总笔数

select count(distinct borrow_id) from borrow_invest where activate_time is not null and activate_time<'2018-3-1 00:00:00' and borrow_id in (select id from borrow where status in (4,5,6))

--个人每笔平均借款金额(净值标/净值标人数)

select SUM(amount),COUNT(distinct loaner_id),SUM(amount)/COUNT(distinct loaner_id) from borrow where category='worth' and full_time<'2018-3-1 00:00:00' and status in (4,5,6)


--机构每笔平均借款金额

select SUM(amount),COUNT(distinct loaner_id),SUM(amount)/COUNT(distinct loaner_id) from borrow where category !='worth' and full_time<'2018-3-1 00:00:00' and status in (4,5,6)


----------------------平台撮合交易的未偿还借款情况--------------------------------------

------------期末数（2018年2月28日）------------------

-----平台撮合的未偿还借款本金余额--

select ac,bc,(ac+bc) from (

 select '1' as aid,SUM(capital) ac from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
) b on a.aid = b.aid
----未偿还借款余额对应借款笔数

select COUNT(distinct r.borrow_id) from (
 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
) r

-----个人每笔平均借款余额(净值标)



select SUM(amount),COUNT(distinct loaner_id),SUM(amount)/COUNT(distinct loaner_id) from borrow where category='worth' and full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)

----机构每笔平均借款余额(不是净值标)


select SUM(amount),COUNT(distinct loaner_id),SUM(amount)/COUNT(distinct loaner_id) from borrow where category !='worth' and full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)


------未偿还借款平均借款期限（未偿还借款项目总期限/对应借款项目笔数）

--天
select sum(cycle),count(*) from borrow where cycle_type='1' and full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)
---月
select sum(cycle),count(distinct id),sum(cycle)/count(distinct id) from borrow where cycle_type='2' and full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)


----未偿还借款平均出借金额（未偿还借款项目总金额/对应借款项目总出借人数，出借人数不剔除重复出现者）



select SUM(amount),COUNT(distinct loaner_id),COUNT( loaner_id),SUM(amount)/COUNT(loaner_id) from borrow where  full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)


---------上年同期数（2017年2月28日）



-----平台撮合的未偿还借款本金余额--

select ac,bc,(ac+bc) from (

 select '1' as aid,SUM(capital) ac from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
) b on a.aid = b.aid
----未偿还借款余额对应借款笔数

select COUNT(distinct r.borrow_id) from (
 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
) r

-----个人每笔平均借款余额(净值标)



select SUM(amount),COUNT(distinct loaner_id),SUM(amount)/COUNT(distinct loaner_id) from borrow where category='worth' and full_time<'2017-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
)

----机构每笔平均借款余额(不是净值标)


select SUM(amount),COUNT(distinct loaner_id),SUM(amount)/COUNT(distinct loaner_id) from borrow where category !='worth' and full_time<'2017-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
)


------未偿还借款平均借款期限（未偿还借款项目总期限/对应借款项目笔数）

--天
select sum(cycle),count(*) from borrow where cycle_type='1' and full_time<'2017-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
)
---月
select sum(cycle*30),count(*) from borrow where cycle_type='2' and full_time<'2017-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
)


----未偿还借款平均出借金额（未偿还借款项目总金额/对应借款项目总出借人数，出借人数不剔除重复出现者）



select SUM(amount),COUNT(distinct loaner_id),COUNT( loaner_id),SUM(amount)/COUNT(loaner_id) from borrow where  full_time<'2017-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
)



-------------七、平台借款成本、出借回报及费用收取情况


----平台借款成本情况（报告日：2018年2月28日）

--平台撮合交易未偿还借款项目的最高利率和平台撮合交易未偿还借款项目的最低利率
select max(rate),MIN(rate) from borrow where  full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)


-----平台撮合交易未偿还借款项目的平均利率（未偿还借款项目利率之和/对应借款项目笔数）


select SUM(rate),COUNT(*),SUM(rate)/COUNT(*) from borrow where  full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)


-------平台撮合交易未偿还借款项目的最低年化综合资金成本率:(信用标:利率+管理费最小的)



select MIN(rate+loaner_fee_total) from borrow where category='transfer' and  full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)





--平台借款人最近一年度实际支付的利息、罚息总金额（含本金中预先扣除部分）：利息+逾期费
select SUM(interest+fact_receipt_fee) from receipt_detail where status in (4) and receipt_time>='2017-3-1 00:00:00'  and receipt_time<'2018-3-1 00:00:00'

----平台借款人最近一年度实际向平台及其合作方支付的各类费用总金额（含本金中预先扣除部分）:借款管理费
select sum(loaner_total) from borrow where id in (select borrow_id from receipt_detail where status in (4) and receipt_time>='2017-3-1 00:00:00'  and receipt_time<'2018-3-1 00:00:00')




------------（二）平台出借回报情况（报告日：2018年2月28日）


----平台撮合交易未偿还借款项目出借人的平均约定年化收益率（未收回借款的收益率之和/对应借款笔数）




select sum(rate),COUNT(*),sum(rate)/COUNT(*) from borrow where  full_time<'2018-3-1 00:00:00' and status in (4,5,6) and id in (

 select  borrow_id from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
union all
select borrow_id  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
)



-----------八、平台前十大客户借款情况

---2018年2月28的未偿还本金总额：


select ac,bc,(ac+bc) from (

 select '1' as aid,SUM(capital) ac from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
) b on a.aid = b.aid


---2017年2月28的未偿还本金总额：

select ac,bc,(ac+bc) from (

 select '1' as aid,SUM(capital) ac from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2017-3-1 00:00:00') and receipt_time>='2017-3-1 00:00:00' 
) b on a.aid = b.aid




---------------（四）借款按到期日分布情况（报告日：2018年2月28日）


---总的借款本金

select SUM(amount) from borrow where status in (4,5,6) and full_time<'2018-3-1 00:00:00'


select SUM(amount) from borrow where status in (4,5,6) and full_time<'2018-3-1 00:00:00' and is_display='1'

select SUM(trade_out) from borrow where status in (4,5,6) and full_time<'2018-3-1 00:00:00' and is_display='1'

---1个月以内到期（含1个月）

--天
select sum(amount)from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='30'
--月
select sum(amount) from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='1'




select a.ac,b.bc,(a.ac+b.bc) from (
	select '1' as aid, case  when SUM(amount) is null then 0 else SUM(amount) end ac from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='30'
) a left join (
	select '1' as aid,case  when SUM(amount) is null then 0 else SUM(amount) end bc from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='1'
) b on a.aid = b.aid


--标号--

select r.id from  (

select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='30'
union all 
select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='1'
) r



---------------------------------------------------------------------------





select ac,bc,(ac+bc) from (

 select '1' as aid,SUM(capital) ac from receipt_detail where status in (1,2,3)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (select id from borrow where full_time<'2018-3-1 00:00:00') and receipt_time>='2018-3-1 00:00:00' 
) b on a.aid = b.aid





----1~3个月以内到期（含3个月）


select a.ac,b.bc,(a.ac+b.bc) from (
	select '1' as aid, case  when SUM(amount) is null then 0 else SUM(amount) end ac from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='90' and cycle>'30'
) a left join (
	select '1' as aid,case  when SUM(amount) is null then 0 else SUM(amount) end bc from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='3' and cycle>'1'
) b on a.aid = b.aid

---3个月以内到期（含6个月）

select a.ac,b.bc,(a.ac+b.bc) from (
	select '1' as aid, case  when SUM(amount) is null then 0 else SUM(amount) end ac from borrow where  cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='180' and cycle>'90'
) a left join (
	select '1' as aid,case  when SUM(amount) is null then 0 else SUM(amount) end bc from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='6' and cycle>'3'
) b on a.aid = b.aid
----6个月以内到期（含12个月）

select a.ac,b.bc,(a.ac+b.bc) from (
	select '1' as aid, case  when SUM(amount) is null then 0 else SUM(amount) end ac from borrow where  cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='365' and cycle>'180'
) a left join (
	select '1' as aid,case  when SUM(amount) is null then 0 else SUM(amount) end bc from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='12' and cycle>'6'
) b on a.aid = b.aid
----1~2年（含2年）到期


select a.ac,b.bc,(a.ac+b.bc) from (
	select '1' as aid, case  when SUM(amount) is null then 0 else SUM(amount) end ac from borrow where  cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='730' and cycle>'365'
) a left join (
	select '1' as aid,case  when SUM(amount) is null then 0 else SUM(amount) end bc from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='24' and cycle>'12'
) b on a.aid = b.aid



select id,cycle,case status when '4' then '满标' when '5' then '还款中' when '6' then '完成' end  '状态'  from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='24' and cycle>'12'
----2~3年（含3年）到期


select a.ac,b.bc,(a.ac+b.bc) from (
	select '1' as aid, case  when SUM(amount) is null then 0 else SUM(amount) end ac from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='1095' and cycle>'730'
) a left join (
	select '1' as aid,case  when SUM(amount) is null then 0 else SUM(amount) end bc from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='36' and cycle>'24'
) b on a.aid = b.aid

---3年以上到期



select a.ac,b.bc,(a.ac+b.bc) from (
	select '1' as aid, case  when SUM(amount) is null then 0 else SUM(amount) end ac from borrow where  cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle>'1095'
) a left join (
	select '1' as aid,case  when SUM(amount) is null then 0 else SUM(amount) end bc from borrow where  cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and  cycle>'36'
) b on a.aid = b.aid


-----------------------------------------

-----1个月以内到期（含1个月）

select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (2)  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='30'
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='1'
			) r

) and need_receipt_time>='2018-3-1 00:00:00' 
) b on a.aid = b.aid





----1~3个月以内到期（含3个月）
select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,2,3)  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='90' and cycle>'30'
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='3' and cycle>'1'
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='90' and cycle>'30'
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='3' and cycle>'1'
			) r

) and need_receipt_time>='2018-3-1 00:00:00' 
) b on a.aid = b.aid


---3个月以内到期（含6个月）

select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,2,3)  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and cycle<='180' and cycle>'90'
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='6' and cycle>'3'
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and  cycle<='180' and cycle>'90'
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='6' and cycle>'3'
			) r

) and need_receipt_time>='2018-3-1 00:00:00' 
) b on a.aid = b.aid


----6个月以内到期（含12个月）

select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,2,3)  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and cycle<='360' and cycle>'180'
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='12' and cycle>'6'
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and cycle<='360' and cycle>'180'
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and cycle<='12' and cycle>'6'
			) r

) and need_receipt_time>='2018-3-1 00:00:00' 
) b on a.aid = b.aid

----1~2年（含2年）到期


select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,2,3)  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and cycle<='730' and cycle>'365'
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  and cycle<='24' and cycle>'12'
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and cycle<='730' and cycle>'365'
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)   and cycle<='24' and cycle>'12'
			) r

) and need_receipt_time>='2018-3-1 00:00:00' 
) b on a.aid = b.aid


--------------十一、平台最近三个月撮合交易的满标时间情况

select * from borrow where  full_time>='2018-2-1 00:00:00' and full_time<'2018-3-1 00:00:00'


select * from borrow where id='12733'


select full_time,fund_deadline,dateadd(day,-7,fund_deadline),DATEDIFF(hour,full_time,fund_deadline),DATEDIFF(hour,dateadd(day,-7,fund_deadline),full_time) from borrow where id='12733'

---（2018年2月
select sum(DATEDIFF(hour,dateadd(day,-7,fund_deadline),full_time)),count(*),sum(DATEDIFF(hour,dateadd(day,-7,fund_deadline),full_time))/count(*) from borrow where  full_time>='2018-2-1 00:00:00' and full_time<'2018-3-1 00:00:00' and status in (4,5,6)
---（2018年1月
select sum(DATEDIFF(hour,dateadd(day,-7,fund_deadline),full_time)),count(*),sum(DATEDIFF(hour,dateadd(day,-7,fund_deadline),full_time))/count(*) from borrow where  full_time>='2018-1-1 00:00:00' and full_time<'2018-2-1 00:00:00' and status in (4,5,6)

---2017年12月

select sum(DATEDIFF(hour,dateadd(day,-7,fund_deadline),full_time)),count(*),sum(DATEDIFF(hour,dateadd(day,-7,fund_deadline),full_time))/count(*) from borrow where  full_time>='2017-12-1 00:00:00' and full_time<'2018-1-1 00:00:00' and status in (4,5,6)





-----1个月以内到期（含1个月）

select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,3) and  need_receipt_time>='2018-3-1 00:00:00' and need_receipt_time<'2018-4-1 00:00:00'  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
			) r

) and need_receipt_time>='2018-3-1 00:00:00'   and need_receipt_time<'2018-4-1 00:00:00' 
) b on a.aid = b.aid








----1~3个月以内到期（含3个月）

select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,3) and  need_receipt_time>='2018-4-1 00:00:00' and need_receipt_time<'2018-7-1 00:00:00'  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
			) r

) and need_receipt_time>='2018-4-1 00:00:00'   and need_receipt_time<'2018-7-1 00:00:00' 
) b on a.aid = b.aid

---3个月以内到期（含6个月）
select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,3) and  need_receipt_time>='2018-7-1 00:00:00' and need_receipt_time<'2018-10-1 00:00:00'  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
			) r

) and need_receipt_time>='2018-7-1 00:00:00'   and need_receipt_time<'2018-10-1 00:00:00' 
) b on a.aid = b.aid

----6个月以内到期（含12个月）
select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,3) and  need_receipt_time>='2018-10-1 00:00:00' and need_receipt_time<'2019-4-1 00:00:00'  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
			) r

) and need_receipt_time>='2018-10-1 00:00:00'   and need_receipt_time<'2019-4-1 00:00:00' 
) b on a.aid = b.aid


----1~2年（含2年）到期


select ac,bc,(ac+bc) from (

 select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end ac from receipt_detail where status in (1,3) and  need_receipt_time>='2019-4-1 00:00:00' and need_receipt_time<'2020-9-1 00:00:00'  and borrow_id in (
 
		 select r.id from  (

		select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
		union all 
		select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
		) r

 ) 
) a left join (
select '1' as aid,case  when SUM(capital) is null then 0 else SUM(capital) end bc  from receipt_detail where status in (4)  and borrow_id in (
			select r.id from  (

			select id from borrow where cycle_type='1' and full_time <'2018-3-1 00:00:00' and status in (4,5,6)  
			union all 
			select id from borrow where cycle_type='2' and full_time <'2018-3-1 00:00:00' and status in (4,5,6) 
			) r

) and need_receipt_time>='2019-4-1 00:00:00'   and need_receipt_time<'2020-9-1 00:00:00' 
) b on a.aid = b.aid