# 100 Snowflake Cost Optimization Techniques

## Virtual Warehouses

** Tip #1: Larger Virtual Warehouses May Actually Cost You Less  
** Tip #2: Auto-Suspend Any Warehouse After One Minute  
** Tip #3: Any Resumed Warehouse Will Cost You at Least One Minute  
** Tip #4: Never Auto-Suspend Any Warehouse After Less Than One Minute  
** Tip #5: X-Small Warehouses Could Be Powerful Enough  
** Tip #6: Resized Warehouses are for More Complex Queries  
** Tip #7: Multi-Cluster Warehouses are for Multiple Users and Concurrency  
** Tip #8: Multi-Cluster Warehouses Should Always Have Min Clusters 1  
** Tip #9: Use Economy Scaling Policy To Save Money  
** Tip #10: When to Use Snowpark-Optimized Warehouses  

## Compute Workloads

** Tip #11: Use Resource Monitors  
** Tip #12: Use Account-Level Budgets  
** Tip #13: Prevent Never-Ending Queries  
** Tip #14: Manually Kill Running Queries  
** Tip #15: Reduce Warehouse Sizes  
** Tip #16: Consolidate All Warehouses  
** Tip #17: Use Parallel Jobs for Batch Transformations  
** Tip #18: Avoid Checking Too Much on Metadata  
** Tip #19: Charts for Warehouse Monitoring  
** Tip #20: Revisit the Main Traps with Warehouses  

## Snowflake Accounts

** Tip #21: What to Choose for a Free Trial Account  
** Tip #22: When to Use a Free Trial Account  
** Tip #23: Understand Price Tables for Virtual Warehouse Compute Services  
** Tip #24: Understand Price Tables for Cloud and Serverless Services  
** Tip #25: Understand Price Tables for Storage and Data Transfer  
** Tip #26: Use the Account Overview Interface in Snowsight  
** Tip #27: Use Organization Accounts  
** Tip #28: Limit Warehouse Changes with Access Control  
** Tip #29: Adjust Default Values of Account-Level Parameters  
** Tip #30: Careful with Reader Accounts  
 
## Snowflake Editions

** Tip #31: When to Choose Enterprise over Standard Edition  
** Tip #32: How to Avoid Multi-Cluster Warehouses  
** Tip #33: When to Use Incremental Materializations  
** Tip #34: How to Emulate Materialized Views  
** Tip #35: The Case for Extended Time Travel  
** Tip #36: Use Standard Edition Account for Analytics  
** Tip #37: Use Separate Standard Edition Account for Common Queries  
** Tip #38: How to Reduce Costs to Zero for an Inactive Paid Account  
** Tip #39: When to Choose the Business Critical Edition  
** Tip #40: When to Choose the Virtual Private Snowflake (VPS) Edition  

## Query Monitoring

** Tip #41: Monitor Longest Running Queries  
** Tip #42: Interpret Query History  
** Tip #43: More Charts for Query Monitoring  
** Tip #44: Use Query Tags  
** Tip #45: Reduce Frequency of Simple Queries  
** Tip #46: Reduce Frequency of Metadata Queries  
** Tip #47: Reduce Frequency of SHOW Commands  
** Tip #48: Clone Less Frequently  
** Tip #49: Change Query Schedules  
** Tip #50: Parallel over Sequential Transfer and Processing  

## Query Optimization

** Tip #51: Use the Query Profile  
** Tip #52: Use the Explain Statement  
** Tip #53: Use Data Caching  
** Tip #54: Queries on Data Lakes  
** Tip #55: Use Vectorized Python UDFs  
** Tip #56: Use Batch Commands to Prevent Transaction Locks  
** Tip #57: Reduce Query Complexity and Compilation Time  
** Tip #58: Check for Cross Joins and Exploding Joins  
** Tip #59: Process Only New or Updated Data  
** Tip #60: Remote Spillage Optimization  
 
## Serverless Features

** Tip #61: Monitor the Cost of Automated Jobs  
** Tip #62: Estimate Cost of Scheduled Tasks  
** Tip #63: When to Use Serverless Tasks  
** Tip #64: Replace Snowpipe with Snowpipe Streaming  
** Tip #65: Estimate Cost of Automatic Clustering on Tables  
** Tip #66: Estimate Cost of the Query Acceleration Service (QAS)  
** Tip #67: Estimate Cost of the Search Optimization Service (SOS)  
** Tip #68: Reduce Materialized Views Maintenance Cost  
** Tip #69: Reduce Database Replication Cost  
** Tip #70: Estimate Cost of Hybrid Tables  

## Data Storage

** Tip #71: Use On-Demand Storage When You Don’t Know Your Spending Pattern  
** Tip #72: Copy and Keep Less Data  
** Tip #73: Lower Data Retention with No Time Travel  
** Tip #74: Estimate Storage Cost of the Fail-Safe  
** Tip #75: Use Transient or Temporary Tables  
** Tip #76: Use Zero-Copy Cloning  
** Tip #77: Clone Less Data  
** Tip #78: Ensure Tables Are Clustered Correctly  
** Tip #79: Drop Unused Tables and Other Objects  
** Tip #80: Remove Old Files from Stage Areas  

## Data Transfer

** Tip #81: Data In is Free, Data Out is Expensive  
** Tip #82: Choose the Same Provider and Region Where Your Data Is  
** Tip #83: External Access Integrations vs External Functions  
** Tip #84: Use Data Compression  
** Tip #85: Use Batch Transfer with Path Partitioning  
** Tip #86: Use Bulk Loads instead of Single-Row Inserts  
** Tip #87: Use Parallel Data Uploading  
** Tip #88: Design Cost-Effective Data Pipelines  
** Tip #89: Use External Tables in a Data Lake  
** Tip #90: Query Parquet Files instead of CSV  
 
## Snowflake Apps

** Tip #91: Estimate Cost Impact of Data Sharing in Snowflake  
** Tip #92: Estimate Cost Impact of Client and Server (Snowpark) Applications  
** Tip #93: Estimate Cost Impact of Streamlit in Snowflake and Native Applications  
** Tip #94: Estimate Cost Impact of Data Science Applications  
** Tip #95: Check All Connected Applications  
** Tip #96: Third-Party Apps Saving Money Will Spend Money  
** Tip #97: Free Marketplace Native Apps Will Cost Money  
** Tip #98: Keep App Versions Updated  
** Tip #99: Cache Data in Third-Party Tools  
** Tip #100: Auto-Abort Running Queries from Disconnected Apps  
