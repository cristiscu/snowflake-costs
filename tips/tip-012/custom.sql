USE SCHEMA employees.public;

DROP SNOWFLAKE.CORE.BUDGET IF EXISTS my_budget;
CREATE SNOWFLAKE.CORE.BUDGET my_budget();
CALL my_budget!SET_SPENDING_LIMIT(500);

CALL my_budget!SET_EMAIL_NOTIFICATIONS(
    'budgets_notif_integration',
    'email1@gmail.com, email2@gmail.com');
CALL my_budget!SET_NOTIFICATION_MUTE_FLAG(TRUE);

CALL my_budget!ADD_RESOURCE(SYSTEM$REFERENCE(
    'TABLE', 'EMP', 'SESSION', 'applybudget'));

SELECT SYSTEM$SHOW_BUDGETS_IN_ACCOUNT();
