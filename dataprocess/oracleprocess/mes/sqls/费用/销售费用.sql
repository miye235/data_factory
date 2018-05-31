SELECT
date_month 日期,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='薪資支出' then amount_RMB else 0 end) 工资,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='職工福利' then amount_RMB else 0 end) 福利,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='保險費-人事' then amount_RMB else 0 end) 保險費_人事,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='住房公積金' then amount_RMB else 0 end) 住房公積金,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='工會經費' then amount_RMB else 0 end) 工會經費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='職工教育經費' then amount_RMB else 0 end) 職工教育經費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='股份支付' then amount_RMB else 0 end) 股份支付,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='職工薪酬其他' then amount_RMB else 0 end) 職工薪酬其他,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='文具用品' then amount_RMB else 0 end) 文具用品,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='旅費' then amount_RMB else 0 end) 旅費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='運費' then amount_RMB else 0 end) 運費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='郵電費' then amount_RMB else 0 end) 郵電費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='修繕費' then amount_RMB else 0 end) 修繕費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='廣告費' then amount_RMB else 0 end) 廣告費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='動力費' then amount_RMB else 0 end) 動力費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='交際費' then amount_RMB else 0 end) 交際費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='折舊' then amount_RMB else 0 end) 折舊,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='各項攤提' then amount_RMB else 0 end) 各項攤提,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='權力費' then amount_RMB else 0 end) 權力費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='職工福利' then amount_RMB else 0 end) 職工福利,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='研究發展費' then amount_RMB else 0 end) 研究發展費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='訓練費' then amount_RMB else 0 end) 訓練費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='保全費' then amount_RMB else 0 end) 保全費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='出口費用' then amount_RMB else 0 end) 出口費用,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='加工費' then amount_RMB else 0 end) 加工費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='包裝費' then amount_RMB else 0 end) 包裝費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='間接材料' then amount_RMB else 0 end) 間接材料,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='檢測費' then amount_RMB else 0 end) 檢測費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='什項購置' then amount_RMB else 0 end) 什項購置,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='書報雜誌' then amount_RMB else 0 end) 書報雜誌,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='勞務費' then amount_RMB else 0 end) 勞務費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='進口費用' then amount_RMB else 0 end) 進口費用,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='會議費' then amount_RMB else 0 end) 會議費,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='租金支出' then amount_RMB else 0 end) 租金支出,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='残保金' then amount_RMB else 0 end) 残保金,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='外包人力(派遣)' then amount_RMB else 0 end) 外包人力派遣,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='交通费' then amount_RMB else 0 end) 交通费,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='其他費用' then amount_RMB else 0 end) 其他費用
FROM (SELECT
o271918.COMPANY_ACCT,
TO_CHAR(o271918.EFFECTIVE_DATE,'yyyymm') as date_month,
o271918.EFFECTIVE_DATE,o271918.VOUCHER_NUMBER,o271918.CURRENCY,
o271918.SOURCE,o271918.EXPENSE_ATTR_DESC as Expense_Attr_Desc,
o271918.DEPT_ACCT,o271918.DEPT_ACCT_DESC,
o271918.MAIN_ACCT,o271918.MAIN_ACCT_DESC as Main_Acct_Desc,
o271918.SUB_ACCT,o271918.SUB_ACCT_DESC,
NVL(o271918.ACCOUNTED_DR,0)-NVL(o271918.ACCOUNTED_CR,0) as amount_org,
NVL(o271918.ACCOUNTED_DR,0)-NVL(o271918.ACCOUNTED_CR,0) as amount_RMB,
o271918.LINE_DESCRIPTION,
o271918.JOURNAL_DESC,
o271918.CURRENCY_CONVERSION_RATE
FROM (
    select gjh.je_source Source
        ,gjh.period_name
        ,gjh.name Journal_Name
        ,gjh.currency_code Currency
        ,gjh.default_effective_date Effective_Date
        ,gjh.creation_date
        ,gjh.description Journal_Desc
        ,(case  when gjcl.USER_JE_CATEGORY_NAME in ( 'Purchase Invoices','Payments',                  'Sales Invoices','Credit Memos') then gjl.subledger_doc_sequence_value
        else
        gjh.doc_sequence_value end) Voucher_Number
        ,gjcl.USER_JE_CATEGORY_NAME gl_category
        ,gcc.account_type
        ,gcc.segment1   company_acct
        ,asr.parent_flex_value expense_attr
        ,asr.parent_flex_Desc expense_attr_desc
        ,gcc.segment2   dept_acct
        ,gcc.segment3   main_acct
        ,gcc.segment4   sub_acct
        ,gcc.segment5   project_acct
        ,gcc.segment1||'.'||gcc.segment2||'.'||gcc.segment3||'.'||gcc.segment4||'.'||gcc.segment5||'.'||gcc.segment6||'.'||gcc.segment7 acct_no
        ,gjh.currency_conversion_rate
        ,gjh.currency_conversion_type
        ,gjl.je_line_num
        ,gjl.description line_description
        ,NVL(gjl.entered_dr,0) Entered_DR
        ,NVL(gjl.entered_cr,0) Entered_CR
        ,NVL(gjl.accounted_dr,0) Accounted_DR
        ,NVL(gjl.accounted_cr,0) Accounted_CR
        ,gjl.subledger_doc_sequence_value
        ,gjl.status
        ,gjl.ledger_id
        ,gjl.code_combination_id
        ,apps.ygl_info_pkg.get_acct_desc(gcc.chart_of_accounts_id,gcc.code_combination_id) acct_desc
        ,apps.ygl_info_pkg.get_segment_desc(gcc.chart_of_accounts_id,gcc.code_combination_id,2) dept_acct_desc
        ,apps.ygl_info_pkg.get_segment_desc(gcc.chart_of_accounts_id,gcc.code_combination_id,3) main_acct_desc
        ,apps.ygl_info_pkg.get_segment_desc(gcc.chart_of_accounts_id,gcc.code_combination_id,4) sub_acct_desc
        ,mag.parent_flex_value main_acct_grp_code
        ,mag.parent_flex_Desc  main_acct_grp_desc
        ,fu.user_name  created_by
        ,fu.description created_by_name
        ,fu1.user_name  posted_by
        ,fu1.description posted_by_name
    from apps.gl_je_headers gjh
        ,apps.gl_je_lines gjl
        ,apps.gl_code_combinations gcc
        ,apps.ygl_acct_segment_rollup_v asr
        ,apps.ygl_acct_segment_rollup_v mag
        ,apps.fnd_user fu
        ,apps.fnd_user fu1
        ,apps.GL_JE_CATEGORIES_TL  gjcl
    where gjh.je_header_id=gjl.je_header_id
        and gjl.code_combination_id=gcc.code_combination_id
        and gcc.chart_of_accounts_id = asr.id_flex_num(+)
        and gcc.segment2 = asr.child_flex_value(+)
        and asr.segment_num(+)=2
        and gcc.chart_of_accounts_id = mag.id_flex_num(+)
        and gcc.segment3 = mag.child_flex_value(+)
        and mag.segment_num(+) = 3
        and gjh.je_category not in ('Budget')
        and gjl.created_by = fu.user_id  and gjl.last_updated_by=fu1.user_id
        and gjh.je_category=gjcl.je_category_name
 ) o271918
WHERE (o271918.COMPANY_ACCT <> '11')
    AND (o271918.MAIN_ACCT BETWEEN '5410' AND '5579' AND o271918.MAIN_ACCT <> '5491')
ORDER BY o271918.EFFECTIVE_DATE ASC)
GROUP BY date_month