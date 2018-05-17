#!/usr/bin/python
# -*- coding: UTF-8 -*-


from dataprocess.oracleprocess.erp.app.accounts_payable \
    import AccountsPayable
from dataprocess.oracleprocess.erp.app.accounts_payable_aging \
    import AccountsPayableAging
from dataprocess.oracleprocess.erp.app.accounts_receivable \
    import AccountsReceivable
from dataprocess.oracleprocess.erp.app.amount_of_temporary_assessment_payable \
    import AmountOfTemporaryAssessmentPayable
from dataprocess.oracleprocess.erp.app.construction_in_progress \
    import ConstructionInProgress
from dataprocess.oracleprocess.erp.app.expenses_for_the_period \
    import ExpensesForThePeriod
from dataprocess.oracleprocess.erp.app.inventory_details_interim_inventory \
    import InventoryDetailsInterimInventory
from dataprocess.oracleprocess.erp.app.inventory_details_into_the_consumption \
    import InventoryDetailsIntoTheConsumption
from dataprocess.oracleprocess.erp.app.inventory_details_inventory_name \
    import InventoryDetailsInventoryName
from dataprocess.oracleprocess.erp.app.inventory_details_work_in_progress \
    import InventoryDetailsWorkInProgress
from dataprocess.oracleprocess.erp.app.main_business_cost \
    import MainBusinessCost
from dataprocess.oracleprocess.erp.app.main_business_income \
    import MainBusinessIncome


################
#  test
################


def show_df(df, line=10):
    for c in df.columns:
        print(c, end=" ")
    print(end="\n")
    for index in df.index:
        l = df.loc[index].values[0: -1]
        for i in l:
            print(i, end=" ")
        print("\n")
        if index > line:
            break
    print("\n")


def main():
    m = AccountsPayable()
    df = m()
    show_df(df)


if __name__ == "__main__":
    main()
