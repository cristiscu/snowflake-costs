# 100 Snowflake Cost Optimization Techniques

All demo code for my Udemy course **100 Snowflake Cost Optimization Techniques!**. Refer to individual sections for local documentation.

## Project Setup

(1) Install and configure [*Visual Studio Code (VSCode)*](https://code.visualstudio.com/).  

(2) From VSCode *Extensions* tab, install the [*Snowflake Extension*](https://docs.snowflake.com/en/user-guide/vscode-ext).  

(3) Clone the current public *GitHub repository*, then open the newly created *snowflake-costs/* folder from VSCode:  

**`git clone https://github.com/cristiscu/snowflake-costs.git`**

(4) Install and use a [*Python version 3.9*](https://www.python.org/downloads/release/python-390/) for our project (as latest versions are not usually installed in Snowflake).  

(5) In a Terminal window from VSCode, create a *virtual environment* for this Python version. If you have multiple installations of Python on your computer, a path to python.exe may be required. My 3.9 version was installed in the *~\AppData\Local\Programs\Python\Python39\* folder, but yours could be elsewhere:  

**`~\AppData\Local\Programs\Python\Python39\python -m venv venv`**  

(6) A new *venv/* folder was created (and already added to *.gitignore*!). Select the new virtual environment (your prompt should get a *"(venv)"* prefix):  

**`venv/scripts/activate`**  

(7) Install all Python dependencies for this project with:  

**`pip install -r requirements.txt`**

(8) [Install SnowSQL](https://docs.snowflake.com/en/user-guide/snowsql-install-config).  

(9) Add in your *~\.snowsql\config* file your own Snowflake accountname and username, as connection parameters. Mine were:  
```
[connections.my_conn]
accountname = FHB91278
username = cristiscu
```

(10) Save your Snowflake account password in a *SNOWSQL_PWD* environment variable (that only you can see and have access to).  

(11) For each individual tip, switch to that specific tip folder from *tips/*, than take one of the following actions, depending on that specific use case:

* Copy and paste SQL file contents into Snowsight SQL Worksheets. Or run the SQL statements directly from this project, if you installed the Snowflake Extension.
* Execute Streamlit apps as local web applications, with commands like **`streamlit run app.py`**. Terminate the sessions with CTRL+C.
* Execute single Python files with commands like **`python app.py`**.