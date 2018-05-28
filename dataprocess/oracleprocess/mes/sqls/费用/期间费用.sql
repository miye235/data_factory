SELECT 
date_month,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='運輸費' then amount_RMB else 0 end) XS_YSF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='差旅費' then amount_RMB else 0 end) XS_CLF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='勞務費' then amount_RMB else 0 end) XS_LWF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='職工薪酬-工資' then amount_RMB else 0 end) XS_ZG_GZ,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='職工薪酬-福利費' then amount_RMB else 0 end) XS_ZG_FLF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='職工薪酬-社會保險費' then amount_RMB else 0 end) XS_ZG_SBF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='檢驗測試費' then amount_RMB else 0 end) XS_JCF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='修理費' then amount_RMB else 0 end) XS_XLF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='廣告費' then amount_RMB else 0 end) XS_GGF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='其他費用' then amount_RMB else 0 end) XS_QTF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='文具用品' then amount_RMB else 0 end) XS_WJF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='郵電費' then amount_RMB else 0 end) XS_YDF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='動力費' then amount_RMB else 0 end) XS_DLF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='交際費' then amount_RMB else 0 end) XS_JJF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='折舊' then amount_RMB else 0 end) XS_ZJF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='伙食費' then amount_RMB else 0 end) XS_HSF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='職工福利' then amount_RMB else 0 end) XS_ZGFLF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='訓練費' then amount_RMB else 0 end) XS_XLF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='保全費' then amount_RMB else 0 end) XS_BQF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='什項購置' then amount_RMB else 0 end) XS_SXGZF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='進口費用' then amount_RMB else 0 end) XS_JKF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='租金支出' then amount_RMB else 0 end) XS_ZJF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='保固費用' then amount_RMB else 0 end) XS_BGF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='交通費' then amount_RMB else 0 end) XS_JTF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='出口費用' then amount_RMB else 0 end) XS_CKF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='間接材料' then amount_RMB else 0 end) XS_JJF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='殘保金' then amount_RMB else 0 end) XS_CBJ,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='會議費' then amount_RMB else 0 end) XS_HYF,
sum(case when Expense_Attr_Desc='销售费用' and Main_Acct_Desc='保險費（資產）' then amount_RMB else 0 end) XS_ZC_BXF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='職工薪酬-工資' then amount_RMB else 0 end) GL_ZGXC_GZ,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='職工薪酬-福利費' then amount_RMB else 0 end) GL_ZGXC_FLF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='職工薪酬-社會保險費' then amount_RMB else 0 end) GL_ZGXC_SHBXF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='折舊費' then amount_RMB else 0 end) GL_ZJF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='修理費' then amount_RMB else 0 end) GL_XLF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='文具用品' then amount_RMB else 0 end) GL_WJYP,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='差旅費' then amount_RMB else 0 end) GL_CLF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='勞務費' then amount_RMB else 0 end) GL_LWF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='動力費' then amount_RMB else 0 end)GL_DLF ,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='交通費' then amount_RMB else 0 end) GL_JTF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='郵電費' then amount_RMB else 0 end) GL_DDF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='租金支出' then amount_RMB else 0 end) GL_ZJZC,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='物料消耗' then amount_RMB else 0 end) GL_WLXH,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='存貨盤虧（毀損報廢）' then amount_RMB else 0 end) GL_CHPD,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='環境保潔綠化費' then amount_RMB else 0 end) GL_HJBJ,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='殘疾人保障金' then amount_RMB else 0 end) GL_CJR,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='培訓費' then amount_RMB else 0 end) GL_PXF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='其他' then amount_RMB else 0 end) GL_QT,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='廣告費' then amount_RMB else 0 end) GL_GGF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='交際費' then amount_RMB else 0 end) GL_JJF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='稅捐' then amount_RMB else 0 end) GL_SJ,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='各項攤提' then amount_RMB else 0 end) GL_GX,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='伙食費' then amount_RMB else 0 end) GL_HSF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='職工福利' then amount_RMB else 0 end) GL_ZGFL,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='保全費' then amount_RMB else 0 end) GL_BQF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='包裝費' then amount_RMB else 0 end) GL_BZF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='檢測費' then amount_RMB else 0 end) GL_JCF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='什項購置' then amount_RMB else 0 end) GL_SXZZ,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='外包人力' then amount_RMB else 0 end) GL_WBRL,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='間接材料' then amount_RMB else 0 end) GL_JJCL,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='研究發展費' then amount_RMB else 0 end) GL_YJFZF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='進口費用' then amount_RMB else 0 end) GL_JKFY,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='書報雜誌' then amount_RMB else 0 end) GL_SBZZ,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='權利金' then amount_RMB else 0 end) GL_QLJ,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='佣金支出' then amount_RMB else 0 end) GL_YJZC,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='保險費（資產）' then amount_RMB else 0 end) GL_BXF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='殘保金' then amount_RMB else 0 end) GL_CBJ,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='出口費用' then amount_RMB else 0 end) GL_CKF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='會議費' then amount_RMB else 0 end) GL_HYF,
sum(case when Expense_Attr_Desc='管理费用' and Main_Acct_Desc='運費' then amount_RMB else 0 end) GL_YF,
sum(case when Expense_Attr_Desc='财务费用' and Main_Acct_Desc='利息收入' then amount_RMB else 0 end) CW_LXSR,
sum(case when Expense_Attr_Desc='财务费用' and Main_Acct_Desc='貸款利息支出' then amount_RMB else 0 end) CW_DKLXZC,
sum(case when Expense_Attr_Desc='财务费用' and Main_Acct_Desc='金融機構手續費' then amount_RMB else 0 end) CW_JRJSXF,
sum(case when Expense_Attr_Desc='财务费用' and Main_Acct_Desc='匯兌損益' then amount_RMB else 0 end) CW_HDSY,
sum(case when Expense_Attr_Desc='财务费用' and Main_Acct_Desc='融資費用' then amount_RMB else 0 end) CW_RZFY,
sum(case when Expense_Attr_Desc='财务费用' and Main_Acct_Desc='貼現利息支出' then amount_RMB else 0 end) CW_TXLXZC,
sum(case when Expense_Attr_Desc='财务费用' and Main_Acct_Desc='融資租賃利息支出' then amount_RMB else 0 end) CW_RZZLLLZC,
sum(case when Expense_Attr_Desc='财务费用' and Main_Acct_Desc='利息支出資本化' then amount_RMB else 0 end) CW_LXZCZBH,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='職工薪酬-工資-直接' then amount_RMB else 0 end) ZZ_ZGXC_ZJ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='職工薪酬-社會保險費-直接' then amount_RMB else 0 end) ZZ_SHBX_ZJ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='伙食費-直接' then amount_RMB else 0 end) ZZ_HSF_ZJ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='外包人力（派遣）-直接' then amount_RMB else 0 end) ZZ_WBRL_ZJ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='職工薪酬-工資' then amount_RMB else 0 end) ZZ_ZGXC_GZ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='職工薪酬-工資-社會保險費' then amount_RMB else 0 end) ZZ_ZGXC_SB,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='文具用品' then amount_RMB else 0 end) ZZ_WJYP,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='旅費' then amount_RMB else 0 end) ZZ_LF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='運費' then amount_RMB else 0 end) ZZ_YF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='郵電費' then amount_RMB else 0 end) ZZ_DDF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='修繕費' then amount_RMB else 0 end) ZZ_XSF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='廣告費' then amount_RMB else 0 end) ZZ_GGF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='動力費' then amount_RMB else 0 end) ZZ_DLF ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='交際費' then amount_RMB else 0 end) ZZ_JJF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='折舊' then amount_RMB else 0 end)  ZZ_ZJ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='各項攤提' then amount_RMB else 0 end) ZZ_GXTT,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='權利金' then amount_RMB else 0 end) ZZ_QLJ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='伙食費' then amount_RMB else 0 end) ZZ_HSF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='職工福利' then amount_RMB else 0 end) ZZ_ZGFL,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='研究發展費' then amount_RMB else 0 end) ZZ_YJFZF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='訓練費' then amount_RMB else 0 end) ZZ_XLF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='保全費' then amount_RMB else 0 end) ZZ_BQF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='出口費用' then amount_RMB else 0 end) ZZ_CKFY,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='加工費' then amount_RMB else 0 end) ZZ_JGF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='包裝費' then amount_RMB else 0 end) ZZ_BZF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='間接材料' then amount_RMB else 0 end) ZZ_JJCL,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='檢測費' then amount_RMB else 0 end) ZZ_JCF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='保險費（資產）' then amount_RMB else 0 end) ZZ_BXF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='什項購置' then amount_RMB else 0 end) ZZ_SXZZ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='書報雜誌' then amount_RMB else 0 end) ZZ_SBZZ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='勞務費' then amount_RMB else 0 end) ZZ_LWF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='進口費用' then amount_RMB else 0 end) ZZ_JKFY,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='會議費' then amount_RMB else 0 end) ZZ_HYF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='租金支出' then amount_RMB else 0 end) ZZ_ZJZC,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='殘保金' then amount_RMB else 0 end) ZZ_CBJ,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='外包人力（派遣）' then amount_RMB else 0 end) ZZ_WBRL,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='交通費' then amount_RMB else 0 end) ZZ_JTF,
sum(case when Expense_Attr_Desc='制造费用' and Main_Acct_Desc='其他費用' then amount_RMB else 0 end) ZZ_QTFY
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
where 
GROUP BY date_month
