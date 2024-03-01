import os, re
import configparser
from pathlib import Path
import snowflake.connector

# puts case-sensitive Snowflake names in double-quotes
def getName(name):
    name = name.replace('"', '')
    return name.lower() if re.match("^[A-Z_0-9]*$", name) != None else f'"{name}"'

def getRoles(roles, cur):
    if len(roles) == 0:
        s = ("  subgraph cluster_1 {\n"
            "    node [style=filled shape=Mrecord color=LightGray]\n"
            "    style=dashed;\n"
            "    label=roles\n\n")
        results = cur.execute("show roles").fetchall()
        for row in results:
            roles.append(str(row[1]))
        for name in roles:
            s += f"    {getName(name)};\n"
        return f"{s}  }}\n"
    else:
        s = "  node [style=filled shape=Mrecord color=LightGray]\n\n"
        for name in roles:
            s += f"  {getName(name)};\n"
        return s

def getRoleHierarchy(roles, cur):
    s = "\n"
    for role in roles:
        results = cur.execute(f'show grants to role "{role}"').fetchall()
        for row in results:
            if str(row[2]) == "ROLE" and str(row[1]) == "USAGE":
                role2 = str(row[3])
                s += f"  {getName(role)} -> {getName(role2)};\n"
    return s

def saveDotFile(filename, s):

    # save as DOT file
    with open(f"{filename}.dot", "w") as file:
        file.write(s)
    print(s)

    # with d3-graphviz
    # https://bl.ocks.org/magjac/4acffdb3afbc4f71b448a210b5060bca
    # https://github.com/magjac/d3-graphviz#creating-a-graphviz-renderer
    s = ('<!DOCTYPE html>\n'
        + '<meta charset="utf-8">\n'
        + '<body>'
        + '<script src="https://d3js.org/d3.v5.min.js"></script>\n'
        + '<script src="https://unpkg.com/@hpcc-js/wasm@0.3.11/dist/index.min.js"></script>\n'
        + '<script src="https://unpkg.com/d3-graphviz@3.0.5/build/d3-graphviz.js"></script>\n'
        + '<div id="graph" style="text-align: center;"></div>\n'
        + '<script>\n'
        + 'var graphviz = d3.select("#graph").graphviz()\n'
        + '   .on("initEnd", () => { graphviz.renderDot(d3.select("#digraph").text()); });\n'
        + '</script>\n'
        + '<div id="digraph" style="display:none;">\n'
        + s
        + '</div>\n')

    # save as HTML file
    with open(f"{filename}.html", "w") as file:
        file.write(s)

def main():

    # read profiles_db.conf
    parser = configparser.ConfigParser()
    parser.read("profiles_db.conf")
    section = "default"

    account = parser.get(section, "account")
    user = parser.get(section, "user")
    role = parser.get(section, "role")

    # change this to connect in a different way: SSO / PWD / KEY-PAIR
    connect_mode = "KEY-PAIR"
    con = connect(connect_mode, account, user, role)
    cur = con.cursor()

    # get metadata about users and roles
    users = []
    roles = []
    sroles = getRoles(roles, cur)
    sroles2 = getRoles(roles, cur)
    sroleh = getRoleHierarchy(roles, cur)
    con.close()

if __name__ == "__main__":
    main()
