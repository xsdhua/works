use xueshandai

select sum(should_repay_balance) as should_repay_balance
from repayment_detail a 
inner join borrow b on a.borrow_id = b.id 
where need_repayment_time>='2018-08-23' and need_repayment_time<'2018-10-01'
and a.status in (1,3)
and b.category !='worth'

133043148.03



select a.id
,a.borrow_id 标号
,a.member_id 借款人id
,m.real_name 真实姓名
,m.uname 用户名1
,m.username 用户名2
,a.issue 第几期
,need_repayment_time 预计还款时间
,case when a.status =1 then '待还款' when a.status=2 then '逾期' when a.status =4 then '已还款' end as 状态
,(should_repay_balance+should_repay_fee-fact_repay_balance-fact_repay_fee) 借款人需还金额
,should_receipt_amount 投资人收款金额
,case when (should_repay_balance+should_repay_fee-fact_repay_balance-fact_repay_fee)>=should_receipt_amount 
  then (should_repay_balance+should_repay_fee-fact_repay_balance-fact_repay_fee) else should_receipt_amount end as 较大金额
,(should_receipt_amount-(should_repay_balance+should_repay_fee-fact_repay_balance-fact_repay_fee)) 差额
,fact_repay_balance+fact_repay_fee  借款人实还金额
,b.cycle_type 标类型
,b.cycle 标总期数
,a.capital
,a.interest
,a.status as status_repayment
,b.status as status_borrow
from repayment_detail a 
inner join borrow b on a.borrow_id = b.id 
inner join member m on a.member_id = m.id
inner join (select borrow_id,issue,sum(should_receipt_balance+should_receipt_fee-fact_receipt_balance-fact_receipt_fee) as should_receipt_amount 
from receipt_detail 
where status in (1,3)
group by borrow_id,issue 
) rc on a.borrow_id=rc.borrow_id and a.issue = rc.issue
where a.is_be_overdue='0' and a.status in (1,3) and a.repay_process < 10  and a.displace_money = 0.0
and b.status in (4,5,6)
and b.category !='worth'
and need_repayment_time>='2018-08-23' and need_repayment_time<'2018-10-01'
order by need_repayment_time


-- 内投回款金额

DECLARE @begin_date varchar(10)
DECLARE @end_date varchar(10)
SET @begin_date = '2018-08-01'
SET @end_date = '2018-10-01'

select convert(varchar(10),need_receipt_time,120) as 回款日期
,sum(should_receipt_balance+should_receipt_fee-fact_receipt_balance-fact_receipt_fee) as 内投回款金额
from receipt_detail a 
inner join borrow b on a.borrow_id = b.id
left outer join member m on a.investor_id = m.id
left outer join (select * from xueshandai_a.dbo.member_tags where tagid=1) mi on a.investor_id=mi.member_id
where  a.status =1
and b.status in (4,5,6)
and need_receipt_time>=@begin_date and need_receipt_time<@end_date
and mi.member_id is not null
group by convert(varchar(10),need_receipt_time,120)
order by 回款日期




/* from 蔡华卫


select r.标号,b.loaner_id '借款人ID',m.real_name '真实姓名',m.uname '用户名',m.username '用户名'
,r.期数,p.need_repayment_time '预计还款时间',r.借款人需要还款金额,r.投资人收款金额,r.差额 
from member m,borrow b,(
		select a.borrow_id '标号',a.issue '期数',a.h '借款人需要还款金额',b.s '投资人收款金额',(b.s-a.h) '差额' from (
			select borrow_id,issue,sum(should_repay_balance+should_repay_fee-fact_repay_balance-fact_repay_fee) h 
			  from repayment_detail 
			  where is_be_overdue='0' and status in (1,3) 
			    and  need_repayment_time>= '2018-3-23 00:00:00.000' and need_repayment_time <='2018-04-22 23:59:59.999' 
				and  repay_process < 10  and displace_money = 0.0  
			  group by borrow_id,issue
		) a,(
			select borrow_id,issue,SUM(should_receipt_balance+should_receipt_fee-fact_receipt_balance-fact_receipt_fee) s 
			from receipt_detail where need_receipt_time>= '2018-3-23 00:00:00.000' and need_receipt_time<='2018-04-22 23:59:59.999' 
			and status in (1,3)  
			group by borrow_id,issue 
		) b where a.borrow_id= b.borrow_id and a.issue= b.issue 

) r,(select borrow_id,issue,need_repayment_time from repayment_detail where is_be_overdue='0' and status in (1,3) 
and  need_repayment_time>= '2018-3-23 00:00:00.000' and need_repayment_time <='2018-04-22 23:59:59.999' 
and  repay_process < 10  and displace_money = 0.0  ) p

where m.id= b.loaner_id and b.id = r.标号 and p.borrow_id = r.标号 and r.期数 = p.issue and  b.category !='worth' order by p.need_repayment_time
*/



